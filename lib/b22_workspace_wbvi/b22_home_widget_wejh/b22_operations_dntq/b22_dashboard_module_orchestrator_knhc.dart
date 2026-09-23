import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_home_widget_wejh/b22_interface_oywi/b22_dashboard_module_lower_drawer_shbk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_install_module_store_tsjc.dart';
import 'package:flutter_add_widget_plugins/flutter_add_widget_plugins.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum B22InstallModuleKindBmus {
  home("Home", "b22_home_tool_divg"),
  merge("Scan", "b22_merge_tool_liwu"),
  import("Word to PDF", "b22_import_tool_eigf"),
  convert("Image to PDF", "b22_convert_tool_yuob");

  final String b22TextVubl;
  final String b22IconUuzk;
  const B22InstallModuleKindBmus(this.b22TextVubl, this.b22IconUuzk);
}

class B22DashboardModuleOrchestratorKvty {
  B22DashboardModuleOrchestratorKvty._();

  static final B22DashboardModuleOrchestratorKvty b22InstanceVpeq =
      B22DashboardModuleOrchestratorKvty._();

  final List<WidgetInfo> b22WidgetInfoListDdsu = <WidgetInfo>[];

  Future<void> b22OpenWidgetPickerZojb() async {
    var b22ResultUwrb =
        await B22ApplicationRouterJfva.b22ShowBottomSheetLzuf<bool>(
          b22ChildBzzg: const B22DashboardModuleLowerDrawerWjqk(),
        );
    if (b22ResultUwrb == true) {
      await b22AddSelectedWidgetOvra();
    }
  }

  Future<void> b22AddSelectedWidgetOvra() async {
    b22InitializeWidgetMetadataRxzf();
    await FlutterAddWidgetPlugins.instance.addWidget(
      items: b22WidgetInfoListDdsu,
      layoutName: "insert_widget_layout",
      searchText: "Search".tr,
    );
    await B22InstallModuleStoreLldu.b22SaveAddedPupj(true);
    B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
      B22ApplicationSignalXfvp(
        b22TypeIafj: B22ApplicationSignalKindJiwh.b22WidgetAddedHjvu,
      ),
    );
  }

  void b22InitializeWidgetMetadataRxzf() {
    b22WidgetInfoListDdsu.clear();
    for (var b22ValueXayv in B22InstallModuleKindBmus.values) {
      b22WidgetInfoListDdsu.add(
        WidgetInfo(
          icon: b22ValueXayv.b22IconUuzk,
          name: b22ValueXayv.b22TextVubl.tr,
          type: b22ValueXayv.name,
        ),
      );
    }
  }
}
