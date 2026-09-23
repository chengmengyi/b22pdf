import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_document_sort_mhfz/b22_file_ordering_coordinator_dggv.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_module_jrix.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22FileOrderingLowerDrawerFkmq
    extends B22CoordinatorModuleFqaw<B22FileOrderingCoordinatorBgjb> {
  final B22OrderingKindDybz b22SelectedTypeHyxa;
  B22FileOrderingLowerDrawerFkmq({required this.b22SelectedTypeHyxa});

  @override
  B22FileOrderingCoordinatorBgjb createController() =>
      B22FileOrderingCoordinatorBgjb(b22SelectedTypeOxra: b22SelectedTypeHyxa);

  @override
  Widget buildContent(
    BuildContext context,
    B22FileOrderingCoordinatorBgjb b22ControllerWpdk,
  ) {
    return Container(
      color: Color(0xffF5F2E9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          b22BuildTitleSectionJnso(),
          b22BuildLanguageListQgvd(b22ControllerWpdk),
        ],
      ),
    );
  }

  b22BuildLanguageListQgvd(
    B22FileOrderingCoordinatorBgjb b22ControllerOgnb,
  ) => B22SafeAreaInsetComponentUiga(
    b22ChildVezd: ListView.builder(
      shrinkWrap: true,
      itemCount: B22OrderingKindDybz.values.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, b22IndexAosr) {
        var b22TypeFaxt = B22OrderingKindDybz.values[b22IndexAosr];
        final bool b22SelectedRhga =
            b22TypeFaxt == b22ControllerOgnb.b22SelectedTypeOxra;
        return B22TouchGuardComponentKong(
          b22OnPressedXvbd: () {
            b22ControllerOgnb.b22OnSortPressedXaig(b22TypeFaxt);
          },
          b22ChildWksr: Container(
            width: double.infinity,
            height: 73.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            decoration: BoxDecoration(
              color: b22SelectedRhga ? Color(0xff970000) : null,
              border: b22SelectedRhga
                  ? BoxBorder.fromLTRB(
                      top: BorderSide(width: 2.w, color: Colors.black),
                      bottom: BorderSide(width: 2.w, color: Colors.black),
                    )
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      B22TranslatedLabelComponentJklc(
                        b22TypeFaxt.b22TextLvaa.tr,
                        b22FontSizeIafw: 16.sp,
                        b22ColorZcbj: b22SelectedRhga
                            ? Colors.white
                            : Colors.black,
                        b22FontWeightPcyy: FontWeight.w500,
                        b22OverflowUwxb: TextOverflow.ellipsis,
                        b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                      ),
                      B22TranslatedLabelComponentJklc(
                        b22TypeFaxt.b22DescBgjc.tr,
                        b22FontSizeIafw: 12.sp,
                        b22ColorZcbj: b22SelectedRhga
                            ? Colors.white
                            : Colors.black,
                        b22FontWeightPcyy: FontWeight.w500,
                        b22OverflowUwxb: TextOverflow.ellipsis,
                        b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                if (b22SelectedRhga)
                  B22ResourceImageComponentXjch(
                    "b22_workspace_media_vwug/b22_library_actions_pxds/b22_sort_choice_marker_sjpe",
                    b22WidthKbfi: 28.w,
                    b22HeightUsfn: 28.w,
                  ),
              ],
            ),
          ),
        );
      },
    ),
  );

  b22BuildTitleSectionJnso() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: double.infinity, height: 3.h, color: Color(0xff970000)),
      SizedBox(
        width: double.infinity,
        height: 64.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 20.w),
                child: B22TranslatedLabelComponentJklc(
                  'b22_sort_by_uflo'.tr,
                  b22FontSizeIafw: 20.sp,
                  b22ColorZcbj: Color(0xff000000),
                  b22FontWeightPcyy: FontWeight.bold,
                  b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 16.w),
                child: B22TouchGuardComponentKong(
                  b22OnPressedXvbd: () {
                    B22ApplicationRouterJfva.b22BackCwkm();
                  },
                  b22ChildWksr: B22ResourceImageComponentXjch(
                    "b22_shared_controls_ybsz/b22_navigation_actions_dmkw/b22_navigate_dismiss_qndw",
                    b22WidthKbfi: 28.w,
                    b22HeightUsfn: 28.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
