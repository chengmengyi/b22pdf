import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_overlay_permission_dajf/b22_floating_layer_access_coordinator_kkgv.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_breathing_component_etnr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_toggle_component_ndlv.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22FloatingLayerAccessPageIemy
    extends B22FoundationPageNhfc<B22FloatingLayerAccessCoordinatorNjpi> {
  const B22FloatingLayerAccessPageIemy({super.key});

  @override
  B22FloatingLayerAccessCoordinatorNjpi createController() {
    return B22FloatingLayerAccessCoordinatorNjpi();
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22FloatingLayerAccessCoordinatorNjpi b22ControllerCjhp,
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
              'b22_access_media_ydmf/b22_permission_guides_nmul/b22_overlay_access_preview_urne',
              b22WidthKbfi: 193.w,
              b22HeightUsfn: 140.h,
            ),
            SizedBox(height: 24.h),
            B22TranslatedLabelComponentJklc(
              'This App Has An Update.'.tr,
              b22FontSizeIafw: 16.sp,
              b22ColorZcbj: Colors.black,
              b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
            ),
            SizedBox(height: 24.h),
            B22TranslatedLabelComponentJklc(
              'Please upgrade to enjoy the latest functions.'.tr,
              b22FontSizeIafw: 14.sp,
              b22ColorZcbj: const Color(0xff5E5E5E),
              b22FontWeightPcyy: FontWeight.w500,
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
            const Spacer(),
            B22BreathingComponentFhqe(
              b22ChildFnjn: B22TouchGuardComponentKong(
                b22OnPressedXvbd: b22ControllerCjhp.b22OnContinuePressedEdsa,
                b22ChildWksr: Container(
                  width: double.infinity,
                  height: 48.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Color(0xffC40000),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: B22TranslatedLabelComponentJklc(
                    'Update Now'.tr,
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
              b22OnPressedXvbd: b22ControllerCjhp.b22OnLaterPressedZntd,
              b22ChildWksr: B22TranslatedLabelComponentJklc(
                'Later'.tr,
                b22FontSizeIafw: 14.sp,
                b22ColorZcbj: const Color(0xff4b5156),
                b22DecorationEtco: TextDecoration.underline,
                b22FontWeightPcyy: FontWeight.bold,
                b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
              ),
            ),
            SizedBox(height: 36.h),
          ],
        ),
      ],
    );
  }
}
