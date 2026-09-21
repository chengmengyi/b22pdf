import 'dart:async';

import 'package:b21pdf/core/ads/ad_service.dart';
import 'package:b21pdf/features/library/presentation/document_list/document_list_controller.dart';
import 'package:b21pdf/features/library/presentation/library_tab/library_tab_controller.dart';
import 'package:b21pdf/core/presentation/base_tab.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/media_padding_view.dart';
import 'package:b21pdf/shared/widgets/refresh_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DocumentList extends BaseTab {
  final DocumentCategory type;
  const DocumentList({super.key, required this.type});

  @override
  State<DocumentList> createState() => _DocumentsListSectionState();
}

class _DocumentsListSectionState
    extends BaseSectionState<DocumentListController, DocumentList> {
  @override
  String get controllerTag => 'files_${widget.type.name}';

  @override
  DocumentListController createController() {
    return DocumentListController(type: widget.type);
  }

  @override
  Widget buildContent(BuildContext context, DocumentListController controller) {
    return GetBuilder<DocumentListController>(
      init: controller,
      global: false,
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Column(
            children: [
              _buildSortControls(controller),
              _buildContentSection(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortControls(DocumentListController controller) => Container(
    width: double.infinity,
    height: 44.h,
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Expanded(
          child: TapGuardView(
            onPressed: () {
              controller.runDebugActions();
            },
            child: LocalizedTextView(
              "Local Storage".tr,
              fontSize: 16.sp,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              fontType: FontType.extra,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        TapGuardView(
          onPressed: () {
            controller.onSortPressed();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetPictureView(
                "document_library/sort_menu",
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 2.w),
              LocalizedTextView(
                "Sort".tr,
                fontSize: 10.sp,
                color: Color(0xff334155),
                fontWeight: FontWeight.w500,
                fontType: FontType.semi,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        TapGuardView(
          onPressed: () {
            controller.onDeleteFilePressed();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetPictureView(
                "document_library/select_documents",
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 2.w),
              LocalizedTextView(
                "Select".tr,
                fontSize: 10.sp,
                color: Color(0xff334155),
                fontWeight: FontWeight.w500,
                fontType: FontType.semi,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildContentSection(DocumentListController controller) => Expanded(
    child: switch (controller.listState) {
      DocumentListState.noPermission => _buildDemoDocumentEmptyState(
        controller: controller,
        emptyWidget: _buildPermissionRequiredState(controller),
      ),
      DocumentListState.loading => _buildLoadingState(),
      DocumentListState.loaded =>
        controller.visibleFiles.isEmpty
            ? _buildDemoDocumentEmptyState(
                controller: controller,
                emptyWidget: _buildNoFilesState(controller),
              )
            : _buildDocumentListViewport(controller),
    },
  );

  Widget _buildDocumentListViewport(DocumentListController controller) =>
      MediaPaddingView(
        child: RefreshView(
          enableLoadMore: false,
          controller: controller.refreshController,
          scrollController: controller.scrollController,
          onRefresh: controller.refreshFiles,
          child: _buildFileList(controller),
        ),
      );

  Widget _buildFileList(DocumentListController controller) {
    final bool canShowNativeAd = controller.canShowNativeAd;
    final int nativeAdCount = canShowNativeAd
        ? controller.visibleFiles.length ~/
              DocumentListController.nativeAdInterval
        : 0;
    final int itemCount = controller.visibleFiles.length + nativeAdCount;
    controller.syncNativeAdListState(itemCount);
    final int groupCount =
        (controller.visibleFiles.length +
            DocumentListController.nativeAdInterval -
            1) ~/
        DocumentListController.nativeAdInterval;
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: groupCount,
          itemBuilder: (BuildContext context, int groupIndex) {
            return _buildFileGroup(
              controller: controller,
              groupIndex: groupIndex,
              canShowNativeAd: canShowNativeAd,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFileGroup({
    required DocumentListController controller,
    required int groupIndex,
    required bool canShowNativeAd,
  }) {
    final int interval = DocumentListController.nativeAdInterval;
    final int startIndex = groupIndex * interval;
    final int remainingFiles = controller.visibleFiles.length - startIndex;
    final int fileCount = remainingFiles < interval ? remainingFiles : interval;
    final bool showAdAfterGroup = canShowNativeAd && fileCount == interval;
    final int nativeAdListIndex = (groupIndex + 1) * (interval + 1) - 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          children: List<Widget>.generate(fileCount, (int offset) {
            final file = controller.visibleFiles[startIndex + offset];
            return StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: _buildFileItem(controller, file),
            );
          }),
        ),
        if (showAdAfterGroup)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: _buildNativeAdSlot(
              controller: controller,
              listIndex: nativeAdListIndex,
              showNativeAd: controller.activeNativeAdIndex == nativeAdListIndex,
            ),
          ),
      ],
    );
  }

  Widget _buildNativeAdSlot({
    required DocumentListController controller,
    required int listIndex,
    required bool showNativeAd,
  }) {
    controller.prepareNativeAdSlot(listIndex);
    return VisibilityDetector(
      key: ValueKey('document_inline_ad_${listIndex}_vke'),
      onVisibilityChanged: (info) => controller.updateNativeAdVisibility(
        listIndex,
        info.visibleFraction > 0,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 68.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          child: showNativeAd
              ? KeyedSubtree(
                  key: ValueKey(
                    'document_native_ad_${listIndex}_${controller.nativeAdRefreshKey}_vke',
                  ),
                  child: const _DocumentsNativeAdContent(),
                )
              : const AssetPictureView(
                  'ads/native_ad_placeholder',
                  width: double.infinity,
                ),
        ),
      ),
    );
  }

  String _fileIcon(FileToolsFileInfo file) => switch (file.type) {
    FileToolsDocumentType.pdf => 'branding/pdf_logo',
    FileToolsDocumentType.excel => 'branding/excel_logo',
    _ => 'branding/word_logo',
  };

  String _formatFileMetadata(FileToolsFileInfo file) {
    final date = DateTime.fromMillisecondsSinceEpoch(file.updateTime ?? 0);
    final dateText =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final size = (file.size ?? 0) / 1024 / 1024;
    return '$dateText · ${size.toStringAsFixed(1)}M';
  }

  Widget _buildFileItem(
    DocumentListController controller,
    FileToolsFileInfo file,
  ) {
    return TapGuardView(
      onPressed: () => controller.onFileItemPressed(file),
      child: Container(
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
            AssetPictureView(_fileIcon(file), width: 40.w, height: 40.w),
            LocalizedTextView(
              file.name ?? '',
              fontSize: 14.sp,
              color: Color(0xff000000),
              overflow: TextOverflow.ellipsis,
              fontType: FontType.black,
            ),
            LocalizedTextView(
              _formatFileMetadata(file),
              fontSize: 10.sp,
              color: const Color(0xff5E5E5E),
              overflow: TextOverflow.ellipsis,
              fontType: FontType.medium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoDocumentEmptyState({
    required DocumentListController controller,
    required Widget emptyWidget,
  }) {
    final FileToolsFileInfo? demoFile = controller.demoFileInfo;
    if (demoFile == null) {
      return emptyWidget;
    }
    return Column(
      children: [
        _buildFileItem(controller, demoFile),
        Expanded(child: emptyWidget),
      ],
    );
  }

  Widget _buildNoFilesState(DocumentListController controller) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetPictureView('branding/pdf_logo', width: 72.w, height: 72.w),
          SizedBox(height: 16.h),
          LocalizedTextView(
            'No files found'.tr,
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 24.h),
          TapGuardView(
            onPressed: controller.refreshFiles,
            child: Container(
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
              child: LocalizedTextView(
                'Try again'.tr,
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() => Center(child: CircularProgressIndicator());

  Widget _buildPermissionRequiredState(DocumentListController controller) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AssetPictureView(
            "document_library/storage_permission",
            width: 140.w,
            height: 120.w,
          ),
          SizedBox(height: 12.h),
          LocalizedTextView(
            "No permissions granted".tr,
            fontSize: 16.sp,
            color: Color(0xff1A1D22),
            fontType: FontType.extra,
          ),
          SizedBox(height: 6.h),
          LocalizedTextView(
            "Permission is required to access all files".tr,
            fontSize: 12.sp,
            color: Color(0xff7B7B7B),
            fontType: FontType.medium,
          ),
          SizedBox(height: 34.h),
          TapGuardView(
            onPressed: () {
              controller.onRequestPermissionPressed();
            },
            child: Container(
              width: 208.w,
              height: 44.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: LocalizedTextView(
                "Go to settings".tr,
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontType: FontType.semi,
              ),
            ),
          ),
        ],
      );
}

class _DocumentsNativeAdContent extends StatefulWidget {
  const _DocumentsNativeAdContent();

  @override
  State<_DocumentsNativeAdContent> createState() =>
      _DocumentsNativeAdContentState();
}

class _DocumentsNativeAdContentState extends State<_DocumentsNativeAdContent> {
  Widget? _buildNativeAd;

  @override
  void initState() {
    super.initState();
    unawaited(_attachNativeAdWidget());
  }

  Future<void> _attachNativeAdWidget() async {
    final Widget? adWidget = await AdService.instance.takeDocumentListNativeAd(
      loadIfNeeded: true,
      reloadAfterTake: true,
      disposeDelay: Duration.zero,
    );
    if (adWidget == null) return;
    if (!mounted) {
      try {
        await FlutterPdfAdPlugins.instance.disposeTakenAdWidget(adWidget);
      } catch (_) {}
      return;
    }
    setState(() => _buildNativeAd = adWidget);
  }

  @override
  Widget build(BuildContext context) =>
      _buildNativeAd ??
      const AssetPictureView(
        'ads/native_ad_placeholder',
        width: double.infinity,
      );
}
