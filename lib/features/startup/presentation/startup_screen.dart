import 'package:b21pdf/features/startup/presentation/startup_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StartupScreen extends BaseScreen<StartupController> {
  const StartupScreen({super.key});

  @override
  StartupController createController() {
    return StartupController();
  }

  @override
  Widget buildContent(BuildContext context, StartupController controller) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 160.h),
          AssetPictureView('branding/app_logo', width: 88.w, height: 88.w),
          SizedBox(height: 20.h),
          LocalizedTextView(
            'Your pocket file pro'.tr,
            fontSize: 18.sp,
            color: Color(0xff0F172A),
            fontWeight: FontWeight.w900,
            fontType: FontType.extra,
          ),
          const Spacer(),
          GetBuilder<StartupController>(
            id: StartupController.progressUpdateId,
            builder: (StartupController controller) {
              return buildProgressIndicator(controller.progressValue);
            },
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget buildProgressIndicator(double progress) {
    final double safeProgress = progress.clamp(0.0, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LocalizedTextView(
              "${(safeProgress*100).toInt()}",
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
        Container(
          width: 222.w,
          height: 12.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
          ),
          child: Container(
            width: (222.w) * safeProgress,
            height: 12.h,
            decoration: BoxDecoration(
              color: Color(0xff970000),
            ),
          ),
        ),
      ],
    );
  }
}
