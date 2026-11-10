import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_loading_delay_djiwfe.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_interface_ypio/b22_open_ad_loading_qpmf/b22_launch_promotion_waiting_result_nlke.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';

class B22LaunchPromotionWaitingCoordinatorXnlw
    extends B22FoundationCoordinatorXsba {
  static const String b22ProgressUpdateIdAueu = 'open_ad_loading_progress';
  static const Duration b22MaximumWaitRrrb = Duration(seconds: 15);
  static const Duration b22TickIntervalXmdr = Duration(milliseconds: 100);
  static const Duration b22CacheCheckIntervalKgkj = Duration(milliseconds: 500);

  B22PromotionContextSuaj? b22AdSceneRowq;
  B22PromotionSlotZwla? b22AdPosIdQfwk;
  int? b22SessionIdZcsg;
  double b22ProgressIzjg = 0;

  final Stopwatch b22StopwatchIeek = Stopwatch();
  Timer? b22TimerVtuf;
  Duration b22LastCacheCheckOhzk = Duration.zero;
  late final Duration b22InitialCacheCheckDelayFsal;
  bool b22CheckingCacheQjjq = false;
  bool b22FinishedDyym = false;
  bool b22IsForegroundMslk = true;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> b22ArgumentsQdro =
        B22ApplicationRouterJfva.b22RouteArgumentsFahs();
    final Object? b22SceneArgumentCrub = b22ArgumentsQdro['adScene'];
    final Object? b22PosIdArgumentOgsi = b22ArgumentsQdro['adPosId'];
    final Object? b22SessionIdArgumentIomv = b22ArgumentsQdro['sessionId'];
    final Object? b22ForegroundArgumentLkwo = b22ArgumentsQdro['isForeground'];
    if (b22SceneArgumentCrub is B22PromotionContextSuaj &&
        b22PosIdArgumentOgsi is B22PromotionSlotZwla) {
      b22AdSceneRowq = b22SceneArgumentCrub;
      b22AdPosIdQfwk = b22PosIdArgumentOgsi;
    }
    if (b22SessionIdArgumentIomv is int) {
      b22SessionIdZcsg = b22SessionIdArgumentIomv;
    }
    if (b22ForegroundArgumentLkwo is bool) {
      b22IsForegroundMslk = b22ForegroundArgumentLkwo;
    }
    if (b22AdSceneRowq == null ||
        b22AdPosIdQfwk == null ||
        b22SessionIdZcsg == null) {
      Future<void>.delayed(
        Duration.zero,
        () => b22FinishUogi(
          b22CacheReadyQzca: false,
          b22ReasonPrxj: 'invalid_arguments',
        ),
      );
      return;
    }
    unawaited(
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.show_hot_launcher,
        b22ParametersErwm: <String, dynamic>{
          'ad_context': b22AdSceneRowq!.name,
          'ad_pos_id': b22AdPosIdQfwk!.name,
        },
      ),
    );
    if (b22IsForegroundMslk) b22StopwatchIeek.start();
    b22InitialCacheCheckDelayFsal = Duration(
      seconds: B22LoadingDelayDjiwfe.b22ReadUzvw(),
    );
    b22TimerVtuf = Timer.periodic(b22TickIntervalXmdr, (_) => b22OnTickRvzq());
    unawaited(
      B22PromotionOrchestratorAzwq.instance.b22LoadPlacementCwio(
        b22AdSceneRvij: b22AdSceneRowq!,
        b22AdPosIdIjec: b22AdPosIdQfwk!,
      ),
    );
  }

  void b22OnTickRvzq() {
    if (b22FinishedDyym || !b22IsForegroundMslk) return;
    b22ProgressIzjg =
        (b22StopwatchIeek.elapsedMilliseconds /
                b22MaximumWaitRrrb.inMilliseconds)
            .clamp(0.0, 1.0);
    update(<String>[b22ProgressUpdateIdAueu]);
    if (b22StopwatchIeek.elapsed >= b22MaximumWaitRrrb) {
      b22FinishUogi(b22CacheReadyQzca: false, b22ReasonPrxj: 'loading_timeout');
      return;
    }
    if (b22StopwatchIeek.elapsed >= b22InitialCacheCheckDelayFsal &&
        b22StopwatchIeek.elapsed - b22LastCacheCheckOhzk >=
            b22CacheCheckIntervalKgkj) {
      unawaited(b22CheckCacheLojy());
    }
  }

  Future<void> b22CheckCacheLojy() async {
    if (b22CheckingCacheQjjq ||
        b22FinishedDyym ||
        !b22IsForegroundMslk ||
        b22AdSceneRowq == null ||
        b22AdPosIdQfwk == null) {
      return;
    }
    b22CheckingCacheQjjq = true;
    b22LastCacheCheckOhzk = b22StopwatchIeek.elapsed;
    try {
      final bool b22HasCachedAdDokk = await B22PromotionOrchestratorAzwq
          .instance
          .b22HasCachedAdHtkf(
            b22AdSceneVfau: b22AdSceneRowq!,
            b22AdPosIdCcfi: b22AdPosIdQfwk!,
          );
      if (b22HasCachedAdDokk && !b22FinishedDyym && b22IsForegroundMslk) {
        b22ProgressIzjg = 1;
        update(<String>[b22ProgressUpdateIdAueu]);
        b22FinishUogi(b22CacheReadyQzca: true, b22ReasonPrxj: 'cache_ready');
      }
    } finally {
      b22CheckingCacheQjjq = false;
    }
  }

  void b22FinishUogi({
    required bool b22CacheReadyQzca,
    required String b22ReasonPrxj,
  }) {
    if (b22FinishedDyym) return;
    b22FinishedDyym = true;
    b22TimerVtuf?.cancel();
    b22TimerVtuf = null;
    b22StopwatchIeek.stop();
    final String? b22CloseReasonNvqa = switch (b22ReasonPrxj) {
      'cache_ready' => 'has_cache',
      'loading_timeout' => 'no_cache',
      _ => null,
    };
    if (b22CloseReasonNvqa != null &&
        b22AdSceneRowq != null &&
        b22AdPosIdQfwk != null) {
      unawaited(
        B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
          b22PointTypeDrbi: B22TelemetrySignalDbrq.close_hot_launcher,
          b22ParametersErwm: <String, dynamic>{
            'ad_context': b22AdSceneRowq!.name,
            'ad_pos_id': b22AdPosIdQfwk!.name,
            'close_reason': b22CloseReasonNvqa,
          },
        ),
      );
    }
    final B22LaunchPromotionWaitingResultFqwa b22ResultFheq = b22CacheReadyQzca
        ? B22LaunchPromotionWaitingResultFqwa.ready(
            b22SessionIdZcsg: b22SessionIdZcsg!,
            b22AdSceneAgkl: b22AdSceneRowq!,
            b22AdPosIdIaul: b22AdPosIdQfwk!,
          )
        : B22LaunchPromotionWaitingResultFqwa.cancelled(
            b22SessionIdZcsg: b22SessionIdZcsg ?? -1,
            b22ReasonPrxj: b22ReasonPrxj,
            b22AdSceneAgkl: b22AdSceneRowq,
            b22AdPosIdIaul: b22AdPosIdQfwk,
          );
    B22ApplicationRouterJfva.b22BackCwkm<dynamic>(b22ResultNvsq: b22ResultFheq);
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  void onAppEvent(B22ApplicationSignalXfvp event) {
    if (event.b22TypeIafj != B22ApplicationSignalKindJiwh.b22AppLifecycleZpzc) {
      return;
    }
    final bool b22IsForegroundPqzr = event.b22IntValueVddo != 1;
    if (b22IsForegroundMslk == b22IsForegroundPqzr) return;
    b22IsForegroundMslk = b22IsForegroundPqzr;
    if (b22FinishedDyym) return;
    if (b22IsForegroundMslk) {
      b22StopwatchIeek.start();
    } else {
      b22StopwatchIeek.stop();
    }
  }

  @override
  void onClose() {
    b22TimerVtuf?.cancel();
    b22TimerVtuf = null;
    b22StopwatchIeek.stop();
    super.onClose();
  }
}
