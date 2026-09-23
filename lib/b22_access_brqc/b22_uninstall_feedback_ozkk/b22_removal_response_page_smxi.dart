import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_uninstall_feedback_ozkk/b22_removal_response_coordinator_vatj.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22RemovalResponsePageDhiz
    extends B22FoundationPageNhfc<B22RemovalResponseCoordinatorMxgc> {
  const B22RemovalResponsePageDhiz({super.key});

  @override
  B22RemovalResponseCoordinatorMxgc createController() {
    return B22RemovalResponseCoordinatorMxgc();
  }

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  Widget buildContent(
    BuildContext context,
    B22RemovalResponseCoordinatorMxgc b22ControllerYmoa,
  ) {
    return Column(
      children: [
        b22BuildTitleSectionYgwx(b22ControllerYmoa),
        SizedBox(height: 8.h),
        b22BuildContentSectionEfmj(b22ControllerYmoa),
        SizedBox(height: 8.h),
        b22BuildNativeAdMyto(),
        SizedBox(height: 8.h),
        b22BuildBottomSectionMjyf(b22ControllerYmoa),
      ],
    );
  }

  Widget b22BuildNativeAdMyto() {
    if (!B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 14.h),
      child: const B22RemovalNativePromotionSpva(),
    );
  }

  Widget b22BuildContentSectionEfmj(
    B22RemovalResponseCoordinatorMxgc b22ControllerWbua,
  ) => Expanded(
    child: Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<B22RemovalResponseCoordinatorMxgc>(
              id: B22RemovalResponseCoordinatorMxgc.b22ReasonBuilderIdUsrx,
              builder: (b22BuilderBshb) => B22SafeAreaInsetComponentUiga(
                b22ChildVezd: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: b22BuilderBshb.b22ReasonListTjby.length,
                  itemBuilder: (context, b22IndexNxjg) {
                    final bool b22SelectedWfxd =
                        b22BuilderBshb.b22SelectedReasonIndexOano ==
                        b22IndexNxjg;
                    return B22TouchGuardComponentKong(
                      b22OnPressedXvbd: () {
                        b22BuilderBshb.b22OnReasonPressedEqzz(b22IndexNxjg);
                      },
                      b22ChildWksr: Container(
                        width: double.infinity,
                        height: 60.h,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Expanded(
                              child: B22TranslatedLabelComponentJklc(
                                b22BuilderBshb
                                    .b22ReasonListTjby[b22IndexNxjg]
                                    .tr,
                                b22FontSizeIafw: 14.sp,
                                b22ColorZcbj: Colors.black,
                                b22FontWeightPcyy: FontWeight.w500,
                                b22OverflowUwxb: TextOverflow.ellipsis,
                                b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            B22ResourceImageComponentXjch(
                              b22SelectedWfxd
                                  ? "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_active_rpff"
                                  : "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_inactive_yslq",
                              b22WidthKbfi: 28.w,
                              b22HeightUsfn: 28.w,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        width: double.infinity,
                        height: 2.h,
                        color: Color(0xffC9C6C0),
                      ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 120.h,
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: TextField(
                textAlign: TextAlign.start,
                enabled: true,
                controller: b22ControllerWbua.b22TextEditingControllerFqls,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF1A1D22),
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  isCollapsed: true,
                  hintText: 'b22_please_enter_the_reason_for_molp'.tr,
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFFB2B2B2),
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget b22BuildBottomSectionMjyf(
    B22RemovalResponseCoordinatorMxgc b22ControllerXkwr,
  ) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: Color(0xffFFFAF6),
      border: BoxBorder.fromLTRB(
        top: BorderSide(width: 2.w, color: Colors.black),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerXkwr.b22OnNoUninstallPressedEqqh,
          b22ChildWksr: Container(
            width: double.infinity,
            height: 46.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffC40000),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: B22TranslatedLabelComponentJklc(
              'b22_don_t_uninstall_for_now_bpcd'.tr,
              b22FontSizeIafw: 16.sp,
              b22ColorZcbj: Colors.white,
              b22FontWeightPcyy: FontWeight.bold,
              b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
            ),
          ),
        ),
        SizedBox(height: 14.h),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: () {
            b22ControllerXkwr.b22OnUninstallPressedYgmr();
          },
          b22ChildWksr: B22TranslatedLabelComponentJklc(
            'b22_uninstall_waqq'.tr,
            b22FontSizeIafw: 14.sp,
            b22ColorZcbj: Colors.black,
            b22FontWeightPcyy: FontWeight.bold,
            b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
          ),
        ),
      ],
    ),
  );

  Widget b22BuildTitleSectionYgwx(
    B22RemovalResponseCoordinatorMxgc b22ControllerGtxc,
  ) => Container(
    width: double.infinity,
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        height: 44.h,
        child: Stack(
          children: [
            B22TouchGuardComponentKong(
              b22OnPressedXvbd: b22ControllerGtxc.b22OnNoUninstallPressedEqqh,
              b22ChildWksr: Container(
                width: 44.w,
                height: 44.h,
                alignment: Alignment.center,
                child: B22ResourceImageComponentXjch(
                  "b22_shared_controls_ybsz/b22_navigation_actions_dmkw/b22_navigate_back_fylg",
                  b22WidthKbfi: 28.w,
                  b22HeightUsfn: 28.w,
                ),
              ),
            ),
            Align(
              child: Container(
                margin: EdgeInsets.only(left: 44.w, right: 44.w),
                child: B22TranslatedLabelComponentJklc(
                  'b22_uninstall_reason_mrhl'.tr,
                  b22FontSizeIafw: 16.sp,
                  b22ColorZcbj: Colors.black,
                  b22FontWeightPcyy: FontWeight.w500,
                  b22FontTypeQdme: B22FontKindGnzs.b22ExtraFyuc,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class B22RemovalNativePromotionSpva extends StatefulWidget {
  const B22RemovalNativePromotionSpva();

  @override
  State<B22RemovalNativePromotionSpva> createState() =>
      B22RemovalNativePromotionStateYndr();
}

class B22RemovalNativePromotionStateYndr
    extends State<B22RemovalNativePromotionSpva> {
  static const Duration b22RetryDurationSxix = Duration(milliseconds: 500);

  Timer? b22RetryTimerWvjl;
  Widget? b22AdWidgetNlkg;
  bool b22CheckingAdMxdv = false;
  bool b22CanShowAdOicd = false;

  @override
  void initState() {
    super.initState();
    unawaited(b22InitializeNativeAdBhlc());
  }

  Future<void> b22InitializeNativeAdBhlc() async {
    final B22PromotionOrchestratorAzwq b22AdServiceEvhf =
        B22PromotionOrchestratorAzwq.instance;
    final bool b22CanShowAdEoly = await b22AdServiceEvhf
        .b22IsPlacementEnabledWiqd(B22PromotionSlotZwla.unload_nat1);
    if (!mounted || !b22CanShowAdEoly) return;
    setState(() => b22CanShowAdOicd = true);
    b22AdServiceEvhf.b22TrackAdOpportunityFbhf(
      b22AdSceneGiep: B22PromotionContextSuaj.pr_ban2,
      b22AdPosIdEbwa: B22PromotionSlotZwla.unload_nat1,
    );
    unawaited(b22AttachNativeAdWidgetXlon());
    b22RetryTimerWvjl = Timer.periodic(
      b22RetryDurationSxix,
      (_) => unawaited(b22AttachNativeAdWidgetXlon()),
    );
  }

  Future<void> b22AttachNativeAdWidgetXlon() async {
    if (b22AdWidgetNlkg != null || b22CheckingAdMxdv) {
      return;
    }
    b22CheckingAdMxdv = true;
    try {
      final Widget? b22AdWidgetXaja = await B22PromotionOrchestratorAzwq
          .instance
          .b22BuildCachedNativeAdJqgz(
            b22AdSceneTbyk: B22PromotionContextSuaj.pr_ban2,
            b22AdPosIdXckb: B22PromotionSlotZwla.unload_nat1,
          );
      if (!mounted || b22AdWidgetXaja == null) {
        return;
      }
      b22RetryTimerWvjl?.cancel();
      b22RetryTimerWvjl = null;
      setState(() => b22AdWidgetNlkg = b22AdWidgetXaja);
    } finally {
      b22CheckingAdMxdv = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!b22CanShowAdOicd) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child:
          b22AdWidgetNlkg ??
          const B22ResourceImageComponentXjch(
            'b22_monetization_media_pgct/b22_native_ad_surfaces_fxri/b22_native_ad_fallback_fyvg',
            b22WidthKbfi: double.infinity,
          ),
    );
  }

  @override
  void dispose() {
    b22RetryTimerWvjl?.cancel();
    b22RetryTimerWvjl = null;
    super.dispose();
  }
}
