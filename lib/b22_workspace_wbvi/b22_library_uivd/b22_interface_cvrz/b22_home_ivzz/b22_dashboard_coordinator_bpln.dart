import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_engagement_xkaj/b22_feedback_mtfc/b22_interface_sehm/b22_review_panel_qibi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_library_tab_kczk/b22_archive_section_ddap.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_tools_tab_qcza/b22_utilities_section_uxfl.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/cupertino.dart';

enum B22DashboardSectionVbai {
  files(
    'b22_files_ljcq',
    'b22_workspace_media_vwug/b22_home_shell_xfaq/b22_library_tab_selected_geel',
    'b22_workspace_media_vwug/b22_home_shell_xfaq/b22_library_tab_unselected_xama',
  ),
  tools(
    'b22_tools_qsaq',
    'b22_workspace_media_vwug/b22_home_shell_xfaq/b22_tools_tab_selected_ndvb',
    'b22_workspace_media_vwug/b22_home_shell_xfaq/b22_tools_tab_unselected_ebkw',
  );

  const B22DashboardSectionVbai(
    this.b22TextBpkk,
    this.b22IconSelectedPald,
    this.b22IconUnselectedVhvp,
  );

  final String b22TextBpkk;
  final String b22IconSelectedPald;
  final String b22IconUnselectedVhvp;
}

class B22DashboardCoordinatorNjxu extends B22FoundationCoordinatorXsba {
  static const String b22TabUpdateIdCrmb = 'dashboard_tab';

  int b22TabIndexPvys = 0;
  bool b22CanExitAfterCommentGedw = false,
      b22ShowOpenNotificationPageAmlj = true;

  final List<Widget> b22PagesOvgc = const [
    B22ArchiveSectionLkbi(),
    B22UtilitiesSectionPvpk(),
  ];

  @override
  void onInit() {
    super.onInit();
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.page_view,
      b22ParametersErwm: {"page": "file"},
    );
    B22AlertOrchestratorNazk.b22InstanceOxzc.b22InitializeJrwh(
      b22RequestPermissionTulq: true,
    );
  }

  Future<bool> b22OnSystemBackRequestedFens() async {
    if (b22CanExitAfterCommentGedw) {
      return true;
    }
    if (B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      await B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
        b22AdSceneHfhk: B22PromotionContextSuaj.pr_exit,
        b22AdPosIdEjxk: B22PromotionSlotZwla.pr_exit_app,
      );
    }
    final bool? b22CanExitNextTimeBxov =
        await B22ApplicationRouterJfva.b22ShowDialogKwkf<bool>(
          b22ChildNodo: const B22ReviewPanelPomf(),
        );
    if (b22CanExitNextTimeBxov == true) {
      b22CanExitAfterCommentGedw = true;
    }
    return false;
  }

  void b22OnTabSelectedTwou(
    B22DashboardSectionVbai b22TabWker,
    BuildContext b22ContextBolk,
  ) {
    if (b22TabIndexPvys == b22TabWker.index) {
      return;
    }
    if (b22TabIndexPvys == 0) {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.page_view,
        b22ParametersErwm: {"page": "file"},
      );
    } else if (b22TabIndexPvys == 1) {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.page_view,
        b22ParametersErwm: {"page": "tools"},
      );
    }
    b22TabIndexPvys = b22TabWker.index;
    update([b22TabUpdateIdCrmb]);
    B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
      b22AdSceneHfhk: B22PromotionContextSuaj.pr_user_use,
      b22AdPosIdEjxk: B22PromotionSlotZwla.pr_down_int,
      b22AdHostContextQqxr: b22ContextBolk,
    );
    b22PromptForNotificationPermissionIfNeededBeop();
  }

  b22PromptForNotificationPermissionIfNeededBeop() async {
    if (!b22ShowOpenNotificationPageAmlj) {
      return;
    }
    var b22ResultJfnh = await B22AlertOrchestratorNazk.b22InstanceOxzc
        .b22HasNotificationPermissionAqao();
    if (b22ResultJfnh) {
      return;
    }
    B22ApplicationRouterJfva.b22PushNamedWarf(
      b22RouteNameHlpz: B22ApplicationDestinationsMcbk.b22NotificationRouteOwvv,
      b22ArgumentsEnwl: {"fromHome": true},
    );
    b22ShowOpenNotificationPageAmlj = false;
  }
}
