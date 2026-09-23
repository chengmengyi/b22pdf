import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_home_widget_wejh/b22_interface_oywi/b22_dashboard_module_coordinator_nfgt.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_home_widget_wejh/b22_operations_dntq/b22_dashboard_module_orchestrator_knhc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_module_jrix.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class B22DashboardModuleLowerDrawerWjqk
    extends B22CoordinatorModuleFqaw<B22DashboardModuleCoordinatorOyon> {
  const B22DashboardModuleLowerDrawerWjqk({super.key});

  @override
  B22DashboardModuleCoordinatorOyon createController() =>
      B22DashboardModuleCoordinatorOyon();

  @override
  Widget buildContent(
    BuildContext context,
    B22DashboardModuleCoordinatorOyon b22ControllerQwbs,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Color(0xffF5F2E9),
        border: BoxBorder.fromLTRB(
          top: BorderSide(width: 4.w, color: Color(0xffC40000)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          b22TitleWidgetFnqe(),
          SizedBox(height: 20.h),
          b22BuildContentSectionBztb(),
          SizedBox(height: 28.h),
          B22TouchGuardComponentKong(
            b22OnPressedXvbd: () {
              b22ControllerQwbs.b22OnAddPressedMjok();
            },
            b22ChildWksr: Container(
              width: double.infinity,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffC40000),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: B22TranslatedLabelComponentJklc(
                "+ ${"Add".tr}",
                b22FontSizeIafw: 16.sp,
                b22ColorZcbj: Colors.white,
                b22FontWeightPcyy: FontWeight.bold,
                b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget b22BuildContentSectionBztb() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            B22ResourceImageComponentXjch(
              'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_product_mark_wana',
              b22WidthKbfi: 20.w,
              b22HeightUsfn: 20.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: B22TranslatedLabelComponentJklc(
                B22ApplicationManifestPdpm.b22ApplicationNameBjnh.tr,
                b22FontSizeIafw: 12.sp,
                b22ColorZcbj: Colors.black,
                b22FontWeightPcyy: FontWeight.bold,
                b22OverflowUwxb: TextOverflow.ellipsis,
                b22FontTypeQdme: B22FontKindGnzs.b22SemiOvoq,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          height: 42.h,
          decoration: BoxDecoration(
            color: Color(0xffF5F2E9),
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(width: 2.w, color: Color(0xff000000)),
          ),
          child: Row(
            children: [
              SizedBox(width: 12.w),
              B22ResourceImageComponentXjch(
                "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_search_action_ngnz",
                b22WidthKbfi: 28.w,
                b22HeightUsfn: 28.w,
              ),
              SizedBox(width: 8.w),
              B22TranslatedLabelComponentJklc(
                "Search...".tr,
                b22FontSizeIafw: 12.sp,
                b22ColorZcbj: Color(0xff5E5E5E),
                b22FontTypeQdme: B22FontKindGnzs.b22SemiOvoq,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        B22SafeAreaInsetComponentUiga(
          b22ChildVezd: MasonryGridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 8.w,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: B22InstallModuleKindBmus.values.length,
            itemBuilder: (BuildContext context, int b22IndexNfwb) {
              var b22TypeKvhq = B22InstallModuleKindBmus.values[b22IndexNfwb];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  B22ResourceImageComponentXjch(
                    "b22_widget_extension_media_btai/b22_widget_resources_csgz/${b22TypeKvhq.b22IconUuzk}",
                    b22WidthKbfi: 32.w,
                    b22HeightUsfn: 32.w,
                  ),
                  SizedBox(height: 4.h),
                  B22TranslatedLabelComponentJklc(
                    b22TypeKvhq.b22TextVubl.tr,
                    b22FontSizeIafw: 10.sp,
                    b22ColorZcbj: Colors.black,
                    b22FontWeightPcyy: FontWeight.bold,
                    b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
                    b22OverflowUwxb: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );

  b22TitleWidgetFnqe() => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          B22TranslatedLabelComponentJklc(
            'Add Widget'.tr,
            b22FontSizeIafw: 16.sp,
            b22ColorZcbj: Color(0xff000000),
            b22FontWeightPcyy: FontWeight.w500,
            b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
          ),
          Spacer(),
          B22TouchGuardComponentKong(
            b22OnPressedXvbd: () {
              B22ApplicationRouterJfva.b22BackCwkm();
            },
            b22ChildWksr: B22ResourceImageComponentXjch(
              "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_dismiss_action_bnlh",
              b22WidthKbfi: 14.w,
              b22HeightUsfn: 14.w,
            ),
          ),
        ],
      ),
      SizedBox(height: 10.h),
      B22TranslatedLabelComponentJklc(
        'Add widget with one click to open files'.tr,
        b22FontSizeIafw: 14.sp,
        b22ColorZcbj: const Color(0xff5E5E5E),
        b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
      ),
      Container(
        width: double.infinity,
        height: 2.h,
        color: Colors.black,
        margin: EdgeInsets.only(top: 10.h),
      ),
    ],
  );
}
