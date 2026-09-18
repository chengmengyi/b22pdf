import 'package:b21pdf/core/config/app_config.dart';
import 'package:b21pdf/core/navigation/app_navigator.dart';
import 'package:b21pdf/features/home_widget/presentation/home_widget_controller.dart';
import 'package:b21pdf/features/home_widget/services/home_widget_service.dart';
import 'package:b21pdf/core/presentation/controller_widget.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/media_padding_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeWidgetBottomSheet extends ControllerWidget<HomeWidgetController> {
  const HomeWidgetBottomSheet({super.key});

  @override
  HomeWidgetController createController() => HomeWidgetController();

  @override
  Widget buildContent(BuildContext context, HomeWidgetController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Color(0xffF5F2E9),
        border: BoxBorder.fromLTRB(
          top: BorderSide(
            width: 4.w,
            color: Color(0xffC40000),
          )
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _titleWidget(),
          SizedBox(height: 20.h),
          _buildContentSection(),
          SizedBox(height: 28.h),
          TapGuardView(
            onPressed: () {
              controller.onAddPressed();
            },
            child: Container(
              width: double.infinity,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffC40000),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: LocalizedTextView(
                "+ ${"Add".tr}",
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontType: FontType.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetPictureView(
              'branding/app_logo',
              width: 20.w,
              height: 20.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: LocalizedTextView(
                AppConfig.applicationName.tr,
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                fontType: FontType.semi,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Container(
          width: double.infinity,
          height: 42.h,
          decoration: BoxDecoration(
            color: Color(0xffF5F2E9),
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(
              width: 2.w,
              color: Color(0xff000000),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 12.w),
              AssetPictureView("common/search", width: 28.w, height: 28.w),
              SizedBox(width: 8.w),
              LocalizedTextView(
                "Search...".tr,
                fontSize: 12.sp,
                color: Color(0xff5E5E5E),
                fontType: FontType.semi,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        MediaPaddingView(
          child: MasonryGridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 8.w,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: InsertWidgetType.values.length,
            itemBuilder: (BuildContext context, int index) {
              var type = InsertWidgetType.values[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AssetPictureView("home_widget/${type.icon}", width: 32.w, height: 32.w),
                  SizedBox(height: 4.h),
                  LocalizedTextView(
                    type.text.tr,
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontType: FontType.medium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );

  _titleWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          LocalizedTextView(
            'Add Widget'.tr,
            fontSize: 16.sp,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
            fontType: FontType.black,
          ),
          Spacer(),
          TapGuardView(
            onPressed: (){
              AppNavigator.back();
            },
            child: AssetPictureView("common/icon_close",width: 14.w,height: 14.w,),
          ),
        ],
      ),
      SizedBox(height: 10.h),
      LocalizedTextView(
        'Add widget with one click to open files'.tr,
        fontSize: 14.sp,
        color: const Color(0xff5E5E5E),
        fontType: FontType.black,
      ),
      Container(
        width: double.infinity,
        height: 2.h,
        color: Colors.black,
        margin: EdgeInsets.only(top: 10.h),
      )
    ],
  );
}
