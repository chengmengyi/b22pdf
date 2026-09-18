import 'package:b21pdf/core/config/app_config.dart';
import 'package:b21pdf/features/settings/overlay_permission/overlay_permission_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/pulse_view.dart';
import 'package:b21pdf/shared/widgets/switch_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OverlayPermissionScreen extends BaseScreen<OverlayPermissionController> {
  const OverlayPermissionScreen({super.key});

  @override
  OverlayPermissionController createController() {
    return OverlayPermissionController();
  }

  @override
  Widget buildContent(
    BuildContext context,
    OverlayPermissionController controller,
  ) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AssetPictureView(
          'permissions/overlay_illustration',
          width: double.infinity,
          height: 360.h,
        ),
        Column(
          children: [
            SizedBox(height: 130.h),
            AssetPictureView(
              'permissions/overlay_illustration_image',
              width: 193.w,
              height: 140.h,
            ),
            SizedBox(height: 24.h),
            LocalizedTextView(
              'This App Has An Update.'.tr,
              fontSize: 16.sp,
              color: Colors.black,
              fontType: FontType.black,
            ),
            SizedBox(height: 24.h),
            LocalizedTextView(
              'Please upgrade to enjoy the latest functions.'.tr,
              fontSize: 14.sp,
              color: const Color(0xff5E5E5E),
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 40.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                children: [
                  AssetPictureView(
                    'branding/app_logo',
                    width: 40.w,
                    height: 40.w,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: LocalizedTextView(
                      AppConfig.applicationName.tr,
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      fontType: FontType.extra,
                    ),
                  ),
                  const SwitchView(),
                ],
              ),
            ),
            const Spacer(),
            PulseView(
              child: TapGuardView(
                onPressed: controller.onContinuePressed,
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Color(0xffC40000),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: LocalizedTextView(
                    'Update Now'.tr,
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontType: FontType.extra,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            TapGuardView(
              onPressed: controller.onLaterPressed,
              child: LocalizedTextView(
                'Later'.tr,
                fontSize: 14.sp,
                color: const Color(0xff4b5156),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontType: FontType.extra,
              ),
            ),
            SizedBox(height: 36.h),
          ],
        ),
      ],
    );
  }
}
