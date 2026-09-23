import 'package:app_settings/app_settings.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_operations_xopv/b22_first_run_director_xcwj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_home_ivzz/b22_dashboard_coordinator_bpln.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:get/get.dart';

class B22UpgradeCoordinatorHxcb extends B22FoundationCoordinatorXsba {
  void b22OnContinueUsingPressedSbeb() {
    b22ReturnToAppZjcf();
  }

  Future<void> b22OnLeaveAnywayPressedOgjc() async {
    if (B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      await B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
        b22AdSceneHfhk: B22PromotionContextSuaj.pr_exit,
        b22AdPosIdEjxk: B22PromotionSlotZwla.unload_2,
        b22AdHostContextQqxr: Get.context,
      );
    }
    b22ReturnToAppZjcf();
    // await AppSettings.openAppSettings();
  }

  void b22ReturnToAppZjcf() {
    if (Get.isRegistered<B22DashboardCoordinatorNjxu>()) {
      B22ApplicationRouterJfva.b22PopUntilRouteUmkj(
        B22ApplicationDestinationsMcbk.b22HomeRouteEdoo,
      );
      return;
    }
    B22FirstRunDirectorYxjn.instance.b22OpenOverlaySelectionRoen();
  }
}
