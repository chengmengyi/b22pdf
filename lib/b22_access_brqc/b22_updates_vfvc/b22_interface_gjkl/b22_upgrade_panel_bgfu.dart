import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_updates_vfvc/b22_interface_gjkl/b22_upgrade_coordinator_lmgz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_centered_panel_rfcb.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22UpgradePanelEjrf
    extends B22CenteredPanelDsjg<B22UpgradeCoordinatorHxcb> {
  const B22UpgradePanelEjrf({super.key});

  @override
  B22UpgradeCoordinatorHxcb createController() => B22UpgradeCoordinatorHxcb();

  @override
  Widget buildDialog(
    BuildContext context,
    B22UpgradeCoordinatorHxcb b22ControllerJrma,
  ) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
            top: 84.h,
            bottom: 30.h,
          ),
          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 74.h),
          decoration: BoxDecoration(
            color: Color(0xffF5F2E9),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              B22TranslatedLabelComponentJklc(
                "New Version Coming Soon!".tr,
                b22FontSizeIafw: 14.sp,
                b22ColorZcbj: Colors.black,
                b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
              ),
              SizedBox(height: 20.h),
              B22TranslatedLabelComponentJklc(
                "Your feedback has been received! This information is vital to us. We are continuously optimizing the product experience, and a new version will be launched soon. Please stay with us!"
                    .tr,
                b22FontSizeIafw: 14.sp,
                b22ColorZcbj: Color(0xff5E5E5E),
              ),
              SizedBox(height: 12.h),
              B22TouchGuardComponentKong(
                b22OnPressedXvbd:
                    b22ControllerJrma.b22OnContinueUsingPressedSbeb,
                b22ChildWksr: Container(
                  width: double.infinity,
                  height: 46.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffC40000),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: B22TranslatedLabelComponentJklc(
                    "Continue using for free".tr,
                    b22FontSizeIafw: 16.sp,
                    b22ColorZcbj: Colors.white,
                    b22FontWeightPcyy: FontWeight.bold,
                    b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              B22TouchGuardComponentKong(
                b22OnPressedXvbd: b22ControllerJrma.b22OnLeaveAnywayPressedOgjc,
                b22ChildWksr: B22TranslatedLabelComponentJklc(
                  "Leave anyway".tr,
                  b22FontSizeIafw: 14.sp,
                  b22ColorZcbj: Colors.black,
                  b22FontWeightPcyy: FontWeight.w500,
                  b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                ),
              ),
            ],
          ),
        ),
        B22ResourceImageComponentXjch(
          "b22_engagement_media_aquq/b22_feedback_prompts_ptmx/b22_update_prompt_backdrop_etvc",
          b22WidthKbfi: 240.w,
          b22HeightUsfn: 145.h,
        ),
      ],
    );
  }
}
