import 'dart:async';

import 'package:b21pdf/core/ads/ad_service.dart';
import 'package:b21pdf/core/ads/ad_scene.dart';
import 'package:b21pdf/core/ads/ad_placement.dart';
import 'package:b21pdf/core/events/app_event.dart';
import 'package:b21pdf/core/events/app_event_type.dart';
import 'package:b21pdf/core/events/app_event_bus.dart';
import 'package:b21pdf/core/navigation/app_navigator.dart';
import 'package:b21pdf/core/navigation/app_routes.dart';
import 'package:b21pdf/core/overlay/overlay_service.dart';
import 'package:b21pdf/features/startup/services/active_launch_source_service.dart';
import 'package:b21pdf/features/notifications/services/notification_service.dart';
import 'package:b21pdf/core/storage/preferences/last_open_ad_close_time.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';

class AppLifecycleService {
  AppLifecycleService._();

  static final AppLifecycleService instance = AppLifecycleService._();
  static const Duration _openAdLoadingTimeout = Duration(seconds: 16);
  int hotLaunchCooldownSeconds = 3;
  bool observerStarted = false, _appIsBack = false;
  bool _appIsForeground = true;
  bool _waitingForegroundLaunchSource = false;
  bool _suppressNextHotLaunch = false;
  bool _showingLifecycleAd = false;
  bool _openAdLoadingActive = false;

  bool get shouldSuppressClickHotLaunch =>
      !_appIsForeground || _appIsBack || _waitingForegroundLaunchSource;

  void suppressNextForegroundAd() {
    _log(
      'suppressNextForegroundAd foreground=$_appIsForeground '
      'appIsBack=$_appIsBack waitingSource=$_waitingForegroundLaunchSource',
    );
    _suppressNextHotLaunch = true;
    _appIsBack = false;
  }

  bool _consumeForegroundAdSuppression() {
    if (!_suppressNextHotLaunch) {
      return false;
    }
    _suppressNextHotLaunch = false;
    _appIsBack = false;
    ActiveLaunchSourceService.instance.clear();
    _log('foreground ad suppression consumed');
    return true;
  }

  void startObservingLifecycle() {
    if (observerStarted) {
      return;
    }
    observerStarted = true;
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (bool inBackground) {
          _log(
            'lifecycle callback inBackground=$inBackground '
            'foreground=$_appIsForeground appIsBack=$_appIsBack '
            'suppress=$_suppressNextHotLaunch',
          );
          AppEventBus.instance.publish(
            AppEvent(
              type: AppEventType.appLifecycle,
              intValue: inBackground ? 1 : 0,
            ),
          );
          if (inBackground) {
            _onAppBackgrounded();
          } else {
            unawaited(_onAppForegrounded());
          }
        },
      ),
    );
  }

  void _onAppBackgrounded() {
    _appIsForeground = false;
    _appIsBack = true;
    _log('entered background');
  }

  Future<void> _onAppForegrounded() async {
    _appIsForeground = true;
    _log(
      'foreground handler start appIsBack=$_appIsBack '
      'suppress=$_suppressNextHotLaunch',
    );
    OverlayService.instance.closeTimerOverlay();
    if (!_appIsBack && !_suppressNextHotLaunch) {
      _log('foreground handler skipped: no background transition');
      return;
    }
    if (_consumeForegroundAdSuppression()) {
      _log('foreground handler stopped: suppression before delay');
      return;
    }
    if (!_appIsBack) {
      _log('foreground handler stopped: appIsBack=false before delay');
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (_consumeForegroundAdSuppression()) {
      _log('foreground handler stopped: suppression after delay');
      return;
    }
    if (!_appIsBack) {
      _log('foreground handler stopped: appIsBack=false after delay');
      return;
    }

    final bool openedFromTimerOverlay = await _waitForForegroundClickSource();
    if (_consumeForegroundAdSuppression()) {
      _log('foreground handler stopped: suppression after source wait');
      return;
    }
    if (!_appIsBack) {
      _log('foreground handler stopped: appIsBack=false after source wait');
      return;
    }

    unawaited(NotificationService.instance.trackPendingNotificationEvents());
    final LaunchSource? source = ActiveLaunchSourceService.instance
        .consumeLaunchSource();
    if (_consumeForegroundAdSuppression()) {
      _log('foreground handler stopped: suppression after source consume');
      return;
    }
    _appIsBack = false;
    if (openedFromTimerOverlay) {
      _log('foreground handler trigger position=pr_open_pop');
      showLifecycleAd(AdScene.pr_launch, AdPlacement.pr_open_pop);
      return;
    }
    if (source == null) {
      _log('foreground handler trigger position=pr_open_hot');
      showLifecycleAd(AdScene.pr_launch, AdPlacement.pr_open_hot);
      return;
    }
    switch (source.type) {
      case LaunchSourceType.notification:
        _log('foreground handler notification source: no resume ad');
        return;
      case LaunchSourceType.quickAction:
        _log('foreground handler trigger position=unload_1');
        showLifecycleAd(AdScene.pr_exit, AdPlacement.unload_1);
    }
  }

  Future<bool> _waitForForegroundClickSource() async {
    _waitingForegroundLaunchSource = true;
    try {
      bool openedFromTimerOverlay = false;
      try {
        openedFromTimerOverlay =
            await FlutterBoomNotificationPlugins.instance
                .consumeTimerOverlayClickEvent() !=
            null;
      } catch (_) {}

      for (int index = 0; index < 10; index++) {
        if (_suppressNextHotLaunch) {
          break;
        }
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
      return openedFromTimerOverlay;
    } finally {
      _waitingForegroundLaunchSource = false;
    }
  }

  Future<void> showLifecycleAd(AdScene adScene, AdPlacement positionId) async {
    _log(
      'showLifecycleAd start scene=${adScene.name} '
      'position=${positionId.name} foreground=$_appIsForeground '
      'showing=$_showingLifecycleAd loading=$_openAdLoadingActive',
    );
    if (_showingLifecycleAd || _openAdLoadingActive || !_appIsForeground) {
      _log(
        'showLifecycleAd skipped: showing=$_showingLifecycleAd '
        'loading=$_openAdLoadingActive foreground=$_appIsForeground',
      );
      return;
    }
    _showingLifecycleAd = true;
    try {
      await _prepareAndShowLifecycleAd(adScene, positionId);
    } finally {
      _showingLifecycleAd = false;
      _log('showLifecycleAd finished position=${positionId.name}');
    }
  }

  Future<void> _prepareAndShowLifecycleAd(
    AdScene adScene,
    AdPlacement positionId,
  ) async {
    final FlutterPdfAdPlugins adPlugin = FlutterPdfAdPlugins.instance;
    if (!await _prepareCurrentFullScreenAd(adPlugin, positionId)) {
      _log(
        'showLifecycleAd stopped during fullscreen preparation '
        'position=${positionId.name} foreground=$_appIsForeground',
      );
      return;
    }

    final bool hasCachedAd = await AdService.instance.hasCachedAd(
      adScene: adScene,
      adPosId: positionId,
    );
    _log('cache result position=${positionId.name} cached=$hasCachedAd');
    if (!_appIsForeground) {
      _log('showLifecycleAd stopped after cache check: app is background');
      return;
    }
    if (hasCachedAd) {
      unawaited(
        _showCachedLifecycleAd(
          adScene: adScene,
          positionId: positionId,
          uploadChance: true,
          source: 'direct',
        ),
      );
      return;
    }

    if (AppNavigator.isCurrentRoute(AppRoutes.openAdLoadingRoute)) {
      _log('open-ad loading route already active');
      return;
    }
    AdService.instance.trackAdOpportunity(
      adScene: adScene,
      adPosId: positionId,
    );
    dynamic loadingResult;
    _openAdLoadingActive = true;
    try {
      final Future<dynamic>? loadingFuture = AppNavigator.pushNamed<dynamic>(
        routeName: AppRoutes.openAdLoadingRoute,
        arguments: <String, dynamic>{'adScene': adScene, 'adPosId': positionId},
      );
      if (loadingFuture == null) {
        _log('open-ad loading route was not opened');
        return;
      }
      _log('open-ad loading route opened position=${positionId.name}');
      try {
        loadingResult = await loadingFuture.timeout(
          _openAdLoadingTimeout,
          onTimeout: () {
            _log('open-ad loading route timed out position=${positionId.name}');
            if (AppNavigator.isCurrentRoute(AppRoutes.openAdLoadingRoute)) {
              AppNavigator.back<bool>(result: false);
            }
            return false;
          },
        );
      } catch (error) {
        _log(
          'open-ad loading route failed position=${positionId.name} '
          'error=$error',
        );
        if (AppNavigator.isCurrentRoute(AppRoutes.openAdLoadingRoute)) {
          AppNavigator.back<bool>(result: false);
        }
        return;
      }
    } finally {
      _openAdLoadingActive = false;
      _log('open-ad loading state released position=${positionId.name}');
    }

    final bool cacheReady = loadingResult == true;
    _log(
      'open-ad loading route finished position=${positionId.name} '
      'cacheReady=$cacheReady foreground=$_appIsForeground',
    );
    if (!cacheReady || !_appIsForeground) {
      _log(
        'showLifecycleAd stopped after loading route '
        'cacheReady=$cacheReady foreground=$_appIsForeground',
      );
      return;
    }
    await WidgetsBinding.instance.endOfFrame;
    if (!_appIsForeground) {
      _log('showLifecycleAd stopped after route pop: app is background');
      return;
    }

    if (!await _prepareCurrentFullScreenAd(adPlugin, positionId)) {
      _log(
        'showLifecycleAd stopped before loaded ad presentation '
        'position=${positionId.name}',
      );
      return;
    }
    unawaited(
      _showCachedLifecycleAd(
        adScene: adScene,
        positionId: positionId,
        uploadChance: false,
        source: 'loaded',
      ),
    );
  }

  Future<void> _showCachedLifecycleAd({
    required AdScene adScene,
    required AdPlacement positionId,
    required bool uploadChance,
    required String source,
  }) async {
    final bool? shown = await AdService.instance.showCachedAd(
      adScene: adScene,
      adPosId: positionId,
      uploadChance: uploadChance,
      ignoreCooldown: positionId != AdPlacement.pr_open_hot,
    );
    _log(
      '$source cached ad completed position=${positionId.name} shown=$shown',
    );
  }

  Future<bool> _prepareCurrentFullScreenAd(
    FlutterPdfAdPlugins adPlugin,
    AdPlacement positionId,
  ) async {
    if (!_appIsForeground) {
      _log(
        'fullscreen preparation skipped: app is background '
        'position=${positionId.name}',
      );
      return false;
    }
    if (positionId == AdPlacement.pr_open_hot) {
      final bool adShowing = adPlugin.isShowingAd();
      final bool cooldownActive = _isHotLaunchCooldownActive();
      if (adShowing || cooldownActive) {
        _log(
          'hot lifecycle ad skipped: adShowing=$adShowing '
          'cooldown=$cooldownActive',
        );
        return false;
      }
      return true;
    }
    if (!adPlugin.isShowingAd()) {
      _log('fullscreen preparation: no current ad to close');
      return true;
    }
    final bool closed = await adPlugin.closeFullScreenAdAndWait(
      timeout: const Duration(seconds: 3),
    );
    _log(
      'close current fullscreen result=$closed '
      'position=${positionId.name} foreground=$_appIsForeground',
    );
    return closed && _appIsForeground;
  }

  bool _isHotLaunchCooldownActive() {
    final int lastOpenAdCloseTime = LastOpenAdCloseTime.readTime();
    final int hotCooldownMs = hotLaunchCooldownSeconds * 1000;
    return DateTime.now().millisecondsSinceEpoch - lastOpenAdCloseTime <
        hotCooldownMs;
  }

  void _log(String message) {
    debugPrint('[AppLifecycle] $message');
  }
}
