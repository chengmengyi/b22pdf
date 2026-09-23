import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_active_entry_origin_orchestrator_jesm.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_recent_launch_promotion_close_timestamp_rgqv.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';

class B22ApplicationLifecycleOrchestratorPhic {
  B22ApplicationLifecycleOrchestratorPhic._();

  static final B22ApplicationLifecycleOrchestratorPhic b22InstanceGfkl =
      B22ApplicationLifecycleOrchestratorPhic._();
  static const Duration b22OpenAdLoadingTimeoutMbop = Duration(seconds: 16);
  int b22HotLaunchCooldownSecondsDqtg = 3;
  bool b22ObserverStartedBtps = false, b22AppIsBackBftd = false;
  bool b22AppIsForegroundHykg = true;
  bool b22WaitingForegroundLaunchSourceMqwl = false;
  bool b22SuppressNextHotLaunchMsev = false;
  bool b22ShowingLifecycleAdOfca = false;
  bool b22OpenAdLoadingActiveAnue = false;

  bool get shouldSuppressClickHotLaunch =>
      !b22AppIsForegroundHykg ||
      b22AppIsBackBftd ||
      b22WaitingForegroundLaunchSourceMqwl;

  void b22SuppressNextForegroundAdMmft() {
    b22LogRaft(
      'suppressNextForegroundAd foreground=$b22AppIsForegroundHykg '
      'appIsBack=$b22AppIsBackBftd waitingSource=$b22WaitingForegroundLaunchSourceMqwl',
    );
    b22SuppressNextHotLaunchMsev = true;
    b22AppIsBackBftd = false;
  }

  bool b22ConsumeForegroundAdSuppressionCveq() {
    if (!b22SuppressNextHotLaunchMsev) {
      return false;
    }
    b22SuppressNextHotLaunchMsev = false;
    b22AppIsBackBftd = false;
    B22ActiveEntryOriginOrchestratorIonc.instance.b22ClearXdnh();
    b22LogRaft('foreground ad suppression consumed');
    return true;
  }

  void b22StartObservingLifecycleJdlg() {
    if (b22ObserverStartedBtps) {
      return;
    }
    b22ObserverStartedBtps = true;
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (bool b22InBackgroundNmtj) {
          b22LogRaft(
            'lifecycle callback inBackground=$b22InBackgroundNmtj '
            'foreground=$b22AppIsForegroundHykg appIsBack=$b22AppIsBackBftd '
            'suppress=$b22SuppressNextHotLaunchMsev',
          );
          B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
            B22ApplicationSignalXfvp(
              b22TypeIafj: B22ApplicationSignalKindJiwh.b22AppLifecycleZpzc,
              b22IntValueVddo: b22InBackgroundNmtj ? 1 : 0,
            ),
          );
          if (b22InBackgroundNmtj) {
            b22OnAppBackgroundedRxpr();
          } else {
            unawaited(b22OnAppForegroundedKktk());
          }
        },
      ),
    );
  }

  void b22OnAppBackgroundedRxpr() {
    b22AppIsForegroundHykg = false;
    b22AppIsBackBftd = true;
    b22LogRaft('entered background');
  }

  Future<void> b22OnAppForegroundedKktk() async {
    b22AppIsForegroundHykg = true;
    b22LogRaft(
      'foreground handler start appIsBack=$b22AppIsBackBftd '
      'suppress=$b22SuppressNextHotLaunchMsev',
    );
    B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr.b22CloseTimerOverlayZifz();
    if (!b22AppIsBackBftd && !b22SuppressNextHotLaunchMsev) {
      b22LogRaft('foreground handler skipped: no background transition');
      return;
    }
    if (b22ConsumeForegroundAdSuppressionCveq()) {
      b22LogRaft('foreground handler stopped: suppression before delay');
      return;
    }
    if (!b22AppIsBackBftd) {
      b22LogRaft('foreground handler stopped: appIsBack=false before delay');
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (b22ConsumeForegroundAdSuppressionCveq()) {
      b22LogRaft('foreground handler stopped: suppression after delay');
      return;
    }
    if (!b22AppIsBackBftd) {
      b22LogRaft('foreground handler stopped: appIsBack=false after delay');
      return;
    }

    final bool b22OpenedFromTimerOverlayLits =
        await b22WaitForForegroundClickSourceFjxg();
    if (b22ConsumeForegroundAdSuppressionCveq()) {
      b22LogRaft('foreground handler stopped: suppression after source wait');
      return;
    }
    if (!b22AppIsBackBftd) {
      b22LogRaft(
        'foreground handler stopped: appIsBack=false after source wait',
      );
      return;
    }

    unawaited(
      B22AlertOrchestratorNazk.b22InstanceOxzc
          .b22TrackPendingNotificationEventsAmrd(),
    );
    final B22EntryOriginTekr? b22SourceBsoy =
        B22ActiveEntryOriginOrchestratorIonc.instance
            .b22ConsumeLaunchSourceHmhd();
    if (b22ConsumeForegroundAdSuppressionCveq()) {
      b22LogRaft(
        'foreground handler stopped: suppression after source consume',
      );
      return;
    }
    b22AppIsBackBftd = false;
    if (b22OpenedFromTimerOverlayLits) {
      b22LogRaft('foreground handler trigger position=pr_open_pop');
      b22ShowLifecycleAdJfbv(
        B22PromotionContextSuaj.pr_launch,
        B22PromotionSlotZwla.pr_open_pop,
      );
      return;
    }
    if (b22SourceBsoy == null) {
      b22LogRaft('foreground handler trigger position=pr_open_hot');
      b22ShowLifecycleAdJfbv(
        B22PromotionContextSuaj.pr_launch,
        B22PromotionSlotZwla.pr_open_hot,
      );
      return;
    }
    switch (b22SourceBsoy.b22TypeSskh) {
      case B22EntryOriginKindOxpi.b22NotificationIoxk:
        b22LogRaft('foreground handler notification source: no resume ad');
        return;
      case B22EntryOriginKindOxpi.b22QuickActionRagz:
        b22LogRaft('foreground handler trigger position=unload_1');
        b22ShowLifecycleAdJfbv(
          B22PromotionContextSuaj.pr_exit,
          B22PromotionSlotZwla.unload_1,
        );
    }
  }

  Future<bool> b22WaitForForegroundClickSourceFjxg() async {
    b22WaitingForegroundLaunchSourceMqwl = true;
    try {
      bool b22OpenedFromTimerOverlayMnmj = false;
      try {
        b22OpenedFromTimerOverlayMnmj =
            await FlutterBoomNotificationPlugins.instance
                .consumeTimerOverlayClickEvent() !=
            null;
      } catch (_) {}

      for (int b22IndexJpet = 0; b22IndexJpet < 10; b22IndexJpet++) {
        if (b22SuppressNextHotLaunchMsev) {
          break;
        }
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
      return b22OpenedFromTimerOverlayMnmj;
    } finally {
      b22WaitingForegroundLaunchSourceMqwl = false;
    }
  }

  Future<void> b22ShowLifecycleAdJfbv(
    B22PromotionContextSuaj b22AdSceneDpkx,
    B22PromotionSlotZwla b22PositionIdVgkp,
  ) async {
    b22LogRaft(
      'showLifecycleAd start scene=${b22AdSceneDpkx.name} '
      'position=${b22PositionIdVgkp.name} foreground=$b22AppIsForegroundHykg '
      'showing=$b22ShowingLifecycleAdOfca loading=$b22OpenAdLoadingActiveAnue',
    );
    if (b22ShowingLifecycleAdOfca ||
        b22OpenAdLoadingActiveAnue ||
        !b22AppIsForegroundHykg) {
      b22LogRaft(
        'showLifecycleAd skipped: showing=$b22ShowingLifecycleAdOfca '
        'loading=$b22OpenAdLoadingActiveAnue foreground=$b22AppIsForegroundHykg',
      );
      return;
    }
    b22ShowingLifecycleAdOfca = true;
    try {
      await b22PrepareAndShowLifecycleAdKzuo(b22AdSceneDpkx, b22PositionIdVgkp);
    } finally {
      b22ShowingLifecycleAdOfca = false;
      b22LogRaft('showLifecycleAd finished position=${b22PositionIdVgkp.name}');
    }
  }

  Future<void> b22PrepareAndShowLifecycleAdKzuo(
    B22PromotionContextSuaj b22AdSceneVkrv,
    B22PromotionSlotZwla b22PositionIdYguu,
  ) async {
    final FlutterPdfAdPlugins b22AdPluginVttr = FlutterPdfAdPlugins.instance;
    if (!await b22PrepareCurrentFullScreenAdXtbi(
      b22AdPluginVttr,
      b22PositionIdYguu,
    )) {
      b22LogRaft(
        'showLifecycleAd stopped during fullscreen preparation '
        'position=${b22PositionIdYguu.name} foreground=$b22AppIsForegroundHykg',
      );
      return;
    }

    final bool b22HasCachedAdVbyl = await B22PromotionOrchestratorAzwq.instance
        .b22HasCachedAdHtkf(
          b22AdSceneVfau: b22AdSceneVkrv,
          b22AdPosIdCcfi: b22PositionIdYguu,
        );
    b22LogRaft(
      'cache result position=${b22PositionIdYguu.name} cached=$b22HasCachedAdVbyl',
    );
    if (!b22AppIsForegroundHykg) {
      b22LogRaft(
        'showLifecycleAd stopped after cache check: app is background',
      );
      return;
    }
    if (b22HasCachedAdVbyl) {
      unawaited(
        b22ShowCachedLifecycleAdAdca(
          b22AdSceneXaee: b22AdSceneVkrv,
          b22PositionIdJcof: b22PositionIdYguu,
          b22UploadChanceKmnn: true,
          b22SourceJvxt: 'direct',
        ),
      );
      return;
    }

    if (B22ApplicationRouterJfva.b22IsCurrentRouteSsls(
      B22ApplicationDestinationsMcbk.b22OpenAdLoadingRouteQnvm,
    )) {
      b22LogRaft('open-ad loading route already active');
      return;
    }
    B22PromotionOrchestratorAzwq.instance.b22TrackAdOpportunityFbhf(
      b22AdSceneGiep: b22AdSceneVkrv,
      b22AdPosIdEbwa: b22PositionIdYguu,
    );
    dynamic b22LoadingResultDxwf;
    b22OpenAdLoadingActiveAnue = true;
    try {
      final Future<dynamic>? b22LoadingFutureYcxu =
          B22ApplicationRouterJfva.b22PushNamedWarf<dynamic>(
            b22RouteNameHlpz:
                B22ApplicationDestinationsMcbk.b22OpenAdLoadingRouteQnvm,
            b22ArgumentsEnwl: <String, dynamic>{
              'adScene': b22AdSceneVkrv,
              'adPosId': b22PositionIdYguu,
            },
          );
      if (b22LoadingFutureYcxu == null) {
        b22LogRaft('open-ad loading route was not opened');
        return;
      }
      b22LogRaft(
        'open-ad loading route opened position=${b22PositionIdYguu.name}',
      );
      try {
        b22LoadingResultDxwf = await b22LoadingFutureYcxu.timeout(
          b22OpenAdLoadingTimeoutMbop,
          onTimeout: () {
            b22LogRaft(
              'open-ad loading route timed out position=${b22PositionIdYguu.name}',
            );
            if (B22ApplicationRouterJfva.b22IsCurrentRouteSsls(
              B22ApplicationDestinationsMcbk.b22OpenAdLoadingRouteQnvm,
            )) {
              B22ApplicationRouterJfva.b22BackCwkm<bool>(b22ResultNvsq: false);
            }
            return false;
          },
        );
      } catch (b22ErrorDtmh) {
        b22LogRaft(
          'open-ad loading route failed position=${b22PositionIdYguu.name} '
          'error=$b22ErrorDtmh',
        );
        if (B22ApplicationRouterJfva.b22IsCurrentRouteSsls(
          B22ApplicationDestinationsMcbk.b22OpenAdLoadingRouteQnvm,
        )) {
          B22ApplicationRouterJfva.b22BackCwkm<bool>(b22ResultNvsq: false);
        }
        return;
      }
    } finally {
      b22OpenAdLoadingActiveAnue = false;
      b22LogRaft(
        'open-ad loading state released position=${b22PositionIdYguu.name}',
      );
    }

    final bool b22CacheReadyGfzn = b22LoadingResultDxwf == true;
    b22LogRaft(
      'open-ad loading route finished position=${b22PositionIdYguu.name} '
      'cacheReady=$b22CacheReadyGfzn foreground=$b22AppIsForegroundHykg',
    );
    if (!b22CacheReadyGfzn || !b22AppIsForegroundHykg) {
      b22LogRaft(
        'showLifecycleAd stopped after loading route '
        'cacheReady=$b22CacheReadyGfzn foreground=$b22AppIsForegroundHykg',
      );
      return;
    }
    await WidgetsBinding.instance.endOfFrame;
    if (!b22AppIsForegroundHykg) {
      b22LogRaft('showLifecycleAd stopped after route pop: app is background');
      return;
    }

    if (!await b22PrepareCurrentFullScreenAdXtbi(
      b22AdPluginVttr,
      b22PositionIdYguu,
    )) {
      b22LogRaft(
        'showLifecycleAd stopped before loaded ad presentation '
        'position=${b22PositionIdYguu.name}',
      );
      return;
    }
    unawaited(
      b22ShowCachedLifecycleAdAdca(
        b22AdSceneXaee: b22AdSceneVkrv,
        b22PositionIdJcof: b22PositionIdYguu,
        b22UploadChanceKmnn: false,
        b22SourceJvxt: 'loaded',
      ),
    );
  }

  Future<void> b22ShowCachedLifecycleAdAdca({
    required B22PromotionContextSuaj b22AdSceneXaee,
    required B22PromotionSlotZwla b22PositionIdJcof,
    required bool b22UploadChanceKmnn,
    required String b22SourceJvxt,
  }) async {
    final bool? b22ShownEovs = await B22PromotionOrchestratorAzwq.instance
        .b22ShowCachedAdZzrb(
          b22AdSceneHfhk: b22AdSceneXaee,
          b22AdPosIdEjxk: b22PositionIdJcof,
          b22UploadChanceAhih: b22UploadChanceKmnn,
          b22IgnoreCooldownGkwn:
              b22PositionIdJcof != B22PromotionSlotZwla.pr_open_hot,
        );
    b22LogRaft(
      '$b22SourceJvxt cached ad completed position=${b22PositionIdJcof.name} shown=$b22ShownEovs',
    );
  }

  Future<bool> b22PrepareCurrentFullScreenAdXtbi(
    FlutterPdfAdPlugins b22AdPluginGwku,
    B22PromotionSlotZwla b22PositionIdDqrg,
  ) async {
    if (!b22AppIsForegroundHykg) {
      b22LogRaft(
        'fullscreen preparation skipped: app is background '
        'position=${b22PositionIdDqrg.name}',
      );
      return false;
    }
    if (b22PositionIdDqrg == B22PromotionSlotZwla.pr_open_hot) {
      final bool b22AdShowingYqgv = b22AdPluginGwku.isShowingAd();
      final bool b22CooldownActiveZiyn = b22IsHotLaunchCooldownActiveXexz();
      if (b22AdShowingYqgv || b22CooldownActiveZiyn) {
        b22LogRaft(
          'hot lifecycle ad skipped: adShowing=$b22AdShowingYqgv '
          'cooldown=$b22CooldownActiveZiyn',
        );
        return false;
      }
      return true;
    }
    if (!b22AdPluginGwku.isShowingAd()) {
      b22LogRaft('fullscreen preparation: no current ad to close');
      return true;
    }
    final bool b22ClosedJxpq = await b22AdPluginGwku.closeFullScreenAdAndWait(
      timeout: const Duration(seconds: 3),
    );
    b22LogRaft(
      'close current fullscreen result=$b22ClosedJxpq '
      'position=${b22PositionIdDqrg.name} foreground=$b22AppIsForegroundHykg',
    );
    return b22ClosedJxpq && b22AppIsForegroundHykg;
  }

  bool b22IsHotLaunchCooldownActiveXexz() {
    final int b22LastOpenAdCloseTimeVesl =
        B22RecentLaunchPromotionCloseTimestampVfuy.b22ReadTimeYbbo();
    final int b22HotCooldownMsVtla = b22HotLaunchCooldownSecondsDqtg * 1000;
    return DateTime.now().millisecondsSinceEpoch - b22LastOpenAdCloseTimeVesl <
        b22HotCooldownMsVtla;
  }

  void b22LogRaft(String b22MessageHztp) {
    debugPrint('[AppLifecycle] $b22MessageHztp');
  }
}
