import 'dart:async';

import 'package:b21pdf/core/config/app_config.dart';
import 'package:b21pdf/core/navigation/app_navigator.dart';
import 'package:b21pdf/core/presentation/controller_widget.dart';
import 'package:b21pdf/features/settings/overlay_permission/overlay_permission_prompt_controller.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/pulse_view.dart';
import 'package:b21pdf/shared/widgets/switch_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OverlayPermissionPrompt
    extends ControllerWidget<OverlayPermissionPromptController> {
  const OverlayPermissionPrompt({
    super.key,
    required this.onSettingsComplete,
    required this.onLater,
  });

  final FutureOr<void> Function() onSettingsComplete;
  final FutureOr<void> Function() onLater;

  @override
  OverlayPermissionPromptController createController() {
    return OverlayPermissionPromptController(
      onSettingsComplete: onSettingsComplete,
      onLater: onLater,
    );
  }

  @override
  Widget buildContent(
    BuildContext context,
    OverlayPermissionPromptController controller,
  ) {
    return PopScope(
      canPop: false,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffF5F2E9),
          border: BoxBorder.fromLTRB(
            top: BorderSide(
              width: 4.w,
              color: Color(0xff970000),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: LocalizedTextView(
                      'Unlock Your PDF is Full Potential!'.tr,
                      fontSize: 16.sp,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500,
                      fontType: FontType.extra,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 2.h,
                color: Colors.black,
                margin: EdgeInsets.only(top: 10.h),
              ),
              SizedBox(height: 24.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
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
              SizedBox(height: 28.h),
              PulseView(
                child: TapGuardView(
                  onPressed: controller.openSettings,
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffC40000),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: LocalizedTextView(
                      'GO SETTING'.tr,
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TapGuardView(
                onPressed: controller.continueWithoutPermission,
                child: LocalizedTextView(
                  'Later'.tr,
                  fontSize: 14.sp,
                  color: const Color(0xff7B7B7B),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
