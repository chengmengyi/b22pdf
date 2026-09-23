import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_centered_panel_rfcb.dart';
import 'package:b22_document_workspace_kmzm/b22_engagement_xkaj/b22_feedback_mtfc/b22_interface_sehm/b22_review_coordinator_fqro.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_module_jrix.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class B22ReviewPanelPomf
    extends B22CenteredPanelDsjg<B22ReviewCoordinatorErib> {
  const B22ReviewPanelPomf({super.key});

  @override
  B22ReviewCoordinatorErib createController() => B22ReviewCoordinatorErib();

  @override
  Widget buildDialog(
    BuildContext context,
    B22ReviewCoordinatorErib b22ControllerDwzs,
  ) {
    return B22TouchGuardComponentKong(
      b22OnPressedXvbd: () {
        b22ControllerDwzs.b22OnRateUsPressedQhjc();
      },
      b22ChildWksr: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 74.h),
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              bottom: 30.h,
              top: 83.h,
            ),
            decoration: BoxDecoration(
              color: Color(0xffF5F2E9),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                B22TranslatedLabelComponentJklc(
                  'b22_enjoying_pdf_reader_vrtb'.tr,
                  b22FontSizeIafw: 16.sp,
                  b22ColorZcbj: Colors.black,
                  b22FontWeightPcyy: FontWeight.bold,
                  b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
                ),
                SizedBox(height: 10.h),
                B22TranslatedLabelComponentJklc(
                  'b22_your_5_star_rating_helps_adap'.tr,
                  b22FontSizeIafw: 14.sp,
                  b22ColorZcbj: Color(0xff5E5E5E),
                  b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  height: 42.w,
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: GetBuilder<B22ReviewCoordinatorErib>(
                    id: B22ReviewCoordinatorErib.b22StarBuilderIdWxss,
                    builder: (b22BuilderDpfb) => B22SafeAreaInsetComponentUiga(
                      b22ChildVezd: MasonryGridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 5,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 12.w,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int b22IndexIxdo) {
                          final bool b22SelectedFdvg =
                              b22IndexIxdo < b22BuilderDpfb.b22StarCountGjde;
                          return B22TouchGuardComponentKong(
                            b22OnPressedXvbd: () {
                              b22BuilderDpfb.b22OnStarPressedFxtt(b22IndexIxdo);
                            },
                            b22ChildWksr: B22ResourceImageComponentXjch(
                              b22SelectedFdvg
                                  ? "b22_engagement_media_aquq/b22_feedback_prompts_ptmx/b22_rating_star_active_uynh"
                                  : "b22_engagement_media_aquq/b22_feedback_prompts_ptmx/b22_rating_star_inactive_yjjo",
                              b22WidthKbfi: 42.w,
                              b22HeightUsfn: 42.w,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                B22TouchGuardComponentKong(
                  b22OnPressedXvbd: b22ControllerDwzs.b22OnRateUsPressedQhjc,
                  b22ChildWksr: Container(
                    width: double.infinity,
                    height: 48.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffC40000),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: B22TranslatedLabelComponentJklc(
                      'b22_rate_us_5_stars_vkbp'.tr,
                      b22FontSizeIafw: 16.sp,
                      b22ColorZcbj: Colors.white,
                      b22FontWeightPcyy: FontWeight.bold,
                      b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                    ),
                  ),
                ),
              ],
            ),
          ),
          B22ResourceImageComponentXjch(
            "b22_workspace_media_vwug/b22_home_shell_xfaq/b22_feedback_card_backdrop_npfs",
            b22WidthKbfi: 240.w,
            b22HeightUsfn: 145.h,
          ),
          Positioned(
            top: 84.h,
            right: 12.w,
            child: B22TouchGuardComponentKong(
              b22OnPressedXvbd: () {
                b22ControllerDwzs.b22OnClosePressedPvmt();
              },
              b22ChildWksr: Container(
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                child: B22ResourceImageComponentXjch(
                  "b22_shared_controls_ybsz/b22_navigation_actions_dmkw/b22_navigate_dismiss_qndw",
                  b22HeightUsfn: 24.w,
                  b22WidthKbfi: 24.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
