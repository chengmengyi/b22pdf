import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_interface_brpn/b22_locale_chooser_coordinator_mngl.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_supported_languages_jjnw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_module_jrix.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22LocaleChooserLowerDrawerGtjc
    extends B22CoordinatorModuleFqaw<B22LocaleChooserCoordinatorAboc> {
  const B22LocaleChooserLowerDrawerGtjc({super.key});

  @override
  B22LocaleChooserCoordinatorAboc createController() =>
      B22LocaleChooserCoordinatorAboc();
  @override
  Widget buildContent(
    BuildContext context,
    B22LocaleChooserCoordinatorAboc b22ControllerQvdz,
  ) => GetBuilder<B22LocaleChooserCoordinatorAboc>(
    init: b22ControllerQvdz,
    global: false,
    builder: (b22ControllerDygz) => Container(
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
          b22BuildTitleSectionHqjf(),
          Container(
            width: double.infinity,
            height: 2.h,
            color: Colors.black,
            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
          ),
          b22BuildContentSectionYawt(b22ControllerDygz),
        ],
      ),
    ),
  );

  Widget b22BuildContentSectionYawt(
    B22LocaleChooserCoordinatorAboc b22ControllerDnra,
  ) => Container(
    width: double.infinity,
    height: 448.h,
    child: B22SafeAreaInsetComponentUiga(
      b22ChildVezd: ListView.builder(
        controller: b22ControllerDnra.b22LanguageScrollControllerVjrn,
        itemCount: b22ControllerDnra.languageList.length,
        itemBuilder: (context, b22IndexUnhw) {
          final B22SupportedLanguageVhey b22ItemPyfh =
              b22ControllerDnra.languageList[b22IndexUnhw];
          final b22SelectedGhbv = b22ControllerDnra.b22IsSelectedUynn(
            b22ItemPyfh,
          );
          return B22TouchGuardComponentKong(
            b22OnPressedXvbd: () =>
                b22ControllerDnra.b22OnLanguagePressedBtys(b22ItemPyfh),
            b22ChildWksr: Container(
              width: double.infinity,
              height: 56.h,
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              child: Row(
                children: [
                  B22ResourceImageComponentXjch(
                    b22ItemPyfh.b22IconBznb,
                    b22WidthKbfi: 32.w,
                    b22HeightUsfn: 32.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: B22TranslatedLabelComponentJklc(
                      b22ItemPyfh.b22NameYzxf,
                      b22FontSizeIafw: 14.sp,
                      b22ColorZcbj: const Color(0xff060E23),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  B22ResourceImageComponentXjch(
                    b22SelectedGhbv
                        ? 'b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_active_rpff'
                        : 'b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_inactive_yslq',
                    b22WidthKbfi: 28.w,
                    b22HeightUsfn: 28.w,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );

  Widget b22BuildTitleSectionHqjf() => Row(
    children: [
      B22TranslatedLabelComponentJklc(
        'b22_app_language_cmhv'.tr,
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
  );
}
