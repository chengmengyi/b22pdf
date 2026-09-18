import 'dart:io';

import 'package:b21pdf/features/pdf_tools/presentation/image_selection/image_selection_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageSelectionScreen extends BaseScreen<ImageSelectionController> {
  const ImageSelectionScreen({super.key});

  @override
  ImageSelectionController createController() {
    return ImageSelectionController();
  }

  @override
  Color get navigationBarColor => Colors.white;

  @override
  Widget buildContent(
    BuildContext context,
    ImageSelectionController controller,
  ) {
    return GetBuilder<ImageSelectionController>(
      builder: (ImageSelectionController controller) => Column(
        children: [
          _buildTitleBar(controller),
          _buildMainContent(controller),
          _buildBottomBar(controller),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ImageSelectionController controller) => Container(
    width: double.infinity,
    height: 66.h,
    padding: EdgeInsets.only(left: 12.w, right: 12.w),
    decoration: BoxDecoration(
      color: Color(0xffFFFAF6),
      border: BoxBorder.fromLTRB(
        top: BorderSide(width: 2.w, color: Colors.black),
      ),
    ),
    child: Row(
      children: [
        TapGuardView(
          onPressed: controller.onReplacePressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetPictureView("pdf_tools/rescan", width: 28.w, height: 28.w),
              SizedBox(width: 4.h),
              LocalizedTextView(
                "Retake".tr,
                fontSize: 12.sp,
                color: Color(0xff333333),
                fontWeight: FontWeight.w500,
                fontType: FontType.medium,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        TapGuardView(
          onPressed: controller.onAddPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetPictureView("pdf_tools/add_page", width: 28.w, height: 28.w),
              SizedBox(width: 4.h),
              LocalizedTextView(
                "Add".tr,
                fontSize: 12.sp,
                color: Color(0xff333333),
                fontWeight: FontWeight.w500,
                fontType: FontType.medium,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: TapGuardView(
            onPressed: () {
              controller.onSavePressed();
            },
            child: Container(
              width: double.infinity,
              height: 44.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffC40000),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AssetPictureView(
                    "common/confirm_white",
                    width: 18.w,
                    height: 18.w,
                  ),
                  SizedBox(width: 4.w),
                  LocalizedTextView(
                    "Save PDF".tr,
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontType: FontType.medium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildMainContent(ImageSelectionController controller) => Expanded(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(0, -0.5),
          ),
        ],
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.imagePaths.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (_, int index) {
              return Image.file(
                File(controller.imagePaths[index]),
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _pagesWidget(controller),
          ),
        ],
      ),
    ),
  );

  _pagesWidget(ImageSelectionController controller) => Container(
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
      color: Color(0xffF2E9D9).withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(2.w),
      border: Border.all(width: 1.w, color: Colors.black),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TapGuardView(
          onPressed: controller.selectedIndex > 0
              ? controller.showPreviousPage
              : null,
          child: AssetPictureView(
            "editor/icon_reduce",
            width: 32.w,
            height: 32.w,
          ),
        ),
        Container(width: 1.w, height: 16.h, color: Colors.black),
        SizedBox(width: 24.w),
        LocalizedTextView(
          "${controller.imagePaths.isEmpty ? 0 : controller.selectedIndex + 1} / ${controller.imagePaths.length}",
          fontSize: 14.sp,
          color: Colors.black,
          fontType: FontType.medium,
        ),
        SizedBox(width: 24.w),
        Container(width: 1.w, height: 16.h, color: Colors.black),
        TapGuardView(
          onPressed: controller.selectedIndex < controller.imagePaths.length - 1
              ? controller.showNextPage
              : null,
          child: AssetPictureView("editor/icon_add", width: 32.w, height: 32.w),
        ),
      ],
    ),
  );

  Widget _buildTitleBar(ImageSelectionController controller) => Container(
    width: double.infinity,
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        height: 54.h,
        child: Stack(
          children: [
            TapGuardView(
              onPressed: controller.onBackPressed,
              child: SizedBox(
                width: 44.w,
                height: 44.h,
                child: Center(
                  child: AssetPictureView(
                    'navigation/back',
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
