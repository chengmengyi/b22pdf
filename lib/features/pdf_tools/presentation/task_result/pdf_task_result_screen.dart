import 'package:b21pdf/features/pdf_tools/presentation/task_result/pdf_task_result_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PdfTaskResultScreen extends BaseScreen<PdfTaskResultController> {
  const PdfTaskResultScreen({super.key});

  @override
  PdfTaskResultController createController() {
    return PdfTaskResultController();
  }

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  Widget buildContent(
    BuildContext context,
    PdfTaskResultController controller,
  ) {
    return Column(
      children: [
        _buildTitleBar(controller),
        SizedBox(height: 100.h),
        AssetPictureView(
          "pdf_tools/conversion_complete",
          width: 91.w,
          height: 88.w,
        ),
        SizedBox(height: 20.h),
        LocalizedTextView(
          'Success!'.tr,
          fontSize: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontType: FontType.black,
        ),
        SizedBox(height: 8.h),
        LocalizedTextView(
          'Your file is ready'.tr,
          fontSize: 14.sp,
          color: Color(0xff5E5E5E),
          fontWeight: FontWeight.w500,
          fontType: FontType.black,
        ),
        SizedBox(height: 44.h),
        _infoWidget(controller),
        Spacer(),
        _buildBottomSection(controller),
      ],
    );
  }

  Widget _buildBottomSection(PdfTaskResultController controller) => Container(
    width: double.infinity,
    height: 82.h,
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: 24.w, right: 24.w),
    decoration: BoxDecoration(
      color: Color(0xffFFFAF6),
      border: BoxBorder.fromLTRB(
        top: BorderSide(
          width: 2.w,
          color: Colors.black,
        ),
      ),
    ),
    child: TapGuardView(
          onPressed: controller.onOpenPressed,
          child: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffC40000),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: LocalizedTextView(
              "Open".tr,
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontType: FontType.extra,
            ),
          ),
        ),
  );

  Widget _infoWidget(PdfTaskResultController controller) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.w),
    margin: EdgeInsets.only(left: 24.w,right: 24.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
      border: Border.all(
        width: 2.w,
        color: Color(0xff000000),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssetPictureView("branding/pdf_logo", width: 40.w, height: 40.w),
        SizedBox(height: 8.h,),
        LocalizedTextView(
          controller.fileName,
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontType: FontType.extra,
        ),
        Row(
          children: [
            AssetPictureView("pdf_tools/icon_result_size",width: 16.w,height: 16.w,),
            SizedBox(width: 2.w,),
            LocalizedTextView(
              controller.fileDetailSize,
              fontSize: 12.sp,
              color: Color(0xff333333),
              fontType: FontType.semi,
            ),
            SizedBox(width: 16.w,),
            AssetPictureView("pdf_tools/icon_result_time",width: 16.w,height: 16.w,),
            SizedBox(width: 2.w,),
            LocalizedTextView(
              controller.fileDetailTime,
              fontSize: 12.sp,
              color: Color(0xff333333),
              fontType: FontType.semi,
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildTitleBar(PdfTaskResultController controller) => SafeArea(
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
