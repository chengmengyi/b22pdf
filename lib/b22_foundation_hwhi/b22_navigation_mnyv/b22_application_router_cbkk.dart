import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract final class B22ApplicationRouterJfva {
  static Future<B22TXdge?>? b22PushNamedWarf<B22TXdge>({
    required String b22RouteNameHlpz,
    Map<String, dynamic>? b22ArgumentsEnwl,
  }) {
    return Get.toNamed<B22TXdge>(b22RouteNameHlpz, arguments: b22ArgumentsEnwl);
  }

  static Future<B22TJnht?>? b22ReplaceNamedGvtg<B22TJnht>({
    required String b22RouteNameSrbn,
    Map<String, dynamic>? b22ArgumentsUsdn,
  }) {
    return Get.offNamed<B22TJnht>(
      b22RouteNameSrbn,
      arguments: b22ArgumentsUsdn,
    );
  }

  static Future<B22TCgzc?>? resetToNamed<B22TCgzc>({
    required String b22RouteNameVhpo,
    Map<String, dynamic>? b22ArgumentsUgel,
  }) {
    return Get.offAllNamed<B22TCgzc>(
      b22RouteNameVhpo,
      arguments: b22ArgumentsUgel,
    );
  }

  static void b22PopUntilRouteUmkj(String b22RouteNameVgsj) {
    Get.until((b22RouteWmrw) {
      return b22RouteWmrw.settings.name == b22RouteNameVgsj;
    });
  }

  static void b22BackCwkm<B22TFvkx>({B22TFvkx? b22ResultNvsq}) {
    Get.back<B22TFvkx>(result: b22ResultNvsq);
  }

  static bool b22IsCurrentRouteSsls(String b22RouteNameLgwl) =>
      Get.currentRoute == b22RouteNameLgwl;

  static void b22BackWithExitAdBkvf<B22TGzin>({B22TGzin? b22ResultUwvq}) {
    Get.back<B22TGzin>(result: b22ResultUwvq);
    b22ShowExitAdIfNeededAmnp();
  }

  static void b22ShowExitAdIfNeededAmnp() {
    if (!B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      return;
    }
    unawaited(
      Future<void>.delayed(Duration.zero, () async {
        await B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
          b22AdSceneHfhk: B22PromotionContextSuaj.pr_exit,
          b22AdPosIdEjxk: B22PromotionSlotZwla.pr_exit_app,
        );
      }),
    );
  }

  static Future<B22TWuei?> b22ShowBottomSheetLzuf<B22TWuei>({
    required Widget b22ChildBzzg,
    bool b22DismissibleUnqq = true,
    Color? b22BarrierColorBbiu,
    bool b22ScrollControlledYria = true,
  }) {
    return Get.bottomSheet<B22TWuei>(
      SafeArea(top: true, bottom: true, child: b22ChildBzzg),
      isScrollControlled: b22ScrollControlledYria,
      barrierColor: b22BarrierColorBbiu,
      isDismissible: b22DismissibleUnqq,
    );
  }

  static Future<B22TRmsb?> b22ShowDialogKwkf<B22TRmsb>({
    required Widget b22ChildNodo,
    bool b22BarrierDismissiblePctx = false,
    bool b22UseSafeAreaQdno = false,
  }) {
    return Get.dialog<B22TRmsb>(
      Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: b22ChildNodo,
      ),
      useSafeArea: b22UseSafeAreaQdno,
      barrierDismissible: b22BarrierDismissiblePctx,
    );
  }

  static Map<String, dynamic> b22RouteArgumentsFahs() {
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}
