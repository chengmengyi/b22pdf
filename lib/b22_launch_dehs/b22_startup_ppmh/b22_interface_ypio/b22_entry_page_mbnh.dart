import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_interface_ypio/b22_entry_coordinator_qupi.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22EntryPageAwcy extends B22FoundationPageNhfc<B22EntryCoordinatorVdiw> {
  const B22EntryPageAwcy({super.key});

  @override
  B22EntryCoordinatorVdiw createController() {
    return B22EntryCoordinatorVdiw();
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22EntryCoordinatorVdiw controller,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 160.h),
          B22ResourceImageComponentXjch(
            'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_product_mark_wana',
            b22WidthKbfi: 88.w,
            b22HeightUsfn: 88.w,
          ),
          SizedBox(height: 20.h),
          B22TranslatedLabelComponentJklc(
            'b22_your_pocket_file_pro_bwdt'.tr,
            b22FontSizeIafw: 18.sp,
            b22ColorZcbj: Color(0xff0F172A),
            b22FontWeightPcyy: FontWeight.w900,
            b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
          ),
          const Spacer(),
          GetBuilder<B22EntryCoordinatorVdiw>(
            id: B22EntryCoordinatorVdiw.b22ProgressUpdateIdKlmp,
            builder: (B22EntryCoordinatorVdiw b22ControllerWnna) {
              return b22BuildProgressIndicatorNtuc(
                b22ControllerWnna.progressValue,
              );
            },
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget b22BuildProgressIndicatorNtuc(double b22ProgressWewy) {
    final double b22SafeProgressCkvp = b22ProgressWewy.clamp(0.0, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            B22TranslatedLabelComponentJklc(
              "${(b22SafeProgressCkvp * 100).toInt()}",
              b22FontSizeIafw: 32.sp,
              b22ColorZcbj: Color(0xff970000),
              b22FontWeightPcyy: FontWeight.w900,
              b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
            ),
            B22TranslatedLabelComponentJklc(
              "%",
              b22FontSizeIafw: 18.sp,
              b22ColorZcbj: Colors.black,
              b22FontWeightPcyy: FontWeight.w900,
              b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
            ),
          ],
        ),
        Container(
          width: 222.w,
          height: 12.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.1)),
          child: Container(
            width: (222.w) * b22SafeProgressCkvp,
            height: 12.h,
            decoration: BoxDecoration(color: Color(0xff970000)),
          ),
        ),
      ],
    );
  }
}
