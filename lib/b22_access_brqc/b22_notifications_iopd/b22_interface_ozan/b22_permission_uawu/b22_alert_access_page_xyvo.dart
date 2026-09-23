import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_interface_ozan/b22_permission_uawu/b22_alert_access_coordinator_ypyk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_breathing_component_etnr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_toggle_component_ndlv.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class B22AlertAccessPageNwlv
    extends B22FoundationPageNhfc<B22AlertAccessCoordinatorVaez> {
  const B22AlertAccessPageNwlv({super.key});

  @override
  B22AlertAccessCoordinatorVaez createController() {
    return B22AlertAccessCoordinatorVaez();
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22AlertAccessCoordinatorVaez b22ControllerTykm,
  ) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        B22ResourceImageComponentXjch(
          'b22_access_media_ydmf/b22_permission_guides_nmul/b22_overlay_access_guide_sqce',
          b22WidthKbfi: double.infinity,
          b22HeightUsfn: 360.h,
        ),
        Column(
          children: [
            SizedBox(height: 130.h),
            B22ResourceImageComponentXjch(
              "b22_access_media_ydmf/b22_permission_guides_nmul/b22_notification_access_preview_lkng",
              b22WidthKbfi: 203.w,
              b22HeightUsfn: 140.h,
            ),
            SizedBox(height: 24.h),
            B22TranslatedLabelComponentJklc(
              'b22_stay_update_keim'.tr,
              b22FontSizeIafw: 20.sp,
              b22ColorZcbj: Color(0xff07080E),
              b22FontWeightPcyy: FontWeight.bold,
              b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
            ),
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              child: B22TranslatedLabelComponentJklc(
                'b22_enable_notifications_to_get_instant_vclz'.tr,
                b22FontSizeIafw: 14.sp,
                b22ColorZcbj: Color(0xff5E5E5E),
                b22FontWeightPcyy: FontWeight.w500,
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
                  B22ResourceImageComponentXjch(
                    'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_product_mark_wana',
                    b22WidthKbfi: 48.w,
                    b22HeightUsfn: 48.w,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        B22TranslatedLabelComponentJklc(
                          'b22_application_name_vqtr'.tr,
                          b22FontSizeIafw: 14.sp,
                          b22ColorZcbj: Colors.black,
                          b22FontWeightPcyy: FontWeight.bold,
                          b22OverflowUwxb: TextOverflow.ellipsis,
                          b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                        ),
                        B22TranslatedLabelComponentJklc(
                          'b22_all_notifications_ernr'.tr,
                          b22FontSizeIafw: 12.sp,
                          b22ColorZcbj: Color(0xff979796),
                          b22FontTypeQdme: B22FontKindGnzs.b22SemiOvoq,
                        ),
                      ],
                    ),
                  ),
                  const B22ToggleComponentUfkj(),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1.Tap The Toggle Switch Above
                // 2.Allow Notifications In System Settings
                B22TranslatedLabelComponentJklc(
                  'b22_1_tap_the_toggle_switch_kzft'.tr,
                  b22FontSizeIafw: 14.sp,
                  b22ColorZcbj: const Color(0xff5E5E5E),
                  b22FontWeightPcyy: FontWeight.w500,
                ),
                B22TranslatedLabelComponentJklc(
                  'b22_2_allow_notifications_in_system_oues'.tr,
                  b22FontSizeIafw: 14.sp,
                  b22ColorZcbj: const Color(0xff5E5E5E),
                  b22FontWeightPcyy: FontWeight.w500,
                ),
              ],
            ),
            Spacer(),
            B22BreathingComponentFhqe(
              b22ChildFnjn: B22TouchGuardComponentKong(
                b22OnPressedXvbd: () {
                  b22ControllerTykm.b22OnUpdatePressedAsvc();
                },
                b22ChildWksr: Container(
                  width: double.infinity,
                  height: 48.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Color(0xffC40000),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: B22TranslatedLabelComponentJklc(
                    'b22_update_now_jcyj'.tr,
                    b22FontSizeIafw: 16.sp,
                    b22ColorZcbj: Colors.white,
                    b22FontWeightPcyy: FontWeight.bold,
                    b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            B22TouchGuardComponentKong(
              b22OnPressedXvbd: b22ControllerTykm.b22OnLaterPressedGjhp,
              b22ChildWksr: B22TranslatedLabelComponentJklc(
                'b22_later_voor'.tr,
                b22FontSizeIafw: 14.sp,
                b22ColorZcbj: const Color(0xff525759),
                b22DecorationEtco: TextDecoration.underline,
                b22FontWeightPcyy: FontWeight.bold,
                b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ],
    );
  }
}
