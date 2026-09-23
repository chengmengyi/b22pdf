import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_supported_languages_jjnw.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_interface_brpn/b22_locale_chooser_coordinator_yrhs.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22LocaleChooserPagePkgi
    extends B22FoundationPageNhfc<B22LocaleChooserCoordinatorAegb> {
  const B22LocaleChooserPagePkgi({super.key});
  @override
  B22LocaleChooserCoordinatorAegb createController() =>
      B22LocaleChooserCoordinatorAegb();

  @override
  Widget buildContent(
    BuildContext context,
    B22LocaleChooserCoordinatorAegb b22ControllerTmpp,
  ) => GetBuilder<B22LocaleChooserCoordinatorAegb>(
    init: b22ControllerTmpp,
    global: false,
    builder: (b22ControllerRpcf) => Column(
      children: [
        b22BuildHeaderUdiz(),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Color(0xffC9C6C0),
          margin: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
        ),
        b22BuildLanguageListCxpe(b22ControllerRpcf),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Color(0xff000000),
        ),
        b22BuildBottomSectionXvuh(b22ControllerRpcf),
        SizedBox(height: 16.h),
        b22BuildNativeAdHyli(),
      ],
    ),
  );

  Widget b22BuildLanguageListCxpe(
    B22LocaleChooserCoordinatorAegb b22ControllerMfuu,
  ) => Expanded(
    child: Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w),
      child: B22SafeAreaInsetComponentUiga(
        b22ChildVezd: ListView.separated(
          controller: b22ControllerMfuu.b22LanguageScrollControllerEasc,
          itemCount: b22ControllerMfuu.languageList.length,
          itemBuilder: (context, b22IndexEvun) {
            final B22SupportedLanguageVhey b22ItemUjaz =
                b22ControllerMfuu.languageList[b22IndexEvun];
            final b22SelectedCzdn = b22ControllerMfuu.b22IsSelectedYjal(
              b22ItemUjaz,
            );
            return B22TouchGuardComponentKong(
              b22OnPressedXvbd: () =>
                  b22ControllerMfuu.b22OnLanguagePressedEjvb(b22ItemUjaz),
              b22ChildWksr: SizedBox(
                height: 64.h,
                child: Row(
                  children: [
                    B22ResourceImageComponentXjch(
                      b22ItemUjaz.b22IconBznb,
                      b22WidthKbfi: 32.w,
                      b22HeightUsfn: 32.w,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: B22TranslatedLabelComponentJklc(
                        b22ItemUjaz.b22NameYzxf,
                        b22FontSizeIafw: 14.sp,
                        b22ColorZcbj: const Color(0xff1A1D22),
                        b22FontTypeQdme: B22FontKindGnzs.extra,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    B22ResourceImageComponentXjch(
                      b22SelectedCzdn
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
          separatorBuilder: (BuildContext context, int index) => Container(
            width: double.infinity,
            height: 2.h,
            color: Color(0xffC9C6C0),
          ),
        ),
      ),
    ),
  );

  Widget b22BuildBottomSectionXvuh(
    B22LocaleChooserCoordinatorAegb b22ControllerLkup,
  ) => B22TouchGuardComponentKong(
    b22OnPressedXvbd: b22ControllerLkup.b22OnOkPressedUnsz,
    b22ChildWksr: Container(
      width: double.infinity,
      height: 48.h,
      alignment: Alignment.center,
      margin: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color(0xffC40000),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: B22TranslatedLabelComponentJklc(
        'b22_ok_tvxa'.tr,
        b22FontSizeIafw: 16.sp,
        b22ColorZcbj: Colors.white,
        b22FontWeightPcyy: FontWeight.bold,
        b22FontTypeQdme: B22FontKindGnzs.extra,
      ),
    ),
  );

  Widget b22BuildHeaderUdiz() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        color: Color(0xffFFFAF6),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 54.h,
            alignment: Alignment.center,
            child: B22TranslatedLabelComponentJklc(
              'b22_choose_language_dnqy'.tr,
              b22FontSizeIafw: 16.sp,
              b22ColorZcbj: const Color(0xff1A1D22),
              b22FontWeightPcyy: FontWeight.bold,
              b22FontTypeQdme: B22FontKindGnzs.extra,
            ),
          ),
        ),
      ),
      SizedBox(height: 20.h),
      B22TranslatedLabelComponentJklc(
        'b22_choose_your_preferred_language_to_kdzv'.tr,
        b22FontSizeIafw: 16.sp,
        b22ColorZcbj: const Color(0xff5E5E5E),
        b22FontWeightPcyy: FontWeight.w500,
      ),
    ],
  );

  Widget b22BuildNativeAdHyli() => const B22SelectLanguageNativePromotionHbhw();
}

class B22SelectLanguageNativePromotionHbhw extends StatefulWidget {
  const B22SelectLanguageNativePromotionHbhw();

  @override
  State<B22SelectLanguageNativePromotionHbhw> createState() =>
      B22SelectLanguageNativePromotionStateDvmt();
}

class B22SelectLanguageNativePromotionStateDvmt
    extends State<B22SelectLanguageNativePromotionHbhw> {
  static const Duration b22RetryDurationTinn = Duration(milliseconds: 500);

  Timer? b22RetryTimerTtga;
  Widget? b22AdWidgetElpf;
  bool b22CheckingAdFbmx = false;
  bool b22CanShowAdXrav = false;

  @override
  void initState() {
    super.initState();
    unawaited(b22InitializeNativeAdKdsi());
  }

  Future<void> b22InitializeNativeAdKdsi() async {
    final B22PromotionOrchestratorAzwq b22AdServiceBkej =
        B22PromotionOrchestratorAzwq.instance;
    final bool b22CanShowAdZxvd = await b22AdServiceBkej
        .b22IsPlacementEnabledWiqd(B22PromotionSlotZwla.pr_new_lan_nat);
    if (!mounted || !b22CanShowAdZxvd) return;
    setState(() => b22CanShowAdXrav = true);
    b22AdServiceBkej.b22TrackAdOpportunityFbhf(
      b22AdSceneGiep: B22PromotionContextSuaj.pr_ban1,
      b22AdPosIdEbwa: B22PromotionSlotZwla.pr_new_lan_nat,
    );
    unawaited(b22AttachNativeAdWidgetHeug());
    b22RetryTimerTtga = Timer.periodic(
      b22RetryDurationTinn,
      (_) => unawaited(b22AttachNativeAdWidgetHeug()),
    );
  }

  Future<void> b22AttachNativeAdWidgetHeug() async {
    if (b22AdWidgetElpf != null || b22CheckingAdFbmx) {
      return;
    }
    b22CheckingAdFbmx = true;
    try {
      final Widget? b22AdWidgetXgyh = await B22PromotionOrchestratorAzwq
          .instance
          .b22BuildCachedNativeAdJqgz(
            b22AdSceneTbyk: B22PromotionContextSuaj.pr_ban1,
            b22AdPosIdXckb: B22PromotionSlotZwla.pr_new_lan_nat,
          );
      if (!mounted || b22AdWidgetXgyh == null) {
        return;
      }
      b22RetryTimerTtga?.cancel();
      b22RetryTimerTtga = null;
      setState(() {
        b22AdWidgetElpf = b22AdWidgetXgyh;
      });
      unawaited(
        B22PromotionOrchestratorAzwq.instance.b22LoadDocumentListNativeAdAfwu(),
      );
    } finally {
      b22CheckingAdFbmx = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!b22CanShowAdXrav) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      height: 58.h,
      child: b22AdWidgetElpf ?? const SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    b22RetryTimerTtga?.cancel();
    b22RetryTimerTtga = null;
    super.dispose();
  }
}
