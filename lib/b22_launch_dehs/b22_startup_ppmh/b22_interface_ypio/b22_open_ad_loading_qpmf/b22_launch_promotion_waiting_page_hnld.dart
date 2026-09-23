import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_interface_ypio/b22_open_ad_loading_qpmf/b22_launch_promotion_waiting_coordinator_dbxc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22LaunchPromotionWaitingPageXbsa
    extends B22FoundationPageNhfc<B22LaunchPromotionWaitingCoordinatorXnlw> {
  B22LaunchPromotionWaitingPageXbsa({super.key})
    : b22ControllerTagKdgq = 'open_ad_loading_${b22NextControllerIdFdim++}';

  static int b22NextControllerIdFdim = 0;

  final String b22ControllerTagKdgq;

  @override
  String get controllerTag => b22ControllerTagKdgq;

  @override
  B22LaunchPromotionWaitingCoordinatorXnlw createController() =>
      B22LaunchPromotionWaitingCoordinatorXnlw();

  @override
  Future<bool> canPopRoute(
    B22LaunchPromotionWaitingCoordinatorXnlw controller,
  ) async => false;

  @override
  Widget buildContent(
    BuildContext context,
    B22LaunchPromotionWaitingCoordinatorXnlw controller,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(height: 160.h),
        B22ResourceImageComponentXjch(
          'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_product_mark_wana',
          b22WidthKbfi: 88.w,
          b22HeightUsfn: 88.w,
        ),
        SizedBox(height: 20.h),
        B22TranslatedLabelComponentJklc(
          'Your pocket file pro'.tr,
          b22FontSizeIafw: 16.sp,
          b22ColorZcbj: const Color(0xff07080E),
          b22FontWeightPcyy: FontWeight.bold,
        ),
        const Spacer(),
        GetBuilder<B22LaunchPromotionWaitingCoordinatorXnlw>(
          tag: controllerTag,
          id: B22LaunchPromotionWaitingCoordinatorXnlw.b22ProgressUpdateIdAueu,
          builder:
              (B22LaunchPromotionWaitingCoordinatorXnlw b22ControllerHegi) =>
                  b22BuildProgressIndicatorDgpw(
                    b22ControllerHegi.b22ProgressIzjg,
                  ),
        ),
        SizedBox(height: 120.h),
      ],
    );
  }

  Widget b22BuildProgressIndicatorDgpw(double b22ProgressWshk) {
    final double b22SafeProgressAdnt = b22ProgressWshk.clamp(0.0, 1.0);
    return Container(
      width: double.infinity,
      height: 12.h,
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints b22ConstraintsFbop) {
          final double b22TrackWidthEvzh = b22ConstraintsFbop.maxWidth - 4.w;
          return Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xffF5F7F9),
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: AnimatedContainer(
              duration:
                  B22LaunchPromotionWaitingCoordinatorXnlw.b22TickIntervalXmdr,
              width: b22TrackWidthEvzh * b22SafeProgressAdnt,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xffCF251F),
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
          );
        },
      ),
    );
  }
}
