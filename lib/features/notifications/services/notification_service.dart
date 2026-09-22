import 'dart:async';
import 'dart:convert';

import 'package:b21pdf/core/storage/preferences/locale_selected.dart';
import 'package:b21pdf/core/ads/ad_scene.dart';
import 'package:b21pdf/core/ads/ad_placement.dart';
import 'package:b21pdf/core/lifecycle/app_lifecycle_service.dart';
import 'package:b21pdf/core/user/user_eligibility_service.dart';
import 'package:b21pdf/core/firebase/firebase_service.dart';
import 'package:b21pdf/features/startup/services/initial_launch_source_service.dart';
import 'package:b21pdf/core/config/app_config.dart';
import 'package:b21pdf/features/startup/services/startup_interaction_gate.dart';
import 'package:b21pdf/core/analytics/analytics_event.dart';
import 'package:b21pdf/core/analytics/analytics_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  bool _initialized = false;

  Future<void> initialize({bool requestPermission = false}) async {
    if (_initialized) {
      return;
    }
    final bool canInitialize = await _isInitializationAllowed();
    if (!canInitialize) {
      return;
    }
    _initializeListeners();
    await _initializeLocalInfo();
    await _initializeTbaInfo();
    updateNewFileNotificationText();
    await _scheduleLocalNotifications();
    _initializeFcm();
    await _initializeBroadcasts();
    await initializeMediaNotification();
    _initializeShortcutNotification();
    _initialized = true;
    if (requestPermission) {
      await Permission.notification.request();
      AnalyticsService.instance.trackEvent(
        pointType: AnalyticsEvent.storage_system_result,
        parameters: {"open": (await hasNotificationPermission()) ? 1 : 0},
      );
      AnalyticsService.instance.trackEvent(
        pointType: AnalyticsEvent.push_guide_view,
        parameters: {"show_type": "system"},
      );
    }
  }

  Future<bool> hasNotificationPermission() async {
    var permissionStatus = await Permission.notification.status;
    var isGranted = permissionStatus.isGranted || permissionStatus.isLimited;
    return isGranted;
  }

  Future<void> _initializeTbaInfo() async {
    final Map<String, String> headerMap = Map<String, String>.from(
      await AnalyticsService.instance.buildRequestHeaders(),
    );
    final String requestUrl = await AnalyticsService.instance.buildEndpointUrl();
    final Map<String, dynamic> pushPayload = await AnalyticsService.instance
        .createEventPayload(
          pointType: AnalyticsEvent.push,
          parameters: {'sourse': "local"},
        );
    FlutterBoomNotificationPlugins.instance.configureNativePushReporting(
      enabled: true,
      url: requestUrl,
      headers: headerMap,
      payloadTemplate: pushPayload,
      distinctIdKey: "puffin",
      logIdKey: "heart",
      clientTsKey: "infernal",
      notificationSourceKey: "sourse#mit",
      packageKey: "caribou",
    );
  }

  void _initializeShortcutNotification() {
    FlutterBoomNotificationPlugins.instance.showPersistentShortcutNotification(
      homeText: 'Home'.tr,
      mergeText: 'Scan'.tr,
      importText: 'Word To PDF'.tr,
      convertText: 'Image To PDF'.tr,
      homeIcon: 'home_func',
      mergeIcon: 'scan_func',
      importIcon: 'word_func',
      convertIcon: 'image_func',
    );
  }

  Future<void> initializeMediaNotification() async {
    final bool canInitialize = await _isInitializationAllowed();
    if (!canInitialize) {
      return;
    }
    FlutterBoomNotificationPlugins.instance.periodicallyShowMediaWithDuration(
      reflectionConfig: MediaReflectionConfig(
        secret: AppConfig.secretKey,
        mediaSessionClass: 'v1:tzRdnGgpoMC1xk/6:RleMSswMfsziCXT/FEGyijN8yq+fZPM3YkfE88/7snfb//xZU47ySsUck2cifoLdnxDeoNEWFZcgeUjotfiyRReTvA==',
        mediaSessionTokenClass: 'v1:QvrLJahVOEZAwvkq:/hn4yiBrSm4YvnFPDrhA/e9pb+T9d+oLVL5r1fvZ4YuM3Ivai4mlIPYItnYAsrZfFX+b6ehmeamQRUcMV9pN7WqpoHlZn7A1XQ==',
        mediaSessionTag: 'v1:OOQbTkU9pLW+3hR5:MUxRAxlwBG9gZxzd2GixL0pEeQduHA4keMZzYW37JQ==',
        playbackStateClass: 'v1:ucXlHz9K6HoMpdJC:q8RY+MCYZr2vehFXecUFtwoRCIQCpEI7xRGEFr46GusLoD7Q1FFKQPVnOrOHG2mxhFB2nnEJDzM3rgWkTNxoA/qZacM=',
        playbackStateBuilderClass: 'v1:3B7Xd9gR6QdLda/s:b0t6jv4Iyak9Jzi2tDLJ76WEXKfgSYy/uKFL0WZs28E59gnK48MvRy0XJSLev9P+kogurH+rg6hOxqU6naQn7XYxo9jdRl8nwDiW6w==',
        mediaStyleClass: 'v1:fMBMaPWtmhI8pUEs:B/rBNX44FqsXacd123g562OcUY/eS6OdBQzDvjTU4H+1d//DRjbHqcxNN4v1AEd0e/Dci/cfUEory4G+cbFzsg==',
        setFlagsMethod: 'v1:XsxTfTYQTwEZX6a+:mQy2wEZpl8b2wOLf9N/LEE937H1kXNt0',
        setActiveMethod: 'v1:3xZxeS2EMiC4V7HC:s0fWVsgJEr+DR41phURA1PNzX+5g63lkRQ==',
        setPlaybackStateMethod: 'v1:U2rKs8VK1Yf4wouE:JN77zixNf84H5NAycxqVlKun963OOlN7RcxE1wIw1KY=',
        getSessionTokenMethod: 'v1:TDWbUhkrlEZlJgvB:tf/9P7jCaAwO/Y62ydS3eSFYhmsaeb5QHSJWQFq8XA==',
        setStateMethod: 'v1:5ksEfdO5Uk/FBkEk:zregmuJWbI6c0QYF3LliijrRnjIqBnCx',
        buildMethod: 'v1:bk70WU+pOSMDClRO:Bm3XIFH/JgvuIdoTzXXRjDUV9K4t',
        setMediaSessionMethod: 'v1:DNKfh7mS0aDYbgZA:1uNdA4lk6+63gjRvRu8yqih1UWXMboUGOIYulcbXoQ==',
      ),
      mediaBackgroundImageName: 'large_notice_picture',
    );
  }

  Future<void> _initializeBroadcasts() async {
    FlutterBoomNotificationPlugins.instance.registerBroadcastNotifications();
  }

  void _initializeFcm() {
    FlutterBoomNotificationPlugins.instance.subscribeToTopic(
      channelId: 'fcm_notice_channel',
      channelName: 'fcm_notice_channel_name',
      priority: Priority.max,
      importance: Importance.max,
      style: 'beauty',
      beautyButton: 'Claim',
    );
  }

  Future<void> _scheduleLocalNotifications() async {
    FlutterBoomNotificationPlugins.instance.periodicallyShowLocalWithDuration();
  }

  void updateNewFileNotificationText() {
    FlutterBoomNotificationPlugins.instance.setGalleryImageNotificationInfo(
      title: 'You have a new file.'.tr,
    );
  }

  Future<void> _initializeLocalInfo() async {
    await FlutterBoomNotificationPlugins.instance.initNotification(
      icon: 'small_logo',
      channelId: 'notice_channel',
      channelName: 'notice_channel_name',
      channelDescription: 'PDF notifications',
      customLayout: AndroidCustomNotificationLayout(
        smallLayoutName: 'small_notice_layout',
        bigLayoutName: 'large_notice_layout',
        actionText: 'Check'.tr,
      ),
      showMedia: true,
      config: await _buildNotificationConfig(),
    );
  }

  Future<NotificationInitConfig> _buildNotificationConfig() async {
    final String defaultNotificationConfig = await rootBundle.loadString(
      AppConfig.defaultNotificationConfig,
    );
    final String fieldMappingConfig = await rootBundle.loadString(
      AppConfig.fieldMappingConfig,
    );
    var deviceLanguage = "", countryCode = "";
    var languageXpe = LocaleSelected.readLanguage();
    if (languageXpe.isNotEmpty) {
      try {
        var list = languageXpe.split("-");
        deviceLanguage = list.first;
        countryCode = list.last;
      } catch (_) {}
    }
    if (deviceLanguage.isEmpty) {
      deviceLanguage = await FlutterBoomNotificationPlugins.instance
          .getDeviceLanguage();
    }
    if (countryCode.isEmpty) {
      countryCode = await FlutterBoomNotificationPlugins.instance
          .getCountryCode();
    }
    return NotificationInitConfig(
      defaultConfig: defaultNotificationConfig,
      request: NotificationConfigRequest(
        url: AppConfig.notificationConfigUrl,
        headers: {
          "fwfns": kDebugMode
              ? "com.filevera.pdftool"
              : await FlutterTbaInfo.instance.getBundleId(),
          "ihtw": kDebugMode
              ? "0.0.1"
              : await FlutterTbaInfo.instance.getAppVersion(),
        },
        body: {
          "ebSBfnD": deviceLanguage,
          "IEajB": await FlutterTbaInfo.instance.getDistinctId(),
          "jpgRQUSwW": countryCode,
        },
      ),
      fieldMapping: jsonDecode(fieldMappingConfig),
    );
  }

  void _initializeListeners() {
    FlutterBoomNotificationPlugins.instance.setListeners(
      onNotificationClicked: (LocalNotificationEvent event) {
        final AppLifecycleService lifecycleService =
            AppLifecycleService.instance;
        if (lifecycleService.shouldSuppressClickHotLaunch) {
          lifecycleService.suppressNextForegroundAd();
        }
        if (!StartupInteractionGate.instance.canHandleNotificationClick) {
          return;
        }
        final String payload = event.payload ?? event.payloadType?.name ?? '';
        _trackNotificationClick(payload);
        unawaited(
          lifecycleService.showLifecycleAd(
            AdScene.pr_launch,
            payload == 'media'
                ? AdPlacement.pr_open_mediapop
                : AdPlacement.pr_open_noti,
          ),
        );
      },
      onNotificationDisplayed: (LocalNotificationEvent event) {
        _trackNotificationImpression(
          event.payload ?? event.payloadType?.name ?? '',
        );
      },
      onTimerOverlayClicked: _handleTimerOverlayClick,
      onProcessingOverlayClicked: _handleProcessingOverlayClick,
    );
  }

  void _handleTimerOverlayClick(TimerOverlayClickEvent event) {
    if (!StartupInteractionGate.instance.canHandleNotificationClick) return;
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.float_click,
      parameters: <String, dynamic>{'float_type': event.clickType},
    );
    final AppLifecycleService lifecycleService = AppLifecycleService.instance;
    if (lifecycleService.shouldSuppressClickHotLaunch) {
      lifecycleService.suppressNextForegroundAd();
    }
    unawaited(
      FlutterBoomNotificationPlugins.instance.consumeTimerOverlayClickEvent(),
    );
    unawaited(
      lifecycleService.showLifecycleAd(
        AdScene.pr_launch,
        AdPlacement.pr_open_pop,
      ),
    );
  }

  void _handleProcessingOverlayClick() {
    if (!StartupInteractionGate.instance.canHandleNotificationClick) return;
    final AppLifecycleService lifecycleService = AppLifecycleService.instance;
    if (lifecycleService.shouldSuppressClickHotLaunch) {
      lifecycleService.suppressNextForegroundAd();
    }
    unawaited(
      lifecycleService.showLifecycleAd(
        AdScene.pr_launch,
        AdPlacement.pr_open_hot,
      ),
    );
  }

  Future<void> refreshNotificationLanguage() async {
    final bool canInitialize = await _isInitializationAllowed();
    if (!canInitialize) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance.refreshNotificationConfig(
      config: await _buildNotificationConfig(),
    );
    _initializeShortcutNotification();
    updateNewFileNotificationText();
  }

  Future<void> showAdFollowUpNotification() async {
    final bool canInitialize = await _isInitializationAllowed();
    if (!canInitialize) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance.show(
      id: _generateNotificationId(),
      title: "Continue viewing PDF".tr,
      body: "Continue viewing PDF".tr,
      payload: LocalNotificationPayload.local,
    );
  }

  int _generateNotificationId() {
    return DateTime.now().microsecondsSinceEpoch % 2147483647;
  }

  void trackInitialNotificationEvent() {
    final TimerOverlayClickEvent? timerOverlayClickEvent =
        InitialLaunchSourceService.instance.timerOverlayClickEvent;
    if (timerOverlayClickEvent != null) {
      AnalyticsService.instance.trackEvent(
        pointType: AnalyticsEvent.float_click,
        parameters: <String, dynamic>{
          'float_type': timerOverlayClickEvent.clickType,
        },
      );
    }
    if (InitialLaunchSourceService.instance.notificationPayload != null) {
      _trackNotificationClick(
        InitialLaunchSourceService.instance.notificationPayload ?? '',
      );
    }
    trackPendingNotificationEvents();
  }

  Future<void> trackPendingNotificationEvents() async {
    for (final LocalNotificationPayload payload
        in LocalNotificationPayload.values) {
      final int displayedCount = await FlutterBoomNotificationPlugins.instance
          .consumeDisplayedNotificationCount(payload: payload);
      if (displayedCount > 0) {
        for (int index = 0; index < displayedCount; index++) {
          _trackNotificationImpression(payload.value);
        }
      }
    }
  }

  void _trackNotificationClick(String? eventSource) {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.inform_c,
      parameters: {'sourse': eventSource},
    );
  }

  void _trackNotificationImpression(String eventSource) {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.push,
      parameters: {'sourse': eventSource},
    );
  }

  Future<bool> _isInitializationAllowed() async {
    if (!UserEligibilityService.instance.isEligibleUser) {
      return false;
    }
    final bool samsungDevice = await FlutterBoomNotificationPlugins.instance
        .isSamsungDevice();
    final bool koreanLocale = await FlutterBoomNotificationPlugins.instance
        .isKoreanLocale();
    if (samsungDevice &&
        koreanLocale &&
        !FirebaseService.instance.supportsKoreanNotifications) {
      return false;
    }
    return true;
  }
}
