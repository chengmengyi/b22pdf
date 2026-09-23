import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_lifecycle_wopk/b22_application_lifecycle_orchestrator_xzfv.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_first_entry_origin_orchestrator_wwrf.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_entry_input_gate_qzrn.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_operations_xopv/b22_first_run_director_xcwj.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_shortcuts_itti/b22_operations_iwxd/b22_quick_action_orchestrator_ijhz.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';
import 'package:get/get.dart';

class B22EntryCoordinatorVdiw extends B22FoundationCoordinatorXsba
    with GetSingleTickerProviderStateMixin {
  static const String b22ProgressUpdateIdKlmp = 'startup_progress';
  static const Duration b22LaunchDurationKekw = Duration(seconds: 15);

  late final AnimationController b22ProgressControllerNcpn;
  late B22PromotionContextSuaj b22LaunchAdScenePyys;
  late B22PromotionSlotZwla b22LaunchAdPosIdAflz;
  Duration b22NewUserOpenAdCheckTimeJazf = const Duration(seconds: 12);
  bool b22NavigationStartedUwpx = false;

  final Stopwatch b22AdCheckStopwatchYrfm = Stopwatch();
  Timer? b22AdCheckTimerJwcx;
  bool b22CheckingAdEqsy = false;
  bool b22InBackgroundIdgg = false;

  double get progressValue => b22ProgressControllerNcpn.value;

  bool get _useNewLaunchAd =>
      B22PromotionOrchestratorAzwq.instance.b22LoadNewLaunchAdSxft;

  @override
  void onInit() {
    super.onInit();
    unawaited(
      B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
          .b22InitializeTimerOverlayLofh(),
    );
    unawaited(
      B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
          .b22ShowProgressOverlayIcnd(),
    );
    B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr.b22CloseTimerOverlayZifz();
    B22EntryInputGateKjfv.b22InstanceHthn.b22MarkLauncherStartedEvur();
    b22ResolveLaunchAdContextXxii();
    B22PromotionOrchestratorAzwq.instance.b22TrackAdOpportunityFbhf(
      b22AdSceneGiep: b22LaunchAdScenePyys,
      b22AdPosIdEbwa: b22LaunchAdPosIdAflz,
    );
    b22ProgressControllerNcpn =
        AnimationController(vsync: this, duration: b22LaunchDurationKekw)
          ..addListener(b22NotifyProgressChangedWvvl)
          ..addStatusListener(b22OnProgressAnimationStatusChangedRoew)
          ..forward();
    b22AdCheckStopwatchYrfm.start();
    b22AdCheckTimerJwcx = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) => b22CheckLaunchAdCacheEytn(),
    );
  }

  void b22ResolveLaunchAdContextXxii() {
    if (_useNewLaunchAd) {
      b22LaunchAdScenePyys = B22PromotionContextSuaj.pr_new_launch;
      b22LaunchAdPosIdAflz = B22PromotionSlotZwla.pr_new_open;
      return;
    }

    if (B22FirstEntryOriginOrchestratorJicy
            .instance
            .b22TimerOverlayClickEventEvqt !=
        null) {
      b22LaunchAdScenePyys = B22PromotionContextSuaj.pr_launch;
      b22LaunchAdPosIdAflz = B22PromotionSlotZwla.pr_open_pop;
      return;
    }

    final String b22NotificationPayloadIrir =
        B22FirstEntryOriginOrchestratorJicy
            .instance
            .b22NotificationPayloadStff ??
        '';
    if (b22NotificationPayloadIrir.isNotEmpty) {
      b22LaunchAdScenePyys = B22PromotionContextSuaj.pr_launch;
      b22LaunchAdPosIdAflz =
          b22NotificationPayloadIrir == LocalNotificationPayload.media.value
          ? B22PromotionSlotZwla.pr_open_mediapop
          : B22PromotionSlotZwla.pr_open_noti;
      return;
    }

    final String b22QuickActionTypeWarf =
        B22FirstEntryOriginOrchestratorJicy.instance.b22QuickActionTypeMaov ??
        '';
    if (b22QuickActionTypeWarf.isNotEmpty) {
      b22LaunchAdScenePyys = B22PromotionContextSuaj.pr_exit;
      b22LaunchAdPosIdAflz = B22PromotionSlotZwla.unload_1;
      return;
    }

    b22LaunchAdScenePyys = B22PromotionContextSuaj.pr_launch;
    b22LaunchAdPosIdAflz = B22PromotionSlotZwla.pr_open_cold;
  }

  void b22NotifyProgressChangedWvvl() {
    update([b22ProgressUpdateIdKlmp]);
  }

  void b22OnProgressAnimationStatusChangedRoew(AnimationStatus b22StatusVikb) {
    if (b22StatusVikb != AnimationStatus.completed ||
        b22NavigationStartedUwpx) {
      return;
    }
    b22NavigationStartedUwpx = true;
    b22AdCheckTimerJwcx?.cancel();
    b22HandleLaunchAdDeadlineNerr();
  }

  Future<void> b22CheckLaunchAdCacheEytn() async {
    if (b22NavigationStartedUwpx || b22InBackgroundIdgg || b22CheckingAdEqsy) {
      return;
    }
    b22CheckingAdEqsy = true;
    final B22PromotionContextSuaj b22ScenePkuo = b22ResolveCurrentAdSceneFiij();
    final B22PromotionSlotZwla b22PosIdQuxs = b22ResolvePlacementForSceneYray(
      b22ScenePkuo,
    );
    final bool b22HasAdMcew = await b22HasCachedLaunchAdJbhr(b22ScenePkuo);
    b22CheckingAdEqsy = false;
    if (!b22HasAdMcew || b22NavigationStartedUwpx) {
      return;
    }
    b22NavigationStartedUwpx = true;
    await b22ShowResolvedLaunchAdZpyq(b22ScenePkuo, b22PosIdQuxs);
  }

  B22PromotionContextSuaj b22ResolveCurrentAdSceneFiij() {
    if (_useNewLaunchAd &&
        b22AdCheckStopwatchYrfm.elapsed < b22NewUserOpenAdCheckTimeJazf) {
      return B22PromotionContextSuaj.pr_new_launch;
    }
    if (_useNewLaunchAd) {
      return B22PromotionContextSuaj.pr_launch;
    }
    return b22LaunchAdScenePyys;
  }

  B22PromotionSlotZwla b22ResolvePlacementForSceneYray(
    B22PromotionContextSuaj b22SceneKclu,
  ) {
    if (b22SceneKclu == B22PromotionContextSuaj.pr_new_launch) {
      return B22PromotionSlotZwla.pr_new_open;
    }
    if (_useNewLaunchAd && b22SceneKclu == B22PromotionContextSuaj.pr_launch) {
      return B22PromotionSlotZwla.pr_open_cold;
    }
    return b22LaunchAdPosIdAflz;
  }

  Future<bool> b22HasCachedLaunchAdJbhr(
    B22PromotionContextSuaj b22ScenePyjc,
  ) async {
    try {
      final AdInfoBean? b22CachedAdYpnv = await FlutterPdfAdPlugins.instance
          .getAvailableCachedAdInfo<B22PromotionContextSuaj>(b22ScenePyjc);
      return b22CachedAdYpnv != null;
    } catch (_) {
      return false;
    }
  }

  Future<void> b22HandleLaunchAdDeadlineNerr() async {
    if (_useNewLaunchAd) {
      if (b22NewUserOpenAdCheckTimeJazf >= b22LaunchDurationKekw) {
        final bool b22HasNewAdNsbc = await b22HasCachedLaunchAdJbhr(
          B22PromotionContextSuaj.pr_new_launch,
        );
        if (b22HasNewAdNsbc) {
          await b22ShowResolvedLaunchAdZpyq(
            B22PromotionContextSuaj.pr_new_launch,
            B22PromotionSlotZwla.pr_new_open,
          );
          return;
        }
      }
      final bool b22HasFallbackAdMtog = await b22HasCachedLaunchAdJbhr(
        B22PromotionContextSuaj.pr_launch,
      );
      if (b22HasFallbackAdMtog) {
        await b22ShowResolvedLaunchAdZpyq(
          B22PromotionContextSuaj.pr_launch,
          B22PromotionSlotZwla.pr_open_cold,
        );
        return;
      }
    } else if (await b22HasCachedLaunchAdJbhr(b22LaunchAdScenePyys)) {
      await b22ShowResolvedLaunchAdZpyq(
        b22LaunchAdScenePyys,
        b22LaunchAdPosIdAflz,
      );
      return;
    }
    await b22CompleteStartupMeot();
  }

  Future<void> b22ShowResolvedLaunchAdZpyq(
    B22PromotionContextSuaj b22SceneFpbc,
    B22PromotionSlotZwla b22PosIdXfky,
  ) async {
    b22AdCheckTimerJwcx?.cancel();
    b22AdCheckStopwatchYrfm.stop();
    if (b22ProgressControllerNcpn.isAnimating) {
      b22ProgressControllerNcpn.stop(canceled: false);
    }
    B22EntryInputGateKjfv.b22InstanceHthn.b22MarkLauncherAdWaitingYngv(
      b22AdSceneJmez: b22SceneFpbc,
      b22AdPosIdGbme: b22PosIdXfky,
    );
    final bool? b22DidShowAdCmci = await B22PromotionOrchestratorAzwq.instance
        .b22ShowCachedAdZzrb(
          b22AdSceneHfhk: b22SceneFpbc,
          b22AdPosIdEjxk: b22PosIdXfky,
          b22UploadChanceAhih: false,
        );
    if (b22DidShowAdCmci != true) {
      B22EntryInputGateKjfv.b22InstanceHthn.b22MarkLauncherAdNotShownPbqz();
    }
    await b22CompleteStartupMeot();
  }

  Future<void> b22CompleteStartupMeot() async {
    B22PromotionOrchestratorAzwq.instance.b22PreloadSceneQjfv(
      B22PromotionContextSuaj.pr_user_use,
    );
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AppLaunchResultPqnd,
    );
    var b22ResultMtpd = await B22QuickActionOrchestratorYmez.instance
        .b22HandlePendingColdStartShortcutVffa();
    if (b22ResultMtpd) {
      return;
    }
    B22FirstRunDirectorYxjn.instance.b22OpenOverlaySelectionRoen();
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  // ignore: avoid_renaming_method_parameters
  void onAppEvent(B22ApplicationSignalXfvp b22EventIusf) {
    if (b22EventIusf.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22NewOpenAdCheckTimeCqpg) {
      final int b22SecondsOqcm = b22EventIusf.b22IntValueVddo ?? 0;
      if (b22SecondsOqcm > 0) {
        b22NewUserOpenAdCheckTimeJazf = Duration(seconds: b22SecondsOqcm);
      }
      return;
    }
    if (b22EventIusf.b22TypeIafj !=
        B22ApplicationSignalKindJiwh.b22AppLifecycleZpzc) {
      return;
    }
    b22InBackgroundIdgg = b22EventIusf.b22IntValueVddo == 1;
    if (b22InBackgroundIdgg) {
      b22AdCheckStopwatchYrfm.stop();
      b22ProgressControllerNcpn.stop(canceled: false);
    } else {
      b22AdCheckStopwatchYrfm.start();
      if (!b22ProgressControllerNcpn.isCompleted &&
          !b22ProgressControllerNcpn.isAnimating) {
        b22ProgressControllerNcpn.forward();
      }
    }
  }

  @override
  void onClose() {
    B22ApplicationLifecycleOrchestratorPhic.b22InstanceGfkl
        .b22StartObservingLifecycleJdlg();
    B22EntryInputGateKjfv.b22InstanceHthn.b22MarkLauncherClosedVsfc();
    b22AdCheckTimerJwcx?.cancel();
    b22AdCheckStopwatchYrfm.stop();
    b22ProgressControllerNcpn
      ..removeListener(b22NotifyProgressChangedWvvl)
      ..removeStatusListener(b22OnProgressAnimationStatusChangedRoew)
      ..dispose();
    super.onClose();
  }
}
