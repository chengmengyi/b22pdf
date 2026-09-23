import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_permissions_fems/b22_interface_feda/b22_access_explanation_coordinator_ztof.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_centered_panel_rfcb.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:permission_handler/permission_handler.dart';

class B22AccessExplanationPanelPulh
    extends B22CenteredPanelDsjg<B22AccessExplanationCoordinatorGnhw> {
  final Permission b22PermissionUiuw;
  B22AccessExplanationPanelPulh({required this.b22PermissionUiuw});

  @override
  B22AccessExplanationCoordinatorGnhw createController() =>
      B22AccessExplanationCoordinatorGnhw(b22PermissionBmoh: b22PermissionUiuw);

  @override
  Widget buildDialog(
    BuildContext context,
    B22AccessExplanationCoordinatorGnhw b22ControllerWrle,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 28.w, right: 28.w),
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 16.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          B22TranslatedLabelComponentJklc(
            'b22_permission_required_ldme'.tr,
            b22FontSizeIafw: 16.sp,
            b22ColorZcbj: Colors.black,
            b22FontWeightPcyy: FontWeight.bold,
            b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Color(0xffF3F5F7),
              borderRadius: BorderRadius.circular(8.w),
              border: Border.all(width: 0.5.w, color: Color(0xffEBEBEB)),
            ),
            child: B22TranslatedLabelComponentJklc(
              b22ControllerWrle.b22BuildPermissionMessageEmen(),
              b22FontSizeIafw: 12.sp,
              b22ColorZcbj: Color(0xff4B4D56),
              b22FontTypeQdme: B22FontKindGnzs.b22SemiOvoq,
            ),
          ),
          SizedBox(height: 20.h),
          B22TouchGuardComponentKong(
            b22OnPressedXvbd: b22ControllerWrle.b22OnAllowPressedTfnn,
            b22ChildWksr: Container(
              width: double.infinity,
              height: 48.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              decoration: BoxDecoration(
                color: Color(0xffC40000),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: B22TranslatedLabelComponentJklc(
                'b22_allow_wipn'.tr,
                b22FontSizeIafw: 16.sp,
                b22ColorZcbj: Colors.white,
                b22FontWeightPcyy: FontWeight.bold,
                b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          B22TouchGuardComponentKong(
            b22OnPressedXvbd: () {
              b22ControllerWrle.b22OnLaterPressedOpfw();
            },
            b22ChildWksr: B22TranslatedLabelComponentJklc(
              'b22_later_voor'.tr,
              b22FontSizeIafw: 14.sp,
              b22ColorZcbj: const Color(0xff858C92),
              b22DecorationEtco: TextDecoration.underline,
              b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
            ),
          ),
        ],
      ),
    );
  }
}
