import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_guide_completion_store_xqve.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_operations_xopv/b22_first_run_director_xcwj.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/material.dart';

class B22GuideCoordinatorFvke extends B22FoundationCoordinatorXsba {
  static const String b22NativeAdEligibilityUpdateIdOqev =
      'b22_guide_native_ad_eligibility';

  final PageController b22PageControllerQnva = PageController();

  int b22CurrentPagePrme = 0;
  bool b22CanShowNativeAdJqwo =
      B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm.isEligibleUser;
  bool b22TriedGuideFullAdBqle = false;
  bool b22FinishingGuideXkva = false;

  void b22OnPageChangedFzro(int b22PageIndexUyme, BuildContext b22ContextTqva) {
    b22CurrentPagePrme = b22PageIndexUyme;
    if (b22PageIndexUyme == 1 && !b22TriedGuideFullAdBqle) {
      b22TriedGuideFullAdBqle = true;
      if (B22AudienceQualificationOrchestratorCaap
          .b22InstanceWcsm
          .isEligibleUser) {
        unawaited(
          B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
            b22AdSceneHfhk: B22PromotionContextSuaj.pr_new_int,
            b22AdPosIdEjxk: B22PromotionSlotZwla.pr_guide_full,
            b22AdHostContextQqxr: b22ContextTqva,
            b22IgnoreCooldownGkwn: true,
          ),
        );
      }
    }
  }

  void b22OnBottomPressedEkra(BuildContext b22ContextTqva) {
    if (b22CurrentPagePrme < 1) {
      b22PageControllerQnva.animateToPage(
        b22CurrentPagePrme + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    if (b22FinishingGuideXkva) return;
    b22FinishingGuideXkva = true;
    unawaited(b22FinishGuideCjwo(b22ContextTqva));
  }

  Future<void> b22FinishGuideCjwo(BuildContext b22ContextTqva) async {
    if (B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      await B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
        b22AdSceneHfhk: B22PromotionContextSuaj.pr_new_int,
        b22AdPosIdEjxk: B22PromotionSlotZwla.pr_guide_int,
        b22AdHostContextQqxr: b22ContextTqva,
        b22IgnoreCooldownGkwn: true,
      );
    }
    await B22GuideCompletionStorePqaz.b22SaveCompletedJtro(true);
    await B22FirstRunDirectorYxjn.instance
        .b22ToPageOpenNotificationPermissionVhup();
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  void onAppEvent(B22ApplicationSignalXfvp event) {
    if (event.b22TypeIafj !=
        B22ApplicationSignalKindJiwh.b22RefreshBUserStateSzod) {
      return;
    }
    final bool b22CanShowNativeAdKtva =
        B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm.isEligibleUser;
    if (b22CanShowNativeAdJqwo == b22CanShowNativeAdKtva) return;
    b22CanShowNativeAdJqwo = b22CanShowNativeAdKtva;
    update(<String>[b22NativeAdEligibilityUpdateIdOqev]);
  }

  @override
  void onClose() {
    b22PageControllerQnva.dispose();
    super.onClose();
  }
}
