import 'package:b21pdf/features/pdf_tools/presentation/task_progress/pdf_task_progress_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/lottie_widget.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PdfTaskProgressScreen extends BaseScreen<PdfTaskProgressController> {
  const PdfTaskProgressScreen({super.key});

  @override
  PdfTaskProgressController createController() {
    return PdfTaskProgressController();
  }

  @override
  Widget buildContent(
    BuildContext context,
    PdfTaskProgressController controller,
  ) {
    return GetBuilder<PdfTaskProgressController>(
      builder: (PdfTaskProgressController controller) => Column(
        children: [
          _buildTitleBar(controller),
          SizedBox(height: 62.h),
          AssetPictureView("pdf_tools/icon_progressing",width: 94.w,height: 94.w,),
          SizedBox(height: 20.h),
          LocalizedTextView(
            'PDF Merging...'.tr,
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontType: FontType.black,
          ),
          SizedBox(height: 12.h),
          LocalizedTextView(
            'Please do not close the app.'.tr,
            fontSize: 14.sp,
            color: Color(0xff5E5E5E),
            fontWeight: FontWeight.w500,
            fontType: FontType.black,
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LocalizedTextView(
                "${controller.progressPercent}",
                fontSize: 32.sp,
                color: Color(0xff970000),
                fontWeight: FontWeight.w900,
                fontType: FontType.black,
              ),
              LocalizedTextView(
                "%",
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontType: FontType.black,
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Container(
            width: 222.w,
            height: 12.h,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
            ),
            child: Container(
              width: (222.w) * controller.progress,
              height: 12.h,
              decoration: BoxDecoration(
                color: Color(0xff970000),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          LocalizedTextView(
            'Processed {current}/{total} images'.tr
                .replaceAll('{current}', '${controller.processedCount}')
                .replaceAll('{total}', '${controller.imagePaths.length}'),
            fontSize: 14.sp,
            color: Color(0xff5E5E5E),
            fontWeight: FontWeight.w500,
            fontType: FontType.black,
          ),
          SizedBox(height: 75.h,),
        ],
      ),
    );
  }

  Widget _buildTitleBar(PdfTaskProgressController controller) => SafeArea(
    top: true,
    bottom: false,
    child: SizedBox(
      width: double.infinity,
      height: 44.h,
      child: Stack(
        children: [
          TapGuardView(
            onPressed: controller.onBackPressed,
            child: SizedBox(
              width: 44.w,
              height: 44.h,
              child: Center(
                child: AssetPictureView(
                  'navigation/back',
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
