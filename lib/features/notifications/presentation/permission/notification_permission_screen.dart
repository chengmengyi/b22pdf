import 'package:b21pdf/core/config/app_config.dart';
import 'package:b21pdf/features/notifications/presentation/permission/notification_permission_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/pulse_view.dart';
import 'package:b21pdf/shared/widgets/switch_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NotificationPermissionScreen
    extends BaseScreen<NotificationPermissionController> {
  const NotificationPermissionScreen({super.key});

  @override
  NotificationPermissionController createController() {
    return NotificationPermissionController();
  }

  @override
  Widget buildContent(
    BuildContext context,
    NotificationPermissionController controller,
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
              "permissions/notification_illustration_image",
              width: 203.w,
              height: 140.h,
            ),
            SizedBox(height: 24.h),
            LocalizedTextView(
              "Stay Update".tr,
              fontSize: 20.sp,
              color: Color(0xff07080E),
              fontWeight: FontWeight.bold,
              fontType: FontType.extra,
            ),
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.only(left: 20.w,right: 20.w),
              child: LocalizedTextView(
                "Enable Notifications To Get Instant Alerts When Your File Processing Is Complete.".tr,
                fontSize: 14.sp,
                color: Color(0xff5E5E5E),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  AssetPictureView('branding/app_logo', width: 48.w, height: 48.w),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocalizedTextView(
                          AppConfig.applicationName.tr,
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          fontType: FontType.extra,
                        ),
                        LocalizedTextView(
                          "All notifications".tr,
                          fontSize: 12.sp,
                          color: Color(0xff979796),
                          fontType: FontType.semi,
                        ),
                      ],
                    ),
                  ),
                  const SwitchView(),
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1.Tap The Toggle Switch Above
                // 2.Allow Notifications In System Settings
                LocalizedTextView(
                  '1.Tap The Toggle Switch Above'.tr,
                  fontSize: 14.sp,
                  color: const Color(0xff5E5E5E),
                  fontWeight: FontWeight.w500,
                ),
                LocalizedTextView(
                  '2.Allow Notifications In System Settings'.tr,
                  fontSize: 14.sp,
                  color: const Color(0xff5E5E5E),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Spacer(),
            PulseView(
              child: TapGuardView(
                onPressed: () {
                  controller.onUpdatePressed();
                },
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Color(0xffC40000),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: LocalizedTextView(
                    'Update now'.tr,
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                color: const Color(0xff525759),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ],
    );
  }
}
