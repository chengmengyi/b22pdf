import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_interface_swtj/b22_image_selection_wxeq/b22_picture_chooser_coordinator_sjia.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22PictureChooserPageVaxe
    extends B22FoundationPageNhfc<B22PictureChooserCoordinatorYvnf> {
  const B22PictureChooserPageVaxe({super.key});

  @override
  B22PictureChooserCoordinatorYvnf createController() {
    return B22PictureChooserCoordinatorYvnf();
  }

  @override
  Color get navigationBarColor => Colors.white;

  @override
  Widget buildContent(
    BuildContext context,
    B22PictureChooserCoordinatorYvnf controller,
  ) {
    return GetBuilder<B22PictureChooserCoordinatorYvnf>(
      builder: (B22PictureChooserCoordinatorYvnf b22ControllerInjd) => Column(
        children: [
          b22BuildTitleBarHltv(b22ControllerInjd),
          b22BuildMainContentAhhq(b22ControllerInjd),
          b22BuildBottomBarYdzz(b22ControllerInjd),
        ],
      ),
    );
  }

  Widget b22BuildBottomBarYdzz(
    B22PictureChooserCoordinatorYvnf b22ControllerTprx,
  ) => Container(
    width: double.infinity,
    height: 66.h,
    padding: EdgeInsets.only(left: 12.w, right: 12.w),
    decoration: BoxDecoration(
      color: Color(0xffFFFAF6),
      border: BoxBorder.fromLTRB(
        top: BorderSide(width: 2.w, color: Colors.black),
      ),
    ),
    child: Row(
      children: [
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerTprx.b22OnReplacePressedQrex,
          b22ChildWksr: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              B22ResourceImageComponentXjch(
                "b22_conversion_media_xzqz/b22_tool_actions_wwfr/b22_rescan_action_ftzp",
                b22WidthKbfi: 28.w,
                b22HeightUsfn: 28.w,
              ),
              SizedBox(width: 4.h),
              B22TranslatedLabelComponentJklc(
                'b22_retake_hkla'.tr,
                b22FontSizeIafw: 12.sp,
                b22ColorZcbj: Color(0xff333333),
                b22FontWeightPcyy: FontWeight.w500,
                b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerTprx.b22OnAddPressedIkhb,
          b22ChildWksr: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              B22ResourceImageComponentXjch(
                "b22_conversion_media_xzqz/b22_tool_actions_wwfr/b22_page_add_action_dfwv",
                b22WidthKbfi: 28.w,
                b22HeightUsfn: 28.w,
              ),
              SizedBox(width: 4.h),
              B22TranslatedLabelComponentJklc(
                'b22_add_hibq'.tr,
                b22FontSizeIafw: 12.sp,
                b22ColorZcbj: Color(0xff333333),
                b22FontWeightPcyy: FontWeight.w500,
                b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: B22TouchGuardComponentKong(
            b22OnPressedXvbd: () {
              b22ControllerTprx.b22OnSavePressedUysx();
            },
            b22ChildWksr: Container(
              width: double.infinity,
              height: 44.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffC40000),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  B22ResourceImageComponentXjch(
                    "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_confirm_action_light_rqzj",
                    b22WidthKbfi: 18.w,
                    b22HeightUsfn: 18.w,
                  ),
                  SizedBox(width: 4.w),
                  B22TranslatedLabelComponentJklc(
                    'b22_save_pdf_yqps'.tr,
                    b22FontSizeIafw: 14.sp,
                    b22ColorZcbj: Colors.white,
                    b22FontWeightPcyy: FontWeight.bold,
                    b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget b22BuildMainContentAhhq(
    B22PictureChooserCoordinatorYvnf b22ControllerUatm,
  ) => Expanded(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(0, -0.5),
          ),
        ],
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: b22ControllerUatm.b22PageControllerNxbn,
            itemCount: b22ControllerUatm.b22ImagePathsVrel.length,
            onPageChanged: b22ControllerUatm.b22OnPageChangedIljj,
            itemBuilder: (_, int b22IndexCbyl) {
              return Image.file(
                File(b22ControllerUatm.b22ImagePathsVrel[b22IndexCbyl]),
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: b22PagesWidgetXvtx(b22ControllerUatm),
          ),
        ],
      ),
    ),
  );

  b22PagesWidgetXvtx(
    B22PictureChooserCoordinatorYvnf b22ControllerGheo,
  ) => Container(
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
      color: Color(0xffF2E9D9).withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(2.w),
      border: Border.all(width: 1.w, color: Colors.black),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerGheo.b22SelectedIndexAjvl > 0
              ? b22ControllerGheo.b22ShowPreviousPageJgkn
              : null,
          b22ChildWksr: B22ResourceImageComponentXjch(
            "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_previous_page_control_jlfh",
            b22WidthKbfi: 32.w,
            b22HeightUsfn: 32.w,
          ),
        ),
        Container(width: 1.w, height: 16.h, color: Colors.black),
        SizedBox(width: 24.w),
        B22TranslatedLabelComponentJklc(
          "${b22ControllerGheo.b22ImagePathsVrel.isEmpty ? 0 : b22ControllerGheo.b22SelectedIndexAjvl + 1} / ${b22ControllerGheo.b22ImagePathsVrel.length}",
          b22FontSizeIafw: 14.sp,
          b22ColorZcbj: Colors.black,
          b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
        ),
        SizedBox(width: 24.w),
        Container(width: 1.w, height: 16.h, color: Colors.black),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd:
              b22ControllerGheo.b22SelectedIndexAjvl <
                  b22ControllerGheo.b22ImagePathsVrel.length - 1
              ? b22ControllerGheo.b22ShowNextPageSscg
              : null,
          b22ChildWksr: B22ResourceImageComponentXjch(
            "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_next_page_control_roec",
            b22WidthKbfi: 32.w,
            b22HeightUsfn: 32.w,
          ),
        ),
      ],
    ),
  );

  Widget b22BuildTitleBarHltv(
    B22PictureChooserCoordinatorYvnf b22ControllerFeox,
  ) => Container(
    width: double.infinity,
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        height: 54.h,
        child: Stack(
          children: [
            B22TouchGuardComponentKong(
              b22OnPressedXvbd: b22ControllerFeox.b22OnBackPressedRbqo,
              b22ChildWksr: SizedBox(
                width: 44.w,
                height: 44.h,
                child: Center(
                  child: B22ResourceImageComponentXjch(
                    'b22_shared_controls_ybsz/b22_navigation_actions_dmkw/b22_navigate_back_fylg',
                    b22WidthKbfi: 28.w,
                    b22HeightUsfn: 28.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
