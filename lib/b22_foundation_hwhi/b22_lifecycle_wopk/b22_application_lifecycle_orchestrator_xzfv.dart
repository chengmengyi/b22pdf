import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_interface_ypio/b22_open_ad_loading_qpmf/b22_launch_promotion_waiting_result_nlke.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_active_entry_origin_orchestrator_jesm.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';

enum B22LifecycleAdTriggerYgme { automatic, notification }

class B22ApplicationLifecycleOrchestratorPhic {
  B22ApplicationLifecycleOrchestratorPhic._();

  static final B22ApplicationLifecycleOrchestratorPhic b22InstanceGfkl =
      B22ApplicationLifecycleOrchestratorPhic._();

  int b22HotLaunchCooldownSecondsDqtg = 800;
  bool b22ObserverStartedBtps = false, b22AppIsBackBftd = false;
  bool b22AppIsForegroundHykg = true;
  bool b22SuppressNextHotLaunchMsev = false;
  bool b22HandlingForegroundPedo = false;
  bool b22HasPendingForegroundRyma = false;
  int b22LastBackgroundTimeTtpm = 0;
  int b22AdRequestSeedIjmx = 0;
  int? b22ActiveLoadingSessionIdGlwl;
  B22PromotionContextSuaj? b22ActiveLoadingSceneJhmg;
  B22PromotionSlotZwla? b22ActiveLoadingPosIdFqod;
  Future<void> b22AdTransitionFutureNisq = Future<void>.value();

  bool get shouldSuppressClickHotLaunch =>
      !b22AppIsForegroundHykg || b22AppIsBackBftd;

  void b22SuppressNextForegroundAdMmft() {
    b22SuppressNextHotLaunchMsev = true;
    b22AppIsBackBftd = false;
  }

  bool b22ConsumeForegroundAdSuppressionCveq() {
    if (!b22SuppressNextHotLaunchMsev) return false;
    b22SuppressNextHotLaunchMsev = false;
    b22AppIsBackBftd = false;
    B22ActiveEntryOriginOrchestratorIonc.instance.b22ClearXdnh();
    return true;
  }

  void b22StartObservingLifecycleJdlg() {
    if (b22ObserverStartedBtps) return;
    b22ObserverStartedBtps = true;
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (bool b22InBackgroundNmtj) {
          if (!b22InBackgroundNmtj) b22PrepareForForegroundEventZkrd();
          B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
            B22ApplicationSignalXfvp(
              b22TypeIafj: B22ApplicationSignalKindJiwh.b22AppLifecycleZpzc,
              b22IntValueVddo: b22InBackgroundNmtj ? 1 : 0,
            ),
          );
          if (b22InBackgroundNmtj) {
            b22OnAppBackgroundedRxpr();
          } else {
            unawaited(
              B22TelemetryOrchestratorNqon.instance.b22TrackSessionIhkh(),
            );
            B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
                .b22CloseTimerOverlayZifz();
            if (b22HandlingForegroundPedo) {
              b22HasPendingForegroundRyma = true;
            } else {
              unawaited(b22OnAppForegroundedKktk());
            }
          }
        },
      ),
    );
  }

  void b22OnAppBackgroundedRxpr() {
    b22AppIsForegroundHykg = false;
    b22AppIsBackBftd = true;
    b22LastBackgroundTimeTtpm = DateTime.now().millisecondsSinceEpoch;
  }

  void b22PrepareForForegroundEventZkrd() {
    b22AppIsForegroundHykg = true;
    final bool b22WillStartNewHotSessionOavy =
        b22AppIsBackBftd &&
        !b22SuppressNextHotLaunchMsev &&
        b22HasReachedHotLaunchCooldownQjkc();
    if (b22WillStartNewHotSessionOavy) b22AdRequestSeedIjmx++;
  }

  Future<void> b22OnAppForegroundedKktk() async {
    if (b22HandlingForegroundPedo) {
      b22HasPendingForegroundRyma = true;
      return;
    }
    b22HandlingForegroundPedo = true;
    b22AppIsForegroundHykg = true;
    try {
      if (!b22AppIsBackBftd && !b22SuppressNextHotLaunchMsev) return;
      await Future<void>.delayed(const Duration(milliseconds: 120));
      if (b22ConsumeForegroundAdSuppressionCveq()) return;
      if (!b22AppIsBackBftd || !b22AppIsForegroundHykg) return;

      unawaited(
        B22AlertOrchestratorNazk.b22InstanceOxzc
            .b22TrackPendingNotificationEventsAmrd(),
      );
      final B22EntryOriginTekr? b22SourceBsoy =
          B22ActiveEntryOriginOrchestratorIonc.instance
              .b22ConsumeLaunchSourceHmhd();
      if (b22ConsumeForegroundAdSuppressionCveq()) return;
      b22AppIsBackBftd = false;
      if (b22SourceBsoy == null) {
        unawaited(
          b22ShowLifecycleAdJfbv(
            B22PromotionContextSuaj.pr_launch,
            B22PromotionSlotZwla.pr_open_hot,
          ),
        );
        return;
      }
      switch (b22SourceBsoy.b22TypeSskh) {
        case B22EntryOriginKindOxpi.notification:
          return;
        case B22EntryOriginKindOxpi.quickAction:
          unawaited(
            b22ShowLifecycleAdJfbv(
              B22PromotionContextSuaj.pr_exit,
              B22PromotionSlotZwla.unload_1,
            ),
          );
      }
    } finally {
      b22HandlingForegroundPedo = false;
      final bool b22ShouldHandlePendingHqop =
          b22HasPendingForegroundRyma && !b22AppIsForegroundHykg;
      b22HasPendingForegroundRyma = false;
      if (b22ShouldHandlePendingHqop) {
        unawaited(b22OnAppForegroundedKktk());
      }
    }
  }

  Future<void> b22ShowLifecycleAdJfbv(
    B22PromotionContextSuaj b22AdSceneDpkx,
    B22PromotionSlotZwla b22PositionIdVgkp, {
    B22LifecycleAdTriggerYgme b22TriggerXecm =
        B22LifecycleAdTriggerYgme.automatic,
  }) async {
    final bool b22ShouldCheckCooldownRqmw =
        b22TriggerXecm == B22LifecycleAdTriggerYgme.automatic;
    final int b22HotLaunchDurationMsVqnt = b22HotLaunchDurationMsKqmw();
    if (b22ShouldCheckCooldownRqmw &&
        b22HotLaunchDurationMsVqnt >= 0 &&
        b22HotLaunchDurationMsVqnt < b22HotLaunchCooldownSecondsDqtg) {
      unawaited(
        B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
          b22PointTypeDrbi: B22TelemetrySignalDbrq.cd_hot,
          b22ParametersErwm: <String, dynamic>{
            'ad_context': b22AdSceneDpkx.name,
            'ad_pos_id': b22PositionIdVgkp.name,
            'timer': b22HotLaunchDurationMsVqnt,
          },
        ),
      );
      return;
    }
    if ((b22TriggerXecm == B22LifecycleAdTriggerYgme.automatic &&
            !b22AppIsForegroundHykg) ||
        !await B22PromotionOrchestratorAzwq.instance.b22IsPlacementEnabledWiqd(
          b22PositionIdVgkp,
        )) {
      return;
    }

    final int b22RequestIdVjfw = ++b22AdRequestSeedIjmx;
    final Future<void> b22PreviousTransitionLdee = b22AdTransitionFutureNisq;
    final Future<void> b22CurrentTransitionKwte = () async {
      await b22PreviousTransitionLdee;
      await b22ReplaceLifecycleAdSessionDhfa(
        b22RequestIdVjfw,
        b22AdSceneDpkx,
        b22PositionIdVgkp,
        b22TriggerXecm,
      );
    }();
    b22AdTransitionFutureNisq = b22CurrentTransitionKwte.then<void>(
      (_) {},
      onError: (_, _) {},
    );
    try {
      await b22CurrentTransitionKwte;
    } catch (_) {}
  }

  Future<void> b22ReplaceLifecycleAdSessionDhfa(
    int b22RequestIdVjfw,
    B22PromotionContextSuaj b22AdSceneDpkx,
    B22PromotionSlotZwla b22PositionIdVgkp,
    B22LifecycleAdTriggerYgme b22TriggerXecm,
  ) async {
    if (!b22CanProcessAdRequestYygs(b22RequestIdVjfw, b22TriggerXecm)) return;
    final FlutterPdfAdPlugins b22AdPluginZgtv = FlutterPdfAdPlugins.instance;
    if (b22AdPluginZgtv.isShowingAd()) {
      try {
        await b22AdPluginZgtv.closeFullScreenAdAndWait(
          timeout: const Duration(seconds: 3),
        );
      } catch (_) {}
      if (!b22CanProcessAdRequestYygs(b22RequestIdVjfw, b22TriggerXecm)) {
        return;
      }
    }

    if (B22ApplicationRouterJfva.b22IsCurrentRouteSsls(
      B22ApplicationDestinationsMcbk.b22OpenAdLoadingRouteQnvm,
    )) {
      B22ApplicationRouterJfva.b22BackCwkm<dynamic>(
        b22ResultNvsq: B22LaunchPromotionWaitingResultFqwa.cancelled(
          b22SessionIdZcsg: b22ActiveLoadingSessionIdGlwl ?? -1,
          b22ReasonPrxj: 'replaced_by_new_session',
          b22AdSceneAgkl: b22ActiveLoadingSceneJhmg,
          b22AdPosIdIaul: b22ActiveLoadingPosIdFqod,
        ),
      );
      await WidgetsBinding.instance.endOfFrame;
    }
    if (!b22CanProcessAdRequestYygs(b22RequestIdVjfw, b22TriggerXecm)) return;

    final int b22SessionIdUxbh = b22RequestIdVjfw;
    b22ActiveLoadingSessionIdGlwl = b22SessionIdUxbh;
    b22ActiveLoadingSceneJhmg = b22AdSceneDpkx;
    b22ActiveLoadingPosIdFqod = b22PositionIdVgkp;
    final Future<dynamic>? b22LoadingFutureXbop =
        B22ApplicationRouterJfva.b22PushNamedWarf<dynamic>(
          b22RouteNameHlpz:
              B22ApplicationDestinationsMcbk.b22OpenAdLoadingRouteQnvm,
          b22ArgumentsEnwl: <String, dynamic>{
            'adScene': b22AdSceneDpkx,
            'adPosId': b22PositionIdVgkp,
            'sessionId': b22SessionIdUxbh,
            'isForeground': b22AppIsForegroundHykg,
          },
        );
    if (b22LoadingFutureXbop == null) {
      b22ClearActiveLoadingSessionNmpo(b22SessionIdUxbh);
      return;
    }
    unawaited(
      b22HandleLoadingResultYyoh(
        b22LoadingFutureXbop,
        b22RequestIdVjfw,
        b22SessionIdUxbh,
        b22AdSceneDpkx,
        b22PositionIdVgkp,
      ),
    );
  }

  Future<void> b22HandleLoadingResultYyoh(
    Future<dynamic> b22LoadingFutureXbop,
    int b22RequestIdVjfw,
    int b22SessionIdUxbh,
    B22PromotionContextSuaj b22AdSceneDpkx,
    B22PromotionSlotZwla b22PositionIdVgkp,
  ) async {
    dynamic b22RawResultZmhp;
    try {
      b22RawResultZmhp = await b22LoadingFutureXbop;
    } catch (_) {
      b22ClearActiveLoadingSessionNmpo(b22SessionIdUxbh);
      return;
    }
    b22ClearActiveLoadingSessionNmpo(b22SessionIdUxbh);
    if (!b22CanShowAdRequestCzne(b22RequestIdVjfw) ||
        b22RawResultZmhp is! B22LaunchPromotionWaitingResultFqwa) {
      return;
    }
    final B22LaunchPromotionWaitingResultFqwa b22LoadingResultCsbr =
        b22RawResultZmhp;
    if (!b22LoadingResultCsbr.b22CacheReadyXzpp ||
        b22LoadingResultCsbr.b22SessionIdZcsg != b22SessionIdUxbh ||
        b22LoadingResultCsbr.b22AdSceneAgkl != b22AdSceneDpkx ||
        b22LoadingResultCsbr.b22AdPosIdIaul != b22PositionIdVgkp) {
      return;
    }
    await WidgetsBinding.instance.endOfFrame;
    if (!b22CanShowAdRequestCzne(b22RequestIdVjfw)) return;
    await B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
      b22AdSceneHfhk: b22AdSceneDpkx,
      b22AdPosIdEjxk: b22PositionIdVgkp,
      b22IgnoreCooldownGkwn: true,
      b22UploadChanceAhih: true,
    );
  }

  bool b22CanProcessAdRequestYygs(
    int b22RequestIdVjfw,
    B22LifecycleAdTriggerYgme b22TriggerXecm,
  ) =>
      b22RequestIdVjfw == b22AdRequestSeedIjmx &&
      (b22AppIsForegroundHykg ||
          b22TriggerXecm == B22LifecycleAdTriggerYgme.notification);

  bool b22CanShowAdRequestCzne(int b22RequestIdVjfw) =>
      b22RequestIdVjfw == b22AdRequestSeedIjmx && b22AppIsForegroundHykg;

  void b22ClearActiveLoadingSessionNmpo(int b22SessionIdUxbh) {
    if (b22ActiveLoadingSessionIdGlwl != b22SessionIdUxbh) return;
    b22ActiveLoadingSessionIdGlwl = null;
    b22ActiveLoadingSceneJhmg = null;
    b22ActiveLoadingPosIdFqod = null;
  }

  bool b22HasReachedHotLaunchCooldownQjkc() {
    final int b22HotLaunchDurationMsVqnt = b22HotLaunchDurationMsKqmw();
    return b22HotLaunchDurationMsVqnt < 0 ||
        b22HotLaunchDurationMsVqnt >= b22HotLaunchCooldownSecondsDqtg;
  }

  int b22HotLaunchDurationMsKqmw() {
    if (b22LastBackgroundTimeTtpm <= 0) return -1;
    final int b22DurationMsVqnt =
        DateTime.now().millisecondsSinceEpoch - b22LastBackgroundTimeTtpm;
    return b22DurationMsVqnt < 0 ? 0 : b22DurationMsVqnt;
  }
}
