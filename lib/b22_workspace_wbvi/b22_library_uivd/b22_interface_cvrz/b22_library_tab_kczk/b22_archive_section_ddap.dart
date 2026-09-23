import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_home_widget_wejh/b22_operations_dntq/b22_dashboard_module_orchestrator_knhc.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_document_list_mggf/b22_file_collection_fafv.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_library_tab_kczk/b22_archive_section_coordinator_xkbp.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_section_lobe.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22ArchiveSectionLkbi extends B22FoundationSectionMnzc {
  const B22ArchiveSectionLkbi({super.key});

  @override
  State<B22ArchiveSectionLkbi> createState() => B22ArchiveSectionStateLqyu();
}

class B22ArchiveSectionStateLqyu
    extends
        B22FoundationSectionStateNpno<
          B22ArchiveSectionCoordinatorMvvw,
          B22ArchiveSectionLkbi
        > {
  @override
  B22ArchiveSectionCoordinatorMvvw createController() {
    return B22ArchiveSectionCoordinatorMvvw();
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22ArchiveSectionCoordinatorMvvw b22ControllerYfba,
  ) {
    return GetBuilder<B22ArchiveSectionCoordinatorMvvw>(
      init: b22ControllerYfba,
      builder: (b22ControllerNohj) => Column(
        children: [
          b22BuildHeaderUmlg(b22ControllerNohj),
          b22BuildCategoryTabsVohb(b22ControllerNohj),
          // if (controller.showAddWidget) _buildAddWidgetBanner(),
          b22BuildTabPagesNrwb(b22ControllerNohj),
        ],
      ),
    );
  }

  Widget b22BuildTabPagesNrwb(
    B22ArchiveSectionCoordinatorMvvw b22ControllerUuvu,
  ) => Expanded(
    child: PageView.builder(
      controller: b22ControllerUuvu.b22PageControllerMpft,
      itemCount: B22FileCategoryVdhm.values.length,
      onPageChanged: (int b22IndexOxpu) =>
          b22ControllerUuvu.b22OnPageChangedZjnw(b22IndexOxpu, context),
      itemBuilder: (BuildContext context, int b22IndexCsyc) =>
          B22FileCollectionOwkl(
            b22TypeQpit: B22FileCategoryVdhm.values[b22IndexCsyc],
          ),
    ),
  );

  Widget b22BuildCategoryTabsVohb(
    B22ArchiveSectionCoordinatorMvvw b22ControllerOpbn,
  ) => Container(
    width: double.infinity,
    height: 43.h,
    margin: EdgeInsets.all(12.w),
    padding: EdgeInsets.all(5.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
    ),
    child: ListView.separated(
      itemCount: B22FileCategoryVdhm.values.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, b22IndexLlwr) {
        final B22FileCategoryVdhm b22CategoryFlnc =
            B22FileCategoryVdhm.values[b22IndexLlwr];
        final bool b22IsSelectedFaaz =
            b22IndexLlwr == b22ControllerOpbn.b22SelectedTabIndexZhwn;
        return B22TouchGuardComponentKong(
          b22OnPressedXvbd: () {
            b22ControllerOpbn.b22SelectCategoryGtlv(b22CategoryFlnc);
          },
          b22ChildWksr: Container(
            width: 76.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              color: b22IsSelectedFaaz ? Colors.black : Color(0xffFFFAF6),
            ),
            child: B22TranslatedLabelComponentJklc(
              b22CategoryFlnc.b22LabelOamr.tr,
              b22FontSizeIafw: 14.sp,
              b22ColorZcbj: b22IsSelectedFaaz
                  ? Colors.white
                  : const Color(0xff5E5E5E),
              b22FontWeightPcyy: FontWeight.bold,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(width: 6.w),
    ),
  );

  // Widget _buildAddWidgetBanner() => Stack(
  //   alignment: Alignment.bottomLeft,
  //   children: [
  //     Container(
  //       width: double.infinity,
  //       height: 56.h,
  //       margin: EdgeInsets.only(top: 8.h),
  //       padding: EdgeInsets.only(left: 68.w, right: 16.w),
  //       decoration: BoxDecoration(
  //         color: const Color(0xffFFECB8),
  //         borderRadius: BorderRadius.circular(28.w),
  //       ),
  //       child: Row(
  //         children: [
  //           SizedBox(width: 8.w),
  //           Expanded(
  //             child: LocalizedTextView(
  //               "b22_to_access_features_instantly_add_kncq".tr,
  //               fontSize: 14.sp,
  //               color: Color(0xff07080E),
  //               overflow: TextOverflow.ellipsis,
  //               maxLines: 2,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //           SizedBox(width: 8.w),
  //           TapGuardView(
  //             onPressed: () {
  //               HomeWidgetService.instance.openWidgetPicker();
  //             },
  //             child: Container(
  //               padding: EdgeInsets.only(
  //                 left: 16.w,
  //                 right: 16.w,
  //                 top: 4.h,
  //                 bottom: 4.h,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(18.w),
  //               ),
  //               child: LocalizedTextView(
  //                 "b22_grant_hylo".tr,
  //                 fontSize: 14.sp,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     AssetPictureView(
  //       "b22_widget_extension_media_btai/b22_widget_resources_csgz/b22_widget_picker_banner_oqqs",
  //       width: 64.w,
  //       height: 64.w,
  //     ),
  //   ],
  // );

  Widget b22BuildHeaderUmlg(
    B22ArchiveSectionCoordinatorMvvw b22ControllerQmln,
  ) => Container(
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 60.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          reverseDuration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder:
              (Widget b22ChildXlfl, Animation<double> b22AnimationAcbk) {
                final bool b22IsSearchInputRaim =
                    b22ChildXlfl.key == const ValueKey<String>('search-input');
                return FadeTransition(
                  opacity: b22AnimationAcbk,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(b22IsSearchInputRaim ? 1 : -0.15, 0),
                      end: Offset.zero,
                    ).animate(b22AnimationAcbk),
                    child: b22ChildXlfl,
                  ),
                );
              },
          child: b22ControllerQmln.b22IsSearchingLhcy
              ? KeyedSubtree(
                  key: const ValueKey<String>('search-input'),
                  child: b22InputWidgetKpel(b22ControllerQmln),
                )
              : KeyedSubtree(
                  key: const ValueKey<String>('title'),
                  child: b22TitleWidgetLaqq(b22ControllerQmln),
                ),
        ),
      ),
    ),
  );

  b22TitleWidgetLaqq(B22ArchiveSectionCoordinatorMvvw b22ControllerVzwz) => Row(
    children: [
      B22TouchGuardComponentKong(
        b22OnPressedXvbd: () {
          b22ControllerVzwz.b22RunDebugActionsXknl();
        },
        b22ChildWksr: B22TranslatedLabelComponentJklc(
          'b22_files_ljcq'.tr,
          b22FontSizeIafw: 28.sp,
          b22ColorZcbj: Colors.black,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.extra,
        ),
      ),
      Spacer(),
      B22TouchGuardComponentKong(
        b22OnPressedXvbd: b22ControllerVzwz.b22ShowSearchInputRita,
        b22ChildWksr: B22ResourceImageComponentXjch(
          "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_search_action_ngnz",
          b22WidthKbfi: 32.w,
          b22HeightUsfn: 32.w,
        ),
      ),
    ],
  );

  b22InputWidgetKpel(
    B22ArchiveSectionCoordinatorMvvw b22ControllerBirh,
  ) => Container(
    width: double.infinity,
    height: 44.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 10.w, right: 10.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
      border: Border.all(width: 2.w, color: Colors.black),
    ),
    child: Row(
      children: [
        B22ResourceImageComponentXjch(
          "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_search_action_ngnz",
          b22WidthKbfi: 28.w,
          b22HeightUsfn: 28.w,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: TextField(
            enabled: true,
            textAlign: TextAlign.left,
            controller: b22ControllerBirh.b22TextEditingControllerCekd,
            focusNode: b22ControllerBirh.b22SearchFocusNodeEkvn,
            textInputAction: TextInputAction.search,
            style: TextStyle(fontSize: 14.sp, color: Color(0xff000000)),
            onTap: () {
              B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
                b22PointTypeDrbi: B22TelemetrySignalDbrq.search_click,
              );
            },
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: 'b22_search_cbvd'.tr,
              hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xff5E5E5E)),
              border: InputBorder.none,
            ),
            onChanged: b22ControllerBirh.b22UpdateFileSearchQueryImpe,
            onSubmitted: b22ControllerBirh.b22UpdateFileSearchQueryImpe,
          ),
        ),
      ],
    ),
  );
}
