import 'package:b21pdf/features/settings/update/presentation/update_controller.dart';
import 'package:b21pdf/core/presentation/center_dialog.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateDialog extends CenterDialog<UpdateController> {
  const UpdateDialog({super.key});

  @override
  UpdateController createController() => UpdateController();

  @override
  Widget buildDialog(BuildContext context, UpdateController controller) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30.w,right: 30.w,top: 84.h,bottom: 30.h),
          margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 74.h),
          decoration: BoxDecoration(
            color: Color(0xffF5F2E9),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LocalizedTextView(
                "New Version Coming Soon!".tr,
                fontSize: 14.sp,
                color: Colors.black,
                fontType: FontType.extra,
              ),
              SizedBox(height: 20.h,),
              LocalizedTextView(
                "Your feedback has been received! This information is vital to us. We are continuously optimizing the product experience, and a new version will be launched soon. Please stay with us!"
                    .tr,
                fontSize: 14.sp,
                color: Color(0xff5E5E5E),
              ),
              SizedBox(height: 12.h),
              TapGuardView(
                onPressed: controller.onContinueUsingPressed,
                child: Container(
                  width: double.infinity,
                  height: 46.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffC40000),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: LocalizedTextView(
                    "Continue using for free".tr,
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontType: FontType.extra,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TapGuardView(
                onPressed: controller.onLeaveAnywayPressed,
                child: LocalizedTextView(
                  "Leave anyway".tr,
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontType: FontType.extra,
                ),
              ),
            ],
          ),
        ),
        AssetPictureView(
          "feedback/update_dialog_background",
          width: 240.w,
          height: 145.h,
        ),
      ],
    );
  }
}
