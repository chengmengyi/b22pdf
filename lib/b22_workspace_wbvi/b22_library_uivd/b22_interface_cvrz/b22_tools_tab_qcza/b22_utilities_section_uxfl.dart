import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_tools_tab_qcza/b22_utilities_section_coordinator_khxl.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_home_widget_wejh/b22_operations_dntq/b22_dashboard_module_orchestrator_knhc.dart';
import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_operations_tqim/b22_picture_ingest_orchestrator_wuuu.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_section_lobe.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22UtilitiesSectionPvpk extends B22FoundationSectionMnzc {
  const B22UtilitiesSectionPvpk({super.key});

  @override
  State<B22UtilitiesSectionPvpk> createState() =>
      B22FeatureUtilitiesSectionStatePxpq();
}

class B22FeatureUtilitiesSectionStatePxpq
    extends
        B22FoundationSectionStateNpno<
          B22UtilitiesSectionCoordinatorXpza,
          B22UtilitiesSectionPvpk
        > {
  @override
  B22UtilitiesSectionCoordinatorXpza createController() {
    return B22UtilitiesSectionCoordinatorXpza();
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22UtilitiesSectionCoordinatorXpza b22ControllerXzhr,
  ) {
    return GetBuilder<B22UtilitiesSectionCoordinatorXpza>(
      init: b22ControllerXzhr,
      global: false,
      builder: (b22ControllerOxjp) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          b22BuildTitleSectionBuhn(),
          b22ToolsWidgetMupg(),
          b22SystemWidgetDebp(),
          b22PreferenceWidgetPpev(b22ControllerOxjp),
        ],
      ),
    );
  }

  Widget b22ToolsWidgetMupg() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20.h, left: 12.w, right: 12.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        B22TranslatedLabelComponentJklc(
          'b22_pdf_tools_htwn'.tr,
          b22FontSizeIafw: 16.sp,
          b22ColorZcbj: Colors.black,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
        ),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Colors.black,
          margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
        ),
        Row(
          children: [
            Expanded(
              child: B22TouchGuardComponentKong(
                b22OnPressedXvbd: () {
                  B22PictureIngestOrchestratorIybt.b22InstancePyok
                      .b22ScanDocumentsNogs();
                },
                b22ChildWksr: Container(
                  width: double.infinity,
                  height: 68.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      B22ResourceImageComponentXjch(
                        "b22_conversion_media_xzqz/b22_tool_actions_wwfr/b22_scan_conversion_action_uggn",
                        b22WidthKbfi: 40.w,
                        b22HeightUsfn: 40.h,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: B22TranslatedLabelComponentJklc(
                          'b22_scan_to_pdf_ymhu'.tr,
                          b22FontSizeIafw: 12.sp,
                          b22ColorZcbj: Colors.black,
                          b22FontWeightPcyy: FontWeight.bold,
                          b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: B22TouchGuardComponentKong(
                b22OnPressedXvbd: () {
                  B22PictureIngestOrchestratorIybt.b22InstancePyok
                      .b22PickImagesNwpc();
                },
                b22ChildWksr: Container(
                  width: double.infinity,
                  height: 68.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      B22ResourceImageComponentXjch(
                        "b22_conversion_media_xzqz/b22_tool_actions_wwfr/b22_image_conversion_action_cqzf",
                        b22WidthKbfi: 40.w,
                        b22HeightUsfn: 40.h,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: B22TranslatedLabelComponentJklc(
                          'b22_image_to_pdf_krtw'.tr,
                          b22FontSizeIafw: 12.sp,
                          b22ColorZcbj: Colors.black,
                          b22FontWeightPcyy: FontWeight.bold,
                          b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget b22SystemWidgetDebp() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        B22TranslatedLabelComponentJklc(
          'b22_system_lwwl'.tr,
          b22FontSizeIafw: 16.sp,
          b22ColorZcbj: Colors.black,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
        ),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Colors.black,
          margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
        ),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: () {
            B22DashboardModuleOrchestratorKvty.b22InstanceVpeq
                .b22OpenWidgetPickerZojb();
          },
          b22ChildWksr: Container(
            width: double.infinity,
            height: 60.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Row(
              children: [
                B22ResourceImageComponentXjch(
                  "b22_conversion_media_xzqz/b22_tool_actions_wwfr/b22_home_widget_offer_wzbb",
                  b22WidthKbfi: 38.w,
                  b22HeightUsfn: 38.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: B22TranslatedLabelComponentJklc(
                    'b22_add_widget_thxs'.tr,
                    b22FontSizeIafw: 14.sp,
                    b22ColorZcbj: Colors.black,
                    b22FontWeightPcyy: FontWeight.bold,
                    b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
                  ),
                ),
                B22ResourceImageComponentXjch(
                  "b22_conversion_media_xzqz/b22_tool_actions_wwfr/b22_widget_offer_badge_cfwb",
                  b22WidthKbfi: 24.w,
                  b22HeightUsfn: 24.w,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget b22PreferenceWidgetPpev(
    B22UtilitiesSectionCoordinatorXpza b22ControllerArhb,
  ) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        B22TranslatedLabelComponentJklc(
          'b22_preference_oqew'.tr,
          b22FontSizeIafw: 16.sp,
          b22ColorZcbj: Colors.black,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
        ),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Colors.black,
          margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
        ),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: () {
            b22ControllerArhb.b22OnChangeLanguagePressedRwgv();
          },
          b22ChildWksr: Container(
            width: double.infinity,
            height: 64.h,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                B22ResourceImageComponentXjch(
                  "b22_localization_media_vmzp/b22_language_guides_rnat/b22_language_entry_action_vnxe",
                  b22WidthKbfi: 24.w,
                  b22HeightUsfn: 24.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: B22TranslatedLabelComponentJklc(
                    'b22_app_language_cmhv'.tr,
                    b22FontSizeIafw: 16.sp,
                    b22ColorZcbj: Color(0xff000000),
                    b22FontWeightPcyy: FontWeight.bold,
                    b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
                  ),
                ),
                B22TranslatedLabelComponentJklc(
                  b22ControllerArhb.currentLanguageName,
                  b22FontSizeIafw: 12.sp,
                  b22ColorZcbj: Color(0xff5E5E5E),
                  b22FontWeightPcyy: FontWeight.w500,
                  b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
                ),
                SizedBox(width: 4.w),
                B22ResourceImageComponentXjch(
                  "b22_shared_controls_ybsz/b22_navigation_actions_dmkw/b22_navigate_next_compact_bogv",
                  b22WidthKbfi: 18.w,
                  b22HeightUsfn: 18.w,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget b22BuildTitleSectionBuhn() => Container(
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 60.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child: B22TranslatedLabelComponentJklc(
          'b22_tools_settings_hrkc'.tr,
          b22FontSizeIafw: 20.sp,
          b22ColorZcbj: Colors.black,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
        ),
      ),
    ),
  );
}
