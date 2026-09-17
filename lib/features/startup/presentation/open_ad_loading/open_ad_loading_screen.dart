import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/features/startup/presentation/open_ad_loading/open_ad_loading_controller.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OpenAdLoadingScreen extends BaseScreen<OpenAdLoadingController> {
  const OpenAdLoadingScreen({super.key});

  @override
  OpenAdLoadingController createController() => OpenAdLoadingController();

  @override
  Future<bool> canPopRoute(OpenAdLoadingController controller) async => false;

  @override
  Widget buildContent(
    BuildContext context,
    OpenAdLoadingController controller,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(height: 160.h),
        AssetPictureView('branding/app_logo', width: 88.w, height: 88.w),
        SizedBox(height: 20.h),
        LocalizedTextView(
          'Your pocket file pro'.tr,
          fontSize: 16.sp,
          color: const Color(0xff07080E),
          fontWeight: FontWeight.bold,
        ),
        const Spacer(),
        GetBuilder<OpenAdLoadingController>(
          id: OpenAdLoadingController.progressUpdateId,
          builder: (OpenAdLoadingController controller) =>
              _buildProgressIndicator(controller.progress),
        ),
        SizedBox(height: 120.h),
      ],
    );
  }

  Widget _buildProgressIndicator(double progress) {
    final double safeProgress = progress.clamp(0.0, 1.0);
    return Container(
      width: double.infinity,
      height: 12.h,
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double trackWidth = constraints.maxWidth - 4.w;
          return Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xffF5F7F9),
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: AnimatedContainer(
              duration: OpenAdLoadingController.tickInterval,
              width: trackWidth * safeProgress,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xffCF251F),
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
          );
        },
      ),
    );
  }
}
