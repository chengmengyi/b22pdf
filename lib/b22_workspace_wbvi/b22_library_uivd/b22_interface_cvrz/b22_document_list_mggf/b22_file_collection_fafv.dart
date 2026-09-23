import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_document_list_mggf/b22_file_collection_coordinator_ghqd.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_library_tab_kczk/b22_archive_section_coordinator_xkbp.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_section_lobe.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_reload_component_sltd.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class B22FileCollectionOwkl extends B22FoundationSectionMnzc {
  final B22FileCategoryVdhm b22TypeQpit;
  const B22FileCollectionOwkl({super.key, required this.b22TypeQpit});

  @override
  State<B22FileCollectionOwkl> createState() =>
      B22DocumentsCollectionSectionStateCzwj();
}

class B22DocumentsCollectionSectionStateCzwj
    extends
        B22FoundationSectionStateNpno<
          B22FileCollectionCoordinatorFigm,
          B22FileCollectionOwkl
        > {
  @override
  String get controllerTag => 'files_${widget.b22TypeQpit.name}';

  @override
  B22FileCollectionCoordinatorFigm createController() {
    return B22FileCollectionCoordinatorFigm(b22TypeTtjd: widget.b22TypeQpit);
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22FileCollectionCoordinatorFigm b22ControllerKdaz,
  ) {
    return GetBuilder<B22FileCollectionCoordinatorFigm>(
      init: b22ControllerKdaz,
      global: false,
      builder: (b22ControllerJoso) {
        return Container(
          margin: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Column(
            children: [
              b22BuildSortControlsDxex(b22ControllerJoso),
              b22BuildContentSectionGtkt(b22ControllerJoso),
            ],
          ),
        );
      },
    );
  }

  Widget b22BuildSortControlsDxex(
    B22FileCollectionCoordinatorFigm b22ControllerIiiv,
  ) => Container(
    width: double.infinity,
    height: 44.h,
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Expanded(
          child: B22TouchGuardComponentKong(
            b22OnPressedXvbd: () {
              b22ControllerIiiv.b22RunDebugActionsDopn();
            },
            b22ChildWksr: B22TranslatedLabelComponentJklc(
              'b22_local_storage_ciab'.tr,
              b22FontSizeIafw: 16.sp,
              b22ColorZcbj: Color(0xff333333),
              b22FontWeightPcyy: FontWeight.bold,
              b22OverflowUwxb: TextOverflow.ellipsis,
              b22FontTypeQdme: B22FontKindGnzs.extra,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: () {
            b22ControllerIiiv.b22OnSortPressedTzpo();
          },
          b22ChildWksr: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              B22ResourceImageComponentXjch(
                "b22_workspace_media_vwug/b22_library_actions_pxds/b22_sort_menu_action_rcpn",
                b22WidthKbfi: 24.w,
                b22HeightUsfn: 24.w,
              ),
              SizedBox(width: 2.w),
              B22TranslatedLabelComponentJklc(
                'b22_sort_hqcl'.tr,
                b22FontSizeIafw: 10.sp,
                b22ColorZcbj: Color(0xff334155),
                b22FontWeightPcyy: FontWeight.w500,
                b22FontTypeQdme: B22FontKindGnzs.semi,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: () {
            b22ControllerIiiv.b22OnDeleteFilePressedSwig();
          },
          b22ChildWksr: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              B22ResourceImageComponentXjch(
                "b22_workspace_media_vwug/b22_library_actions_pxds/b22_multi_select_action_ekgi",
                b22WidthKbfi: 24.w,
                b22HeightUsfn: 24.w,
              ),
              SizedBox(width: 2.w),
              B22TranslatedLabelComponentJklc(
                'b22_select_evcg'.tr,
                b22FontSizeIafw: 10.sp,
                b22ColorZcbj: Color(0xff334155),
                b22FontWeightPcyy: FontWeight.w500,
                b22FontTypeQdme: B22FontKindGnzs.semi,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget b22BuildContentSectionGtkt(
    B22FileCollectionCoordinatorFigm b22ControllerPocx,
  ) => Expanded(
    child: switch (b22ControllerPocx.b22ListStateTnnh) {
      B22FileCollectionStatePblk.noPermission =>
        b22BuildDemoDocumentEmptyStateUcbb(
          b22ControllerVwrg: b22ControllerPocx,
          b22EmptyWidgetMyxl: b22BuildPermissionRequiredStateIvdt(
            b22ControllerPocx,
          ),
        ),
      B22FileCollectionStatePblk.loading => b22BuildLoadingStateJrla(),
      B22FileCollectionStatePblk.loaded =>
        b22ControllerPocx.b22VisibleFilesIdkf.isEmpty
            ? b22BuildDemoDocumentEmptyStateUcbb(
                b22ControllerVwrg: b22ControllerPocx,
                b22EmptyWidgetMyxl: b22BuildNoFilesStateXncl(b22ControllerPocx),
              )
            : b22BuildDocumentListViewportMbes(b22ControllerPocx),
    },
  );

  Widget b22BuildDocumentListViewportMbes(
    B22FileCollectionCoordinatorFigm b22ControllerEblj,
  ) => B22SafeAreaInsetComponentUiga(
    b22ChildVezd: B22ReloadComponentVukm(
      b22EnableLoadMoreQayd: false,
      b22ControllerGfdx: b22ControllerEblj.b22RefreshControllerOxrn,
      b22ScrollControllerTurd: b22ControllerEblj.b22ScrollControllerCiup,
      b22OnRefreshIfjy: b22ControllerEblj.b22RefreshFilesWnkt,
      b22ChildIykv: b22BuildFileListRrsv(b22ControllerEblj),
    ),
  );

  Widget b22BuildFileListRrsv(
    B22FileCollectionCoordinatorFigm b22ControllerHcmk,
  ) {
    final bool b22CanShowNativeAdKchs = b22ControllerHcmk.canShowNativeAd;
    final int b22NativeAdCountYgvv = b22CanShowNativeAdKchs
        ? b22ControllerHcmk.b22VisibleFilesIdkf.length ~/
              B22FileCollectionCoordinatorFigm.b22NativeAdIntervalBxfl
        : 0;
    final int b22ItemCountCorl =
        b22ControllerHcmk.b22VisibleFilesIdkf.length + b22NativeAdCountYgvv;
    b22ControllerHcmk.b22SyncNativeAdListStateVevu(b22ItemCountCorl);
    final int b22GroupCountVjht =
        (b22ControllerHcmk.b22VisibleFilesIdkf.length +
            B22FileCollectionCoordinatorFigm.b22NativeAdIntervalBxfl -
            1) ~/
        B22FileCollectionCoordinatorFigm.b22NativeAdIntervalBxfl;
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: b22GroupCountVjht,
          itemBuilder: (BuildContext context, int b22GroupIndexZfwh) {
            return b22BuildFileGroupLyzf(
              b22ControllerRags: b22ControllerHcmk,
              b22GroupIndexCaim: b22GroupIndexZfwh,
              b22CanShowNativeAdUvhk: b22CanShowNativeAdKchs,
            );
          },
        ),
      ],
    );
  }

  Widget b22BuildFileGroupLyzf({
    required B22FileCollectionCoordinatorFigm b22ControllerRags,
    required int b22GroupIndexCaim,
    required bool b22CanShowNativeAdUvhk,
  }) {
    final int b22IntervalYjns =
        B22FileCollectionCoordinatorFigm.b22NativeAdIntervalBxfl;
    final int b22StartIndexQebx = b22GroupIndexCaim * b22IntervalYjns;
    final int b22RemainingFilesBpeg =
        b22ControllerRags.b22VisibleFilesIdkf.length - b22StartIndexQebx;
    final int b22FileCountEpvm = b22RemainingFilesBpeg < b22IntervalYjns
        ? b22RemainingFilesBpeg
        : b22IntervalYjns;
    final bool b22ShowAdAfterGroupVtyk =
        b22CanShowNativeAdUvhk && b22FileCountEpvm == b22IntervalYjns;
    final int b22NativeAdListIndexIojl =
        (b22GroupIndexCaim + 1) * (b22IntervalYjns + 1) - 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          children: List<Widget>.generate(b22FileCountEpvm, (
            int b22OffsetIosb,
          ) {
            final b22FileZouv = b22ControllerRags
                .b22VisibleFilesIdkf[b22StartIndexQebx + b22OffsetIosb];
            return StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: b22BuildFileItemFptf(b22ControllerRags, b22FileZouv),
            );
          }),
        ),
        if (b22ShowAdAfterGroupVtyk)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: b22BuildNativeAdSlotTugn(
              b22ControllerEldy: b22ControllerRags,
              b22ListIndexHnfn: b22NativeAdListIndexIojl,
              b22ShowNativeAdMlsa:
                  b22ControllerRags.b22ActiveNativeAdIndexHjac ==
                  b22NativeAdListIndexIojl,
            ),
          ),
      ],
    );
  }

  Widget b22BuildNativeAdSlotTugn({
    required B22FileCollectionCoordinatorFigm b22ControllerEldy,
    required int b22ListIndexHnfn,
    required bool b22ShowNativeAdMlsa,
  }) {
    b22ControllerEldy.b22PrepareNativeAdSlotPepb(b22ListIndexHnfn);
    return VisibilityDetector(
      key: ValueKey('document_inline_ad_${b22ListIndexHnfn}_vke'),
      onVisibilityChanged: (b22InfoGyxk) =>
          b22ControllerEldy.b22UpdateNativeAdVisibilityFlyp(
            b22ListIndexHnfn,
            b22InfoGyxk.visibleFraction > 0,
          ),
      child: SizedBox(
        width: double.infinity,
        height: 68.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: b22ShowNativeAdMlsa
              ? KeyedSubtree(
                  key: ValueKey(
                    'document_native_ad_${b22ListIndexHnfn}_${b22ControllerEldy.b22NativeAdRefreshKeyBrtb}_vke',
                  ),
                  child: const B22DocumentsNativePromotionPanelWhnn(),
                )
              : const B22ResourceImageComponentXjch(
                  'b22_monetization_media_pgct/b22_native_ad_surfaces_fxri/b22_native_ad_fallback_fyvg',
                  b22WidthKbfi: double.infinity,
                ),
        ),
      ),
    );
  }

  String b22FileIconOigb(
    FileToolsFileInfo b22FileFpwd,
  ) => switch (b22FileFpwd.type) {
    FileToolsDocumentType.pdf =>
      'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_pdf_badge_qmqd',
    FileToolsDocumentType.excel =>
      'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_spreadsheet_badge_zzbg',
    _ =>
      'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_document_badge_frgw',
  };

  String b22FormatFileMetadataDxxd(FileToolsFileInfo b22FileJjsw) {
    final b22DateKann = DateTime.fromMillisecondsSinceEpoch(
      b22FileJjsw.updateTime ?? 0,
    );
    final b22DateTextDmza =
        '${b22DateKann.year}-${b22DateKann.month.toString().padLeft(2, '0')}-${b22DateKann.day.toString().padLeft(2, '0')}';
    final b22SizeUghd = (b22FileJjsw.size ?? 0) / 1024 / 1024;
    return '$b22DateTextDmza · ${b22SizeUghd.toStringAsFixed(1)}M';
  }

  Widget b22BuildFileItemFptf(
    B22FileCollectionCoordinatorFigm b22ControllerBopk,
    FileToolsFileInfo b22FileTeng,
  ) {
    return B22TouchGuardComponentKong(
      b22OnPressedXvbd: () =>
          b22ControllerBopk.b22OnFileItemPressedHpbt(b22FileTeng),
      b22ChildWksr: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.w),
        ),
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            B22ResourceImageComponentXjch(
              b22FileIconOigb(b22FileTeng),
              b22WidthKbfi: 40.w,
              b22HeightUsfn: 40.w,
            ),
            B22TranslatedLabelComponentJklc(
              b22FileTeng.name ?? '',
              b22FontSizeIafw: 14.sp,
              b22ColorZcbj: Color(0xff000000),
              b22OverflowUwxb: TextOverflow.ellipsis,
              b22FontTypeQdme: B22FontKindGnzs.black,
            ),
            B22TranslatedLabelComponentJklc(
              b22FormatFileMetadataDxxd(b22FileTeng),
              b22FontSizeIafw: 10.sp,
              b22ColorZcbj: const Color(0xff5E5E5E),
              b22OverflowUwxb: TextOverflow.ellipsis,
              b22FontTypeQdme: B22FontKindGnzs.medium,
            ),
          ],
        ),
      ),
    );
  }

  Widget b22BuildDemoDocumentEmptyStateUcbb({
    required B22FileCollectionCoordinatorFigm b22ControllerVwrg,
    required Widget b22EmptyWidgetMyxl,
  }) {
    final FileToolsFileInfo? b22DemoFileIwrn =
        b22ControllerVwrg.b22DemoFileInfoYgam;
    if (b22DemoFileIwrn == null) {
      return b22EmptyWidgetMyxl;
    }
    return Column(
      children: [
        b22BuildFileItemFptf(b22ControllerVwrg, b22DemoFileIwrn),
        Expanded(child: b22EmptyWidgetMyxl),
      ],
    );
  }

  Widget b22BuildNoFilesStateXncl(
    B22FileCollectionCoordinatorFigm b22ControllerSdwj,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          B22ResourceImageComponentXjch(
            'b22_brand_identity_hvdt/b22_document_badges_oqwu/b22_pdf_badge_qmqd',
            b22WidthKbfi: 72.w,
            b22HeightUsfn: 72.w,
          ),
          SizedBox(height: 16.h),
          B22TranslatedLabelComponentJklc(
            'b22_no_files_found_jbgl'.tr,
            b22FontSizeIafw: 18.sp,
            b22ColorZcbj: Colors.black,
            b22FontWeightPcyy: FontWeight.bold,
          ),
          SizedBox(height: 24.h),
          B22TouchGuardComponentKong(
            b22OnPressedXvbd: b22ControllerSdwj.b22RefreshFilesWnkt,
            b22ChildWksr: Container(
              height: 42.h,
              constraints: BoxConstraints(minWidth: 132.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21.w),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffFF8E71), Color(0xffA77FF1)],
                ),
              ),
              child: B22TranslatedLabelComponentJklc(
                'b22_try_again_itaf'.tr,
                b22FontSizeIafw: 14.sp,
                b22ColorZcbj: Colors.white,
                b22FontWeightPcyy: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget b22BuildLoadingStateJrla() =>
      Center(child: CircularProgressIndicator());

  Widget b22BuildPermissionRequiredStateIvdt(
    B22FileCollectionCoordinatorFigm b22ControllerTwuo,
  ) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      B22ResourceImageComponentXjch(
        "b22_workspace_media_vwug/b22_library_actions_pxds/b22_storage_access_guide_mkur",
        b22WidthKbfi: 140.w,
        b22HeightUsfn: 120.w,
      ),
      SizedBox(height: 12.h),
      B22TranslatedLabelComponentJklc(
        'b22_no_permissions_granted_dqwz'.tr,
        b22FontSizeIafw: 16.sp,
        b22ColorZcbj: Color(0xff1A1D22),
        b22FontTypeQdme: B22FontKindGnzs.extra,
      ),
      SizedBox(height: 6.h),
      B22TranslatedLabelComponentJklc(
        'b22_permission_is_required_to_access_mbpc'.tr,
        b22FontSizeIafw: 12.sp,
        b22ColorZcbj: Color(0xff7B7B7B),
        b22FontTypeQdme: B22FontKindGnzs.medium,
      ),
      SizedBox(height: 34.h),
      B22TouchGuardComponentKong(
        b22OnPressedXvbd: () {
          b22ControllerTwuo.b22OnRequestPermissionPressedAvnl();
        },
        b22ChildWksr: Container(
          width: 208.w,
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: B22TranslatedLabelComponentJklc(
            'b22_go_to_settings_bijb'.tr,
            b22FontSizeIafw: 16.sp,
            b22ColorZcbj: Colors.white,
            b22FontWeightPcyy: FontWeight.bold,
            b22FontTypeQdme: B22FontKindGnzs.semi,
          ),
        ),
      ),
    ],
  );
}

class B22DocumentsNativePromotionPanelWhnn extends StatefulWidget {
  const B22DocumentsNativePromotionPanelWhnn();

  @override
  State<B22DocumentsNativePromotionPanelWhnn> createState() =>
      B22DocumentsNativePromotionPanelStateVtgc();
}

class B22DocumentsNativePromotionPanelStateVtgc
    extends State<B22DocumentsNativePromotionPanelWhnn> {
  Widget? b22BuildNativeAdSmfm;

  @override
  void initState() {
    super.initState();
    unawaited(b22AttachNativeAdWidgetBoqu());
  }

  Future<void> b22AttachNativeAdWidgetBoqu() async {
    final Widget? b22AdWidgetLkfn = await B22PromotionOrchestratorAzwq.instance
        .b22TakeDocumentListNativeAdUotz(
          b22LoadIfNeededOhqi: true,
          b22ReloadAfterTakeXonr: true,
          b22DisposeDelayJhsc: Duration.zero,
        );
    if (b22AdWidgetLkfn == null) return;
    if (!mounted) {
      try {
        await FlutterPdfAdPlugins.instance.disposeTakenAdWidget(
          b22AdWidgetLkfn,
        );
      } catch (_) {}
      return;
    }
    setState(() => b22BuildNativeAdSmfm = b22AdWidgetLkfn);
  }

  @override
  Widget build(BuildContext context) =>
      b22BuildNativeAdSmfm ??
      const B22ResourceImageComponentXjch(
        'b22_monetization_media_pgct/b22_native_ad_surfaces_fxri/b22_native_ad_fallback_fyvg',
        b22WidthKbfi: double.infinity,
      );
}
