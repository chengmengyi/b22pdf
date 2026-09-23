import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_updates_vfvc/b22_interface_gjkl/b22_upgrade_panel_bgfu.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_operations_xopv/b22_first_run_director_xcwj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_home_ivzz/b22_dashboard_coordinator_bpln.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class B22RemovalResponseCoordinatorMxgc extends B22FoundationCoordinatorXsba {
  static const String b22ReasonBuilderIdUsrx = 'uninstall_reason_builder';

  TextEditingController b22TextEditingControllerFqls = TextEditingController();
  int b22SelectedReasonIndexOano = -1;
  final List<String> b22ReasonListTjby = <String>[
    'Hard to use',
    'Frequent ad interference',
    'Poor PDF reading experience',
    'Too many notifications',
    "Editing features don't meet needs",
    'Phone has built-in PDF tools',
    'Other (Please specify)',
  ];

  void b22OnUninstallPressedYgmr() {
    B22ApplicationRouterJfva.b22ShowDialogKwkf(
      b22ChildNodo: const B22UpgradePanelEjrf(),
    );
  }

  void b22OnReasonPressedEqzz(int b22IndexFctu) {
    b22SelectedReasonIndexOano = b22IndexFctu;
    update(<Object>[b22ReasonBuilderIdUsrx]);
  }

  void b22OnNoUninstallPressedEqqh() {
    if (Get.isRegistered<B22DashboardCoordinatorNjxu>()) {
      B22ApplicationRouterJfva.b22PopUntilRouteUmkj(
        B22ApplicationDestinationsMcbk.b22HomeRouteEdoo,
      );
      B22ApplicationRouterJfva.b22ShowExitAdIfNeededAmnp();
      return;
    }
    B22FirstRunDirectorYxjn.instance.b22OpenOverlaySelectionRoen();
    B22ApplicationRouterJfva.b22ShowExitAdIfNeededAmnp();
  }

  @override
  void onClose() {
    b22TextEditingControllerFqls.dispose();
    super.onClose();
  }
}
