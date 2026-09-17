import 'package:b21pdf/features/home_widget/services/home_widget_service.dart';
import 'package:b21pdf/core/analytics/analytics_event.dart';
import 'package:b21pdf/core/analytics/analytics_service.dart';
import 'package:b21pdf/features/library/presentation/document_list/document_list.dart';
import 'package:b21pdf/features/library/presentation/library_tab/library_tab_controller.dart';
import 'package:b21pdf/core/presentation/base_tab.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LibraryTab extends BaseTab {
  const LibraryTab({super.key});

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState
    extends BaseSectionState<LibraryTabController, LibraryTab> {
  @override
  LibraryTabController createController() {
    return LibraryTabController();
  }

  @override
  Widget buildContent(BuildContext context, LibraryTabController controller) {
    return GetBuilder<LibraryTabController>(
      init: controller,
      builder: (controller) => Column(
        children: [
          _buildHeader(controller),
          _buildCategoryTabs(controller),
          // if (controller.showAddWidget) _buildAddWidgetBanner(),
          _buildTabPages(controller),
        ],
      ),
    );
  }

  Widget _buildTabPages(LibraryTabController controller) => Expanded(
    child: PageView.builder(
      controller: controller.pageController,
      itemCount: DocumentCategory.values.length,
      onPageChanged: (int index) => controller.onPageChanged(index, context),
      itemBuilder: (BuildContext context, int index) =>
          DocumentList(type: DocumentCategory.values[index]),
    ),
  );

  Widget _buildCategoryTabs(LibraryTabController controller) => Container(
    width: double.infinity,
    height: 43.h,
    margin: EdgeInsets.all(12.w),
    padding: EdgeInsets.all(5.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
    ),
    child: ListView.separated(
      itemCount: DocumentCategory.values.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final DocumentCategory category = DocumentCategory.values[index];
        final bool isSelected = index == controller.selectedTabIndex;
        return TapGuardView(
          onPressed: () {
            controller.selectCategory(category);
          },
          child: Container(
            width: 76.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              color: isSelected?Colors.black:Color(0xffFFFAF6),
            ),
            child: LocalizedTextView(
              category.label.tr,
              fontSize: 14.sp,
              color: isSelected ? Colors.white : const Color(0xff5E5E5E),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(width: 6.w),
    ),
  );

  // Widget _buildAddWidgetBanner() => Stack(
  //   alignment: Alignment.bottomLeft,
  //   children: [
  //     Container(
  //       width: double.infinity,
  //       height: 56.h,
  //       margin: EdgeInsets.only(top: 8.h),
  //       padding: EdgeInsets.only(left: 68.w, right: 16.w),
  //       decoration: BoxDecoration(
  //         color: const Color(0xffFFECB8),
  //         borderRadius: BorderRadius.circular(28.w),
  //       ),
  //       child: Row(
  //         children: [
  //           SizedBox(width: 8.w),
  //           Expanded(
  //             child: LocalizedTextView(
  //               "To access features instantly, add the widget!".tr,
  //               fontSize: 14.sp,
  //               color: Color(0xff07080E),
  //               overflow: TextOverflow.ellipsis,
  //               maxLines: 2,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //           SizedBox(width: 8.w),
  //           TapGuardView(
  //             onPressed: () {
  //               HomeWidgetService.instance.openWidgetPicker();
  //             },
  //             child: Container(
  //               padding: EdgeInsets.only(
  //                 left: 16.w,
  //                 right: 16.w,
  //                 top: 4.h,
  //                 bottom: 4.h,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(18.w),
  //               ),
  //               child: LocalizedTextView(
  //                 "Grant".tr,
  //                 fontSize: 14.sp,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     AssetPictureView(
  //       "home_widget/add_widget_banner",
  //       width: 64.w,
  //       height: 64.w,
  //     ),
  //   ],
  // );

  Widget _buildHeader(LibraryTabController controller) => Container(
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 60.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12.w,right: 12.w),
        child: _inputWidget(controller),
      ),
    ),
  );

  _titleWidget(LibraryTabController controller)=>Row(
    children: [
      TapGuardView(
        onPressed: (){
          controller.runDebugActions();
        },
        child: LocalizedTextView(
          "Files".tr,
          fontSize: 28.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontType: FontType.extra,
        ),
      ),
      Spacer(),
      TapGuardView(
        onPressed: (){

        },
        child: AssetPictureView("common/search", width: 32.w, height: 32.w),
      ),
    ],
  );

  _inputWidget(LibraryTabController controller)=>Container(
    width: double.infinity,
    height: 44.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 10.w,right: 10.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
      border: Border.all(
        width: 2.w,
        color: Colors.black,
      ),
    ),
    child: Row(
      children: [
        AssetPictureView("common/search", width: 28.w, height: 28.w),
        SizedBox(width: 4.w,),
        Expanded(
          child: TextField(
            enabled: true,
            textAlign: TextAlign.left,
            controller: controller.textEditingController,
            textInputAction: TextInputAction.search,
            style: TextStyle(fontSize: 14.sp, color: Color(0xff000000)),
            onTap: () {
              AnalyticsService.instance.trackEvent(
                pointType: AnalyticsEvent.search_click,
              );
            },
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "Search...".tr,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff5E5E5E),
              ),
              border: InputBorder.none,
            ),
            onChanged: controller.updateFileSearchQuery,
            onSubmitted: controller.updateFileSearchQuery,
          ),
        ),
      ],
    ),
  );
}
