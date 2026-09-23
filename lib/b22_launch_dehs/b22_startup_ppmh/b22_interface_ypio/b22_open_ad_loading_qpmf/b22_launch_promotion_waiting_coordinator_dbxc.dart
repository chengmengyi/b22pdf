import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';

class B22LaunchPromotionWaitingCoordinatorXnlw
    extends B22FoundationCoordinatorXsba {
  static const String b22ProgressUpdateIdAueu = 'open_ad_loading_progress';
  static const Duration b22MaximumWaitRrrb = Duration(seconds: 15);
  static const Duration b22TickIntervalXmdr = Duration(milliseconds: 100);
  static const Duration b22CacheCheckIntervalKgkj = Duration(milliseconds: 500);

  B22PromotionContextSuaj? b22AdSceneRowq;
  B22PromotionSlotZwla? b22AdPosIdQfwk;
  double b22ProgressIzjg = 0;

  final Stopwatch b22StopwatchIeek = Stopwatch();
  Timer? b22TimerVtuf;
  Duration b22LastCacheCheckOhzk = Duration.zero;
  bool b22CheckingCacheQjjq = false;
  bool b22FinishedDyym = false;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> b22ArgumentsQdro =
        B22ApplicationRouterJfva.b22RouteArgumentsFahs();
    final Object? b22SceneArgumentCrub = b22ArgumentsQdro['adScene'];
    final Object? b22PosIdArgumentOgsi = b22ArgumentsQdro['adPosId'];
    if (b22SceneArgumentCrub is B22PromotionContextSuaj &&
        b22PosIdArgumentOgsi is B22PromotionSlotZwla) {
      b22AdSceneRowq = b22SceneArgumentCrub;
      b22AdPosIdQfwk = b22PosIdArgumentOgsi;
    }
    if (b22AdSceneRowq == null || b22AdPosIdQfwk == null) {
      Future<void>.delayed(
        Duration.zero,
        () => b22FinishUogi(b22CacheReadyQzca: false),
      );
      return;
    }
    b22StopwatchIeek.start();
    b22TimerVtuf = Timer.periodic(b22TickIntervalXmdr, (_) => b22OnTickRvzq());
    unawaited(
      B22PromotionOrchestratorAzwq.instance.b22ForceLoadSceneWgcb(
        b22AdSceneRvij: b22AdSceneRowq!,
        b22AdPosIdIjec: b22AdPosIdQfwk!,
      ),
    );
    unawaited(b22CheckCacheLojy());
  }

  void b22OnTickRvzq() {
    if (b22FinishedDyym) {
      return;
    }
    b22ProgressIzjg =
        (b22StopwatchIeek.elapsedMilliseconds /
                b22MaximumWaitRrrb.inMilliseconds)
            .clamp(0.0, 1.0);
    update(<String>[b22ProgressUpdateIdAueu]);
    if (b22StopwatchIeek.elapsed >= b22MaximumWaitRrrb) {
      b22FinishUogi(b22CacheReadyQzca: false);
      return;
    }
    if (b22StopwatchIeek.elapsed - b22LastCacheCheckOhzk >=
        b22CacheCheckIntervalKgkj) {
      unawaited(b22CheckCacheLojy());
    }
  }

  Future<void> b22CheckCacheLojy() async {
    if (b22CheckingCacheQjjq ||
        b22FinishedDyym ||
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
      if (b22HasCachedAdDokk && !b22FinishedDyym) {
        b22ProgressIzjg = 1;
        update(<String>[b22ProgressUpdateIdAueu]);
        b22FinishUogi(b22CacheReadyQzca: true);
      }
    } finally {
      b22CheckingCacheQjjq = false;
    }
  }

  void b22FinishUogi({required bool b22CacheReadyQzca}) {
    if (b22FinishedDyym) {
      return;
    }
    b22FinishedDyym = true;
    b22TimerVtuf?.cancel();
    b22TimerVtuf = null;
    b22StopwatchIeek.stop();
    B22ApplicationRouterJfva.b22BackCwkm<bool>(
      b22ResultNvsq: b22CacheReadyQzca,
    );
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  void onAppEvent(B22ApplicationSignalXfvp b22EventXwaf) {
    if (b22EventXwaf.b22TypeIafj ==
            B22ApplicationSignalKindJiwh.b22AppLifecycleZpzc &&
        b22EventXwaf.b22IntValueVddo == 1) {
      b22FinishUogi(b22CacheReadyQzca: false);
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
