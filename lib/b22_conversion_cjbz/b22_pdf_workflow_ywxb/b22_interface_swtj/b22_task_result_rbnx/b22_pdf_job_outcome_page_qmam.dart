import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_interface_swtj/b22_task_result_rbnx/b22_pdf_job_outcome_coordinator_jtua.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22PdfJobOutcomePageGfpb
    extends B22FoundationPageNhfc<B22PdfJobOutcomeCoordinatorUwje> {
  const B22PdfJobOutcomePageGfpb({super.key});

  @override
  B22PdfJobOutcomeCoordinatorUwje createController() {
    return B22PdfJobOutcomeCoordinatorUwje();
  }

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  Widget buildContent(
    BuildContext context,
    B22PdfJobOutcomeCoordinatorUwje b22ControllerRirq,
  ) {
    return Column(
      children: [
        b22BuildTitleBarOhcq(b22ControllerRirq),
        SizedBox(height: 100.h),
        B22ResourceImageComponentXjch(
          "b22_conversion_media_xzqz/b22_workflow_status_pjra/b22_conversion_success_state_npeu",
          b22WidthKbfi: 91.w,
          b22HeightUsfn: 88.w,
        ),
        SizedBox(height: 20.h),
        B22TranslatedLabelComponentJklc(
          'b22_success_chib'.tr,
          b22FontSizeIafw: 20.sp,
          b22ColorZcbj: Colors.black,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.black,
        ),
        SizedBox(height: 8.h),
        B22TranslatedLabelComponentJklc(
          'b22_your_file_is_ready_tepb'.tr,
          b22FontSizeIafw: 14.sp,
          b22ColorZcbj: Color(0xff5E5E5E),
          b22FontWeightPcyy: FontWeight.w500,
          b22FontTypeQdme: B22FontKindGnzs.black,
        ),
        SizedBox(height: 44.h),
        b22InfoWidgetIcml(b22ControllerRirq),
        Spacer(),
        b22BuildBottomSectionRocl(b22ControllerRirq),
      ],
    );
  }

  Widget b22BuildBottomSectionRocl(
    B22PdfJobOutcomeCoordinatorUwje b22ControllerFfvh,
  ) => Container(
    width: double.infinity,
    height: 82.h,
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: 24.w, right: 24.w),
    decoration: BoxDecoration(
      color: Color(0xffFFFAF6),
      border: BoxBorder.fromLTRB(
        top: BorderSide(width: 2.w, color: Colors.black),
      ),
    ),
    child: B22TouchGuardComponentKong(
      b22OnPressedXvbd: b22ControllerFfvh.b22OnOpenPressedNzlh,
      b22ChildWksr: Container(
        width: double.infinity,
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xffC40000),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: B22TranslatedLabelComponentJklc(
          'b22_open_azmj'.tr,
          b22FontSizeIafw: 16.sp,
          b22ColorZcbj: Colors.white,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.extra,
        ),
      ),
    ),
  );

  Widget b22InfoWidgetIcml(
    B22PdfJobOutcomeCoordinatorUwje b22ControllerPgvc,
  ) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.w),
    margin: EdgeInsets.only(left: 24.w, right: 24.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
      border: Border.all(width: 2.w, color: Color(0xff000000)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        B22ResourceImageComponentXjch(
          "b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_pdf_badge_qmqd",
          b22WidthKbfi: 40.w,
          b22HeightUsfn: 40.w,
        ),
        SizedBox(height: 8.h),
        B22TranslatedLabelComponentJklc(
          b22ControllerPgvc.fileName,
          b22FontSizeIafw: 18.sp,
          b22ColorZcbj: Colors.black,
          b22FontWeightPcyy: FontWeight.bold,
          b22FontTypeQdme: B22FontKindGnzs.extra,
        ),
        Row(
          children: [
            B22ResourceImageComponentXjch(
              "b22_conversion_media_xzqz/b22_workflow_status_pjra/b22_result_size_marker_veyz",
              b22WidthKbfi: 16.w,
              b22HeightUsfn: 16.w,
            ),
            SizedBox(width: 2.w),
            B22TranslatedLabelComponentJklc(
              b22ControllerPgvc.fileDetailSize,
              b22FontSizeIafw: 12.sp,
              b22ColorZcbj: Color(0xff333333),
              b22FontTypeQdme: B22FontKindGnzs.semi,
            ),
            SizedBox(width: 16.w),
            B22ResourceImageComponentXjch(
              "b22_conversion_media_xzqz/b22_workflow_status_pjra/b22_result_time_marker_jbck",
              b22WidthKbfi: 16.w,
              b22HeightUsfn: 16.w,
            ),
            SizedBox(width: 2.w),
            B22TranslatedLabelComponentJklc(
              b22ControllerPgvc.fileDetailTime,
              b22FontSizeIafw: 12.sp,
              b22ColorZcbj: Color(0xff333333),
              b22FontTypeQdme: B22FontKindGnzs.semi,
            ),
          ],
        ),
      ],
    ),
  );

  Widget b22BuildTitleBarOhcq(
    B22PdfJobOutcomeCoordinatorUwje b22ControllerRwtp,
  ) => SafeArea(
    top: true,
    bottom: false,
    child: SizedBox(
      width: double.infinity,
      height: 44.h,
      child: Stack(
        children: [
          B22TouchGuardComponentKong(
            b22OnPressedXvbd: b22ControllerRwtp.b22OnBackPressedAzjw,
            b22ChildWksr: SizedBox(
              width: 44.w,
              height: 44.h,
              child: Center(
                child: B22ResourceImageComponentXjch(
                  'b22_shared_controls_ybsz/b22_navigation_actions_dmkw/b22_navigate_back_fylg',
                  b22WidthKbfi: 24.w,
                  b22HeightUsfn: 24.w,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
