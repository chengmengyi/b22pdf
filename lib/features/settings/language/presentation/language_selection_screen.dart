import 'dart:async';

import 'package:b21pdf/core/ads/ad_service.dart';
import 'package:b21pdf/core/ads/ad_scene.dart';
import 'package:b21pdf/core/ads/ad_placement.dart';
import 'package:b21pdf/features/settings/language/supported_locales.dart';
import 'package:b21pdf/features/settings/language/presentation/language_selection_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/media_padding_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguageSelectionScreen extends BaseScreen<LanguageSelectionController> {
  const LanguageSelectionScreen({super.key});
  @override
  LanguageSelectionController createController() =>
      LanguageSelectionController();

  @override
  Widget buildContent(
    BuildContext context,
    LanguageSelectionController controller,
  ) => GetBuilder<LanguageSelectionController>(
    init: controller,
    global: false,
    builder: (controller) => Column(
      children: [
        _buildHeader(),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Color(0xffC9C6C0),
          margin: EdgeInsets.only(top: 12.h,left: 12.w,right: 12.w),
        ),
        _buildLanguageList(controller),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Color(0xff000000),
        ),
        _buildBottomSection(controller),
        SizedBox(height: 16.h),
        _buildNativeAd(),
      ],
    ),
  );

  Widget _buildLanguageList(LanguageSelectionController controller) => Expanded(
    child: Container(
      margin: EdgeInsets.only(left: 12.w,right: 12.w),
      child: MediaPaddingView(
        child: ListView.separated(
          controller: controller.languageScrollController,
          itemCount: controller.languageList.length,
          itemBuilder: (context, index) {
            final SupportedLocale item = controller.languageList[index];
            final selected = controller.isSelected(item);
            return TapGuardView(
              onPressed: () => controller.onLanguagePressed(item),
              child: SizedBox(
                height: 64.h,
                child: Row(
                  children: [
                    AssetPictureView(item.icon, width: 32.w, height: 32.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: LocalizedTextView(
                        item.name,
                        fontSize: 14.sp,
                        color: const Color(0xff1A1D22),
                        fontType: FontType.extra,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    AssetPictureView(
                      selected
                          ? 'common/radio_selected'
                          : 'common/radio_unselected',
                      width: 28.w,
                      height: 28.w,
                    ),
                  ],
                ),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) =>
            Container(
              width: double.infinity,
              height: 2.h,
              color: Color(0xffC9C6C0),
            ),
        ),
      ),
    ),
  );

  Widget _buildBottomSection(LanguageSelectionController controller) =>
      TapGuardView(
        onPressed: controller.onOkPressed,
        child: Container(
          width: double.infinity,
          height: 48.h,
          alignment: Alignment.center,
          margin: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Color(0xffC40000),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: LocalizedTextView(
            'OK'.tr,
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontType: FontType.extra,
          ),
        ),
      );

  Widget _buildHeader() => Column(
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
            child: LocalizedTextView(
              'Choose Language'.tr,
              fontSize: 16.sp,
              color: const Color(0xff1A1D22),
              fontWeight: FontWeight.bold,
              fontType: FontType.extra,
            ),
          ),
        ),
      ),
      SizedBox(height: 20.h,),
      LocalizedTextView(
        'Choose your preferred language to get started.'.tr,
        fontSize: 16.sp,
        color: const Color(0xff5E5E5E),
        fontWeight: FontWeight.w500,
      ),
    ],
  );

  Widget _buildNativeAd() => const _SelectLocaleNativeAd();
}

class _SelectLocaleNativeAd extends StatefulWidget {
  const _SelectLocaleNativeAd();

  @override
  State<_SelectLocaleNativeAd> createState() => _SelectLocaleNativeAdState();
}

class _SelectLocaleNativeAdState extends State<_SelectLocaleNativeAd> {
  static const Duration _retryDuration = Duration(milliseconds: 500);

  Timer? _retryTimer;
  Widget? _adWidget;
  bool _checkingAd = false;
  bool _canShowAd = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initializeNativeAd());
  }

  Future<void> _initializeNativeAd() async {
    final AdService adService = AdService.instance;
    final bool canShowAd = await adService.isPlacementEnabled(
      AdPlacement.pr_new_lan_nat,
    );
    if (!mounted || !canShowAd) return;
    setState(() => _canShowAd = true);
    adService.trackAdOpportunity(
      adScene: AdScene.pr_ban1,
      adPosId: AdPlacement.pr_new_lan_nat,
    );
    unawaited(_attachNativeAdWidget());
    _retryTimer = Timer.periodic(
      _retryDuration,
      (_) => unawaited(_attachNativeAdWidget()),
    );
  }

  Future<void> _attachNativeAdWidget() async {
    if (_adWidget != null || _checkingAd) {
      return;
    }
    _checkingAd = true;
    try {
      final Widget? adWidget = await AdService.instance.buildCachedNativeAd(
        adScene: AdScene.pr_ban1,
        adPosId: AdPlacement.pr_new_lan_nat,
      );
      if (!mounted || adWidget == null) {
        return;
      }
      _retryTimer?.cancel();
      _retryTimer = null;
      setState(() {
        _adWidget = adWidget;
      });
      unawaited(AdService.instance.loadDocumentListNativeAd());
    } finally {
      _checkingAd = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_canShowAd) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      height: 58.h,
      child: _adWidget ?? const SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    _retryTimer = null;
    super.dispose();
  }
}
