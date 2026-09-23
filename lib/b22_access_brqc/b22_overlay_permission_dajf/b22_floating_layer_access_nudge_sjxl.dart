import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_module_jrix.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_overlay_permission_dajf/b22_floating_layer_access_nudge_coordinator_ucai.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_breathing_component_etnr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_toggle_component_ndlv.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22FloatingLayerAccessNudgeMeau
    extends
        B22CoordinatorModuleFqaw<B22FloatingLayerAccessNudgeCoordinatorQkdz> {
  const B22FloatingLayerAccessNudgeMeau({
    super.key,
    required this.b22OnSettingsCompleteFwnq,
    required this.b22OnLaterMnlt,
  });

  final FutureOr<void> Function() b22OnSettingsCompleteFwnq;
  final FutureOr<void> Function() b22OnLaterMnlt;

  @override
  B22FloatingLayerAccessNudgeCoordinatorQkdz createController() {
    return B22FloatingLayerAccessNudgeCoordinatorQkdz(
      b22OnSettingsCompleteIjip: b22OnSettingsCompleteFwnq,
      b22OnLaterJkla: b22OnLaterMnlt,
    );
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22FloatingLayerAccessNudgeCoordinatorQkdz b22ControllerKoor,
  ) {
    return PopScope(
      canPop: false,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffF5F2E9),
          border: BoxBorder.fromLTRB(
            top: BorderSide(width: 4.w, color: Color(0xff970000)),
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
                    child: B22TranslatedLabelComponentJklc(
                      'Unlock Your PDF is Full Potential!'.tr,
                      b22FontSizeIafw: 16.sp,
                      b22ColorZcbj: Color(0xff000000),
                      b22FontWeightPcyy: FontWeight.w500,
                      b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
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
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Row(
                  children: [
                    B22ResourceImageComponentXjch(
                      'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_product_mark_wana',
                      b22WidthKbfi: 40.w,
                      b22HeightUsfn: 40.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: B22TranslatedLabelComponentJklc(
                        B22ApplicationManifestPdpm.b22ApplicationNameBjnh.tr,
                        b22FontSizeIafw: 12.sp,
                        b22ColorZcbj: Colors.black,
                        b22FontWeightPcyy: FontWeight.bold,
                        b22OverflowUwxb: TextOverflow.ellipsis,
                        b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                      ),
                    ),
                    const B22ToggleComponentUfkj(),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              B22BreathingComponentFhqe(
                b22ChildFnjn: B22TouchGuardComponentKong(
                  b22OnPressedXvbd: b22ControllerKoor.b22OpenSettingsDcxa,
                  b22ChildWksr: Container(
                    width: double.infinity,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffC40000),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: B22TranslatedLabelComponentJklc(
                      'GO SETTING'.tr,
                      b22FontSizeIafw: 16.sp,
                      b22ColorZcbj: Colors.white,
                      b22FontWeightPcyy: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              B22TouchGuardComponentKong(
                b22OnPressedXvbd:
                    b22ControllerKoor.b22ContinueWithoutPermissionQmrd,
                b22ChildWksr: B22TranslatedLabelComponentJklc(
                  'Later'.tr,
                  b22FontSizeIafw: 14.sp,
                  b22ColorZcbj: const Color(0xff7B7B7B),
                  b22FontWeightPcyy: FontWeight.bold,
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
