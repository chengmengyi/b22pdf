import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_interface_hgve/b22_guide_coordinator_wqaz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22GuidePageVqme extends B22FoundationPageNhfc<B22GuideCoordinatorFvke> {
  const B22GuidePageVqme({super.key});

  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get navigationBarColor => Colors.white;

  @override
  B22GuideCoordinatorFvke createController() => B22GuideCoordinatorFvke();

  @override
  Widget buildContent(
    BuildContext context,
    B22GuideCoordinatorFvke b22ControllerTqva,
  ) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 70.h),
          Expanded(
            child: GetBuilder<B22GuideCoordinatorFvke>(
              init: b22ControllerTqva,
              global: false,
              id: B22GuideCoordinatorFvke.b22NativeAdEligibilityUpdateIdOqev,
              builder: (B22GuideCoordinatorFvke b22ControllerQmva) => PageView(
                controller: b22ControllerQmva.b22PageControllerQnva,
                onPageChanged: (int b22PageIndexUyme) => b22ControllerQmva
                    .b22OnPageChangedFzro(b22PageIndexUyme, context),
                children: <Widget>[
                  b22BuildFirstGuideRqva(
                    b22ControllerQmva.b22CanShowNativeAdJqwo,
                  ),
                  b22BuildSecondGuideKzme(
                    b22ControllerQmva.b22CanShowNativeAdJqwo,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          B22GuidePageIndicatorCvra(
            b22ControllerOqme: b22ControllerTqva.b22PageControllerQnva,
          ),
          SizedBox(height: 20.h),
          b22BuildBottomButtonYqle(b22ControllerTqva, context),
        ],
      ),
    );
  }

  Widget b22BuildFirstGuideRqva(bool b22CanShowNativeAdKtva) => Column(
    children: <Widget>[
      B22TranslatedLabelComponentJklc(
        'b22_guide_scan_title_kmve',
        b22TranslateLncu: true,
        b22FontSizeIafw: 24.sp,
        b22ColorZcbj: const Color(0xff000000),
        b22FontWeightPcyy: FontWeight.bold,
        b22FontTypeQdme: B22FontKindGnzs.black,
      ),
      SizedBox(height: 10.h),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        child: B22TranslatedLabelComponentJklc(
          'b22_guide_scan_description_nqra',
          b22TranslateLncu: true,
          b22FontSizeIafw: 12.sp,
          b22ColorZcbj: const Color(0xff5E5E5E),
          b22FontWeightPcyy: FontWeight.w500,
          b22TextAlignCzod: TextAlign.center,
          b22FontTypeQdme: B22FontKindGnzs.semi,
        ),
      ),
      SizedBox(height: 10.h),
      B22ResourceImageComponentXjch(
        'b22_onboarding_media_qrve/b22_guide_surfaces_lkpa/b22_scan_anything_guide_kmve',
        b22WidthKbfi: double.infinity,
        b22HeightUsfn: 320.h,
      ),
      SizedBox(height: 10.h),
      if (b22CanShowNativeAdKtva)
        const B22GuideNativePromotionPqva(
          key: ValueKey<String>('b22_guide_native_ad_1'),
          b22AdSceneLqme: B22PromotionContextSuaj.pr_ban1,
          b22AdPosIdRqva: B22PromotionSlotZwla.pr_guide1,
        ),
    ],
  );

  Widget b22BuildSecondGuideKzme(bool b22CanShowNativeAdKtva) => Column(
    children: <Widget>[
      // B22ResourceImageComponentXjch(
      //   'b22_onboarding_media_qrve/b22_guide_surfaces_lkpa/b22_edit_sign_guide_rqaz',
      //   b22WidthKbfi: 272.w,
      //   b22HeightUsfn: 272.w,
      // ),
      // SizedBox(height: 20.h),
      // B22TranslatedLabelComponentJklc(
      //   'b22_guide_edit_sign_title_rqaz',
      //   b22TranslateLncu: true,
      //   b22FontSizeIafw: 18.sp,
      //   b22ColorZcbj: const Color(0xff242C3C),
      //   b22FontWeightPcyy: FontWeight.bold,
      // ),
      // SizedBox(height: 20.h),
      // Container(
      //   margin: EdgeInsets.symmetric(horizontal: 32.w),
      //   child: B22TranslatedLabelComponentJklc(
      //     'b22_guide_edit_sign_description_vqme',
      //     b22TranslateLncu: true,
      //     b22FontSizeIafw: 14.sp,
      //     b22ColorZcbj: const Color(0xff555978),
      //     b22FontWeightPcyy: FontWeight.w500,
      //     b22TextAlignCzod: TextAlign.center,
      //   ),
      // ),
      // SizedBox(height: 20.h),
      B22TranslatedLabelComponentJklc(
        'b22_guide_edit_sign_title_rqaz',
        b22TranslateLncu: true,
        b22FontSizeIafw: 24.sp,
        b22ColorZcbj: const Color(0xff000000),
        b22FontWeightPcyy: FontWeight.bold,
        b22FontTypeQdme: B22FontKindGnzs.black,
      ),
      SizedBox(height: 10.h),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        child: B22TranslatedLabelComponentJklc(
          'b22_guide_edit_sign_description_vqme',
          b22TranslateLncu: true,
          b22FontSizeIafw: 12.sp,
          b22ColorZcbj: const Color(0xff5E5E5E),
          b22FontWeightPcyy: FontWeight.w500,
          b22TextAlignCzod: TextAlign.center,
          b22FontTypeQdme: B22FontKindGnzs.semi,
        ),
      ),
      SizedBox(height: 10.h),
      B22ResourceImageComponentXjch(
        'b22_onboarding_media_qrve/b22_guide_surfaces_lkpa/b22_edit_sign_guide_rqaz',
        b22WidthKbfi: double.infinity,
        b22HeightUsfn: 320.h,
      ),
      SizedBox(height: 10.h),
      if (b22CanShowNativeAdKtva)
        const B22GuideNativePromotionPqva(
          key: ValueKey<String>('b22_guide_native_ad_2'),
          b22AdSceneLqme: B22PromotionContextSuaj.pr_ban2,
          b22AdPosIdRqva: B22PromotionSlotZwla.pr_guide2,
        ),
    ],
  );

  Widget b22BuildBottomButtonYqle(
    B22GuideCoordinatorFvke b22ControllerQmva,
    BuildContext b22ContextTqva,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: 2.h,
          color: Color(0xff000000),
        ),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: () =>
              b22ControllerQmva.b22OnBottomPressedEkra(b22ContextTqva),
          b22BorderRadiusIzak: BorderRadius.circular(26.w),
          b22ChildWksr: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 15.h,bottom: 15.h),
            decoration: BoxDecoration(
              color: const Color(0xffC40000),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: B22TranslatedLabelComponentJklc(
              'b22_guide_next_yqle',
              b22TranslateLncu: true,
              b22FontSizeIafw: 18.sp,
              b22ColorZcbj: Colors.white,
              b22FontWeightPcyy: FontWeight.bold,
              b22FontTypeQdme: B22FontKindGnzs.black,
            ),
          ),
        ),
      ],
    );
  }
}

class B22GuidePageIndicatorCvra extends StatelessWidget {
  const B22GuidePageIndicatorCvra({super.key, required this.b22ControllerOqme});

  final PageController b22ControllerOqme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: b22ControllerOqme,
      builder: (BuildContext context, Widget? child) {
        final double b22PagePqva = b22ControllerOqme.hasClients
            ? b22ControllerOqme.page ?? 0
            : 0;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(2, (int b22IndexUvra) {
            final double b22ActivityFqme =
                (1 - (b22PagePqva - b22IndexUvra).abs()).clamp(0.0, 1.0);
            return Container(
              width: 8.w + 8.w * b22ActivityFqme,
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: Color.lerp(
                  const Color(0xffC9C6C0),
                  const Color(0xff970000),
                  b22ActivityFqme,
                ),
                borderRadius: BorderRadius.circular(4.w),
              ),
            );
          }),
        );
      },
    );
  }
}

class B22GuideNativePromotionPqva extends StatefulWidget {
  const B22GuideNativePromotionPqva({
    super.key,
    required this.b22AdSceneLqme,
    required this.b22AdPosIdRqva,
  });

  final B22PromotionContextSuaj b22AdSceneLqme;
  final B22PromotionSlotZwla b22AdPosIdRqva;

  @override
  State<B22GuideNativePromotionPqva> createState() =>
      B22GuideNativePromotionStateXkve();
}

class B22GuideNativePromotionStateXkve
    extends State<B22GuideNativePromotionPqva>
    with AutomaticKeepAliveClientMixin<B22GuideNativePromotionPqva> {
  static const Duration b22RetryDurationNqwa = Duration(milliseconds: 500);

  Timer? b22RetryTimerJpve;
  Widget? b22AdWidgetRqma;
  bool b22CheckingAdKqve = false;
  bool b22CanShowAdXqra = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    unawaited(b22InitializeNativeAdTqva());
  }

  Future<void> b22InitializeNativeAdTqva() async {
    final B22PromotionOrchestratorAzwq b22AdServiceKqve =
        B22PromotionOrchestratorAzwq.instance;
    final bool b22CanShowAdPqra = await b22AdServiceKqve
        .b22IsPlacementEnabledWiqd(widget.b22AdPosIdRqva);
    if (!mounted || !b22CanShowAdPqra) return;
    setState(() => b22CanShowAdXqra = true);
    b22AdServiceKqve.b22TrackAdOpportunityFbhf(
      b22AdSceneGiep: widget.b22AdSceneLqme,
      b22AdPosIdEbwa: widget.b22AdPosIdRqva,
    );
    unawaited(b22TryBuildAdWidgetVqme());
    b22RetryTimerJpve = Timer.periodic(
      b22RetryDurationNqwa,
      (_) => unawaited(b22TryBuildAdWidgetVqme()),
    );
  }

  Future<void> b22TryBuildAdWidgetVqme() async {
    if (b22AdWidgetRqma != null || b22CheckingAdKqve) return;
    b22CheckingAdKqve = true;
    try {
      final Widget? b22AdWidgetOqva = await B22PromotionOrchestratorAzwq
          .instance
          .b22BuildCachedNativeAdJqgz(
            b22AdSceneTbyk: widget.b22AdSceneLqme,
            b22AdPosIdXckb: widget.b22AdPosIdRqva,
          );
      if (!mounted || b22AdWidgetOqva == null) return;
      b22RetryTimerJpve?.cancel();
      b22RetryTimerJpve = null;
      setState(() => b22AdWidgetRqma = b22AdWidgetOqva);
      unawaited(b22LoadNextAdFqra());
    } finally {
      b22CheckingAdKqve = false;
    }
  }

  Future<void> b22LoadNextAdFqra() async {
    try {
      await B22PromotionOrchestratorAzwq.instance.b22PreloadSceneQjfv(
        widget.b22AdSceneLqme,
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!b22CanShowAdXqra) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      height: 58.h,
      child:
          b22AdWidgetRqma ??
          const B22ResourceImageComponentXjch(
            'b22_monetization_media_pgct/b22_native_ad_surfaces_fxri/b22_native_ad_fallback_fyvg',
            b22WidthKbfi: double.infinity,
          ),
    );
  }

  @override
  void dispose() {
    b22RetryTimerJpve?.cancel();
    b22RetryTimerJpve = null;
    super.dispose();
  }
}
