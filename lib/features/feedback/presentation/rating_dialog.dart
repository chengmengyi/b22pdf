import 'package:b21pdf/core/presentation/center_dialog.dart';
import 'package:b21pdf/features/feedback/presentation/rating_controller.dart';
import 'package:b21pdf/core/presentation/controller_widget.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/media_padding_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class RatingDialog extends CenterDialog<RatingController> {
  const RatingDialog({super.key});

  @override
  RatingController createController() => RatingController();

  @override
  Widget buildDialog(BuildContext context, RatingController controller) {
    return TapGuardView(
      onPressed: () {
        controller.onRateUsPressed();
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w,top: 74.h),
            padding: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 30.h,top: 83.h),
            decoration: BoxDecoration(
              color: Color(0xffF5F2E9),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LocalizedTextView(
                  "Enjoying PDF Reader?".tr,
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontType: FontType.black,
                ),
                SizedBox(height: 10.h),
                LocalizedTextView(
                  "Your 5-star rating helps us improve! It only takes a few seconds of your time."
                      .tr,
                  fontSize: 14.sp,
                  color: Color(0xff5E5E5E),
                  fontType: FontType.medium,
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  height: 42.w,
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: GetBuilder<RatingController>(
                    id: RatingController.starBuilderId,
                    builder: (builder) => MediaPaddingView(
                      child: MasonryGridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 5,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 12.w,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          final bool selected = index < builder.starCount;
                          return TapGuardView(
                            onPressed: () {
                              builder.onStarPressed(index);
                            },
                            child: AssetPictureView(
                              selected
                                  ? "feedback/star_selected"
                                  : "feedback/star_unselected",
                              width: 42.w,
                              height: 42.w,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TapGuardView(
                  onPressed: controller.onRateUsPressed,
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffC40000),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: LocalizedTextView(
                      "Rate Us 5 Stars".tr,
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontType: FontType.extra,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AssetPictureView(
            "home/comment_bg",
            width: 240.w,
            height: 145.h,
          ),
          Positioned(
            top: 84.h,
            right: 12.w,
            child: TapGuardView(
              onPressed: () {
                controller.onClosePressed();
              },
              child: Container(
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                child: AssetPictureView(
                  "navigation/close",
                  height: 24.w,
                  width: 24.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
