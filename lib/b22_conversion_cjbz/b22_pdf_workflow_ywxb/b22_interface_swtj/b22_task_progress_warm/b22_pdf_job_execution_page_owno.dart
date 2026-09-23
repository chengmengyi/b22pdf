import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_interface_swtj/b22_task_progress_warm/b22_pdf_job_execution_coordinator_gygb.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_motion_module_auoh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22PdfJobExecutionPageNjsk
    extends B22FoundationPageNhfc<B22PdfJobExecutionCoordinatorDyvo> {
  const B22PdfJobExecutionPageNjsk({super.key});

  @override
  B22PdfJobExecutionCoordinatorDyvo createController() {
    return B22PdfJobExecutionCoordinatorDyvo();
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22PdfJobExecutionCoordinatorDyvo controller,
  ) {
    return GetBuilder<B22PdfJobExecutionCoordinatorDyvo>(
      builder: (B22PdfJobExecutionCoordinatorDyvo b22ControllerWprf) => Column(
        children: [
          b22BuildTitleBarUjnr(b22ControllerWprf),
          SizedBox(height: 62.h),
          B22ResourceImageComponentXjch(
            "b22_conversion_media_xzqz/b22_workflow_status_pjra/b22_conversion_running_state_vtvw",
            b22WidthKbfi: 94.w,
            b22HeightUsfn: 94.w,
          ),
          SizedBox(height: 20.h),
          B22TranslatedLabelComponentJklc(
            'PDF Merging...'.tr,
            b22FontSizeIafw: 20.sp,
            b22ColorZcbj: Colors.black,
            b22FontWeightPcyy: FontWeight.bold,
            b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
          ),
          SizedBox(height: 12.h),
          B22TranslatedLabelComponentJklc(
            'Please do not close the app.'.tr,
            b22FontSizeIafw: 14.sp,
            b22ColorZcbj: Color(0xff5E5E5E),
            b22FontWeightPcyy: FontWeight.w500,
            b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              B22TranslatedLabelComponentJklc(
                "${b22ControllerWprf.progressPercent}",
                b22FontSizeIafw: 32.sp,
                b22ColorZcbj: Color(0xff970000),
                b22FontWeightPcyy: FontWeight.w900,
                b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
              ),
              B22TranslatedLabelComponentJklc(
                "%",
                b22FontSizeIafw: 18.sp,
                b22ColorZcbj: Colors.black,
                b22FontWeightPcyy: FontWeight.w900,
                b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            width: 222.w,
            height: 12.h,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
            ),
            child: Container(
              width: (222.w) * b22ControllerWprf.b22ProgressTana,
              height: 12.h,
              decoration: BoxDecoration(color: Color(0xff970000)),
            ),
          ),
          SizedBox(height: 20.h),
          B22TranslatedLabelComponentJklc(
            'Processed {current}/{total} images'.tr
                .replaceAll('{current}', '${b22ControllerWprf.processedCount}')
                .replaceAll(
                  '{total}',
                  '${b22ControllerWprf.b22ImagePathsQxot.length}',
                ),
            b22FontSizeIafw: 14.sp,
            b22ColorZcbj: Color(0xff5E5E5E),
            b22FontWeightPcyy: FontWeight.w500,
            b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
          ),
          SizedBox(height: 75.h),
        ],
      ),
    );
  }

  Widget b22BuildTitleBarUjnr(
    B22PdfJobExecutionCoordinatorDyvo b22ControllerVryz,
  ) => SafeArea(
    top: true,
    bottom: false,
    child: SizedBox(
      width: double.infinity,
      height: 44.h,
      child: Stack(
        children: [
          B22TouchGuardComponentKong(
            b22OnPressedXvbd: b22ControllerVryz.b22OnBackPressedCelg,
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
