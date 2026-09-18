import 'package:b21pdf/core/navigation/app_navigator.dart';
import 'package:b21pdf/features/library/presentation/delete_documents/delete_documents_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/media_padding_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class DeleteDocumentsScreen extends BaseScreen<DeleteDocumentsController> {
  const DeleteDocumentsScreen({super.key});

  @override
  DeleteDocumentsController createController() {
    return DeleteDocumentsController();
  }

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  Widget buildContent(
    BuildContext context,
    DeleteDocumentsController controller,
  ) {
    return GetBuilder<DeleteDocumentsController>(
      init: controller,
      builder: (controller) => Column(
        children: [
          _buildTitleSection(controller),
          _buildLanguageList(controller),
          _buildBottomSection(controller),
        ],
      ),
    );
  }

  _buildLanguageList(DeleteDocumentsController controller) => Expanded(
    child: Container(
      margin: EdgeInsets.all(12.w),
      child: MediaPaddingView(
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          itemCount: controller.files.length,
          itemBuilder: (BuildContext context, int index) {
            final file = controller.files[index];
            return TapGuardView(
              onPressed: () {
                controller.onItemPressed(file);
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AssetPictureView(
                          controller.resolveFileIcon(file),
                          width: 40.w,
                          height: 40.w,
                        ),
                        Spacer(),
                        AssetPictureView(
                          controller.isSelected(file)
                              ? "common/radio_selected"
                              : "common/radio_unselected",
                          width: 28.w,
                          height: 28.w,
                        ),
                      ],
                    ),
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
          },
        ),
      ),
    ),
  );

  Color _fileBackgroundColor(FileToolsFileInfo file) => switch (file.type) {
    FileToolsDocumentType.word => const Color(0xff2C90FE),
    FileToolsDocumentType.excel => const Color(0xff01C87C),
    _ => const Color(0xffF85758),
  };

  String _formatFileMetadata(FileToolsFileInfo file) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(
      file.updateTime ?? 0,
    );
    final String dateText =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final double size = (file.size ?? 0) / 1024 / 1024;
    return '$dateText｜${size.toStringAsFixed(1)}M';
  }

  _buildBottomSection(DeleteDocumentsController controller) => Container(
    width: double.infinity,
    height: 82.h,
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: 16.w, right: 16.w),
    decoration: BoxDecoration(
      color: Color(0xffFFFAF6),
      border: BoxBorder.fromLTRB(
        top: BorderSide(width: 2.w, color: Colors.black),
      ),
    ),
    child: TapGuardView(
      onPressed: () {
        controller.onDeletePressed();
      },
      child: Container(
        width: double.infinity,
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: controller.selectedPaths.isEmpty
              ? const Color(0xff5E5E5E)
              : const Color(0xffC40000),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetPictureView("common/icon_delete", width: 18.w, height: 18.w),
            SizedBox(width: 8.w),
            LocalizedTextView(
              "Delete".tr,
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontType: FontType.black,
            ),
          ],
        ),
      ),
    ),
  );

  _buildTitleSection(DeleteDocumentsController controller) => Container(
    width: double.infinity,
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 54.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Row(
          children: [
            TapGuardView(
              onPressed: controller.onSelectAllPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AssetPictureView(
                    controller.allSelected
                        ? "common/radio_selected"
                        : "common/radio_unselected",
                    width: 28.w,
                    height: 28.w,
                  ),
                  LocalizedTextView(
                    "Select All".tr,
                    fontSize: 12.sp,
                    color: Color(0xff970000),
                    fontType: FontType.medium,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: LocalizedTextView(
                '{n} Selected'.tr.replaceAll(
                  '{n}',
                  controller.selectedPaths.length.toString(),
                ),
                fontSize: 16.sp,
                color: Color(0xff1A1D22),
                fontWeight: FontWeight.bold,
                fontType: FontType.black,
              ),
            ),
            SizedBox(width: 12.w),
            TapGuardView(
              onPressed: () {
                AppNavigator.backWithExitAd<void>();
              },
              child: LocalizedTextView(
                "Cancel".tr,
                fontSize: 12.sp,
                color: Color(0xff5E5E5E),
                fontWeight: FontWeight.w500,
                fontType: FontType.medium,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
