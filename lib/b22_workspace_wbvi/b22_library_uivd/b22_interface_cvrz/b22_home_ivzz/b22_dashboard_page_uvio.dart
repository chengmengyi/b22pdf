import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_operations_tqim/b22_picture_ingest_orchestrator_wuuu.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_home_ivzz/b22_dashboard_coordinator_bpln.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22DashboardPageLkpx
    extends B22FoundationPageNhfc<B22DashboardCoordinatorNjxu> {
  const B22DashboardPageLkpx({super.key});

  @override
  B22DashboardCoordinatorNjxu createController() {
    return B22DashboardCoordinatorNjxu();
  }

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Future<bool> canPopRoute(B22DashboardCoordinatorNjxu b22ControllerNfhc) =>
      b22ControllerNfhc.b22OnSystemBackRequestedFens();

  @override
  Widget buildContent(
    BuildContext b22ContextLyeb,
    B22DashboardCoordinatorNjxu controller,
  ) {
    return GetBuilder<B22DashboardCoordinatorNjxu>(
      id: B22DashboardCoordinatorNjxu.b22TabUpdateIdCrmb,
      builder: (B22DashboardCoordinatorNjxu b22ControllerQreb) {
        return Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: b22ControllerQreb.b22TabIndexPvys,
                children: b22ControllerQreb.b22PagesOvgc,
              ),
            ),
            b22BuildBottomNavigationTtam(b22ControllerQreb, b22ContextLyeb),
          ],
        );
      },
    );
  }

  Widget b22BuildBottomNavigationTtam(
    B22DashboardCoordinatorNjxu b22ControllerSeai,
    BuildContext b22ContextBcig,
  ) {
    return Container(
      width: double.infinity,
      height: 64.h,
      decoration: BoxDecoration(color: Color(0xffFFFAF6)),
      child: Row(
        children: [
          b22ItemWidgetBcar(
            B22DashboardSectionVbai.files,
            b22ControllerSeai,
            b22ContextBcig,
          ),
          Expanded(
            child: B22TouchGuardComponentKong(
              b22OnPressedXvbd: () {
                B22PictureIngestOrchestratorIybt.b22InstancePyok
                    .b22ScanDocumentsNogs();
              },
              b22ChildWksr: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    B22ResourceImageComponentXjch(
                      'b22_workspace_media_vwug/b22_home_shell_xfaq/b22_scan_primary_action_dqmn',
                      b22WidthKbfi: 32.w,
                      b22HeightUsfn: 32.w,
                    ),
                    B22TranslatedLabelComponentJklc(
                      'b22_scan_tbqg'.tr,
                      b22FontSizeIafw: 10.sp,
                      b22ColorZcbj: Colors.black,
                      b22FontWeightPcyy: FontWeight.bold,
                      b22FontTypeQdme: B22FontKindGnzs.semi,
                    ),
                  ],
                ),
              ),
            ),
          ),
          b22ItemWidgetBcar(
            B22DashboardSectionVbai.tools,
            b22ControllerSeai,
            b22ContextBcig,
          ),
        ],
      ),
    );
  }

  Widget b22ItemWidgetBcar(
    B22DashboardSectionVbai b22TypeBpps,
    B22DashboardCoordinatorNjxu b22ControllerWmmf,
    BuildContext b22ContextByex,
  ) {
    final bool b22SelectedXsgo =
        b22ControllerWmmf.b22TabIndexPvys == b22TypeBpps.index;
    return Expanded(
      child: B22TouchGuardComponentKong(
        b22OnPressedXvbd: () {
          b22ControllerWmmf.b22OnTabSelectedTwou(b22TypeBpps, b22ContextByex);
        },
        b22ChildWksr: Container(
          alignment: Alignment.center,
          color: b22SelectedXsgo ? Color(0xff970000) : Color(0xffFFFAF6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              B22ResourceImageComponentXjch(
                b22SelectedXsgo
                    ? b22TypeBpps.b22IconSelectedPald
                    : b22TypeBpps.b22IconUnselectedVhvp,
                b22WidthKbfi: 32.w,
                b22HeightUsfn: 32.w,
              ),
              B22TranslatedLabelComponentJklc(
                b22TypeBpps.b22TextBpkk.tr,
                b22FontSizeIafw: 10.sp,
                b22ColorZcbj: b22SelectedXsgo
                    ? const Color(0xffFFFFFF)
                    : const Color(0xff000000),
                b22FontWeightPcyy: FontWeight.bold,
                b22FontTypeQdme: B22FontKindGnzs.semi,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
