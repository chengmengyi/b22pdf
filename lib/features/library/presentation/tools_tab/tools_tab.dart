import 'package:b21pdf/features/library/presentation/tools_tab/tools_tab_controller.dart';
import 'package:b21pdf/features/home_widget/services/home_widget_service.dart';
import 'package:b21pdf/features/pdf_tools/services/image_import_service.dart';
import 'package:b21pdf/core/presentation/base_tab.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ToolsTab extends BaseTab {
  const ToolsTab({super.key});

  @override
  State<ToolsTab> createState() => _UtilitiesSectionState();
}

class _UtilitiesSectionState
    extends BaseSectionState<ToolsTabController, ToolsTab> {
  @override
  ToolsTabController createController() {
    return ToolsTabController();
  }

  @override
  Widget buildContent(BuildContext context, ToolsTabController controller) {
    return GetBuilder<ToolsTabController>(
      init: controller,
      global: false,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(),
          _toolsWidget(),
          _systemWidget(),
          _preferenceWidget(controller),
        ],
      ),
    );
  }

  Widget _toolsWidget() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20.h, left: 12.w, right: 12.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalizedTextView(
          "PDF tools".tr,
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontType: FontType.black,
        ),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Colors.black,
          margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
        ),
        Row(
          children: [
            Expanded(
              child: TapGuardView(
                onPressed: () {
                  ImageImportService.instance.scanDocuments();
                },
                child: Container(
                  width: double.infinity,
                  height: 68.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AssetPictureView(
                        "pdf_tools/scan_to_pdf",
                        width: 40.w,
                        height: 40.h,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: LocalizedTextView(
                          "Scan to PDF".tr,
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontType: FontType.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TapGuardView(
                onPressed: () {
                  ImageImportService.instance.pickImages();
                },
                child: Container(
                  width: double.infinity,
                  height: 68.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AssetPictureView(
                        "pdf_tools/image_to_pdf",
                        width: 40.w,
                        height: 40.h,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: LocalizedTextView(
                          "Image to PDF".tr,
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontType: FontType.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _systemWidget() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalizedTextView(
          "System".tr,
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontType: FontType.black,
        ),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Colors.black,
          margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
        ),
        TapGuardView(
          onPressed: () {
            HomeWidgetService.instance.openWidgetPicker();
          },
          child: Container(
            width: double.infinity,
            height: 60.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Row(
              children: [
                AssetPictureView(
                  "pdf_tools/add_home_widget",
                  width: 38.w,
                  height: 38.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LocalizedTextView(
                    "Add Widget".tr,
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontType: FontType.black,
                  ),
                ),
                AssetPictureView(
                  "pdf_tools/add_widget_icon",
                  width: 24.w,
                  height: 24.w,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _preferenceWidget(ToolsTabController controller) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalizedTextView(
          "Preference".tr,
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontType: FontType.black,
        ),
        Container(
          width: double.infinity,
          height: 2.h,
          color: Colors.black,
          margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
        ),
        TapGuardView(
          onPressed: () {
            controller.onChangeLanguagePressed();
          },
          child: Container(
            width: double.infinity,
            height: 64.h,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                AssetPictureView(
                  "languages/language_icon",
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: LocalizedTextView(
                    "App Language".tr,
                    fontSize: 16.sp,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                    fontType: FontType.black,
                  ),
                ),
                LocalizedTextView(
                  controller.currentLanguageName,
                  fontSize: 12.sp,
                  color: Color(0xff5E5E5E),
                  fontWeight: FontWeight.w500,
                  fontType: FontType.medium,
                ),
                SizedBox(width: 4.w),
                AssetPictureView(
                  "navigation/chevron_right2",
                  width: 18.w,
                  height: 18.w,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildTitleSection() => Container(
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 60.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child: LocalizedTextView(
          "Tools & Settings".tr,
          fontSize: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontType: FontType.black,
        ),
      ),
    ),
  );
}
