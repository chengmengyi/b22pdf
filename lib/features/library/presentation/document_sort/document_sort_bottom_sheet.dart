import 'package:b21pdf/features/library/presentation/document_sort/document_sort_controller.dart';
import 'package:b21pdf/core/navigation/app_navigator.dart';
import 'package:b21pdf/core/presentation/controller_widget.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/media_padding_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocumentSortBottomSheet extends ControllerWidget<DocumentSortController> {
  final SortType selectedType;
  DocumentSortBottomSheet({required this.selectedType});

  @override
  DocumentSortController createController() =>
      DocumentSortController(selectedType: selectedType);

  @override
  Widget buildContent(BuildContext context, DocumentSortController controller) {
    return Container(
      color: Color(0xffF5F2E9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleSection(),
          _buildLanguageList(controller),
        ],
      ),
    );
  }

  _buildLanguageList(DocumentSortController controller) => MediaPaddingView(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: SortType.values.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var type = SortType.values[index];
        final bool selected = type == controller.selectedType;
        return TapGuardView(
          onPressed: () {
            controller.onSortPressed(type);
          },
          child: Container(
            width: double.infinity,
            height: 73.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.w,right: 20.w),
            decoration: BoxDecoration(
              color: selected?Color(0xff970000):null,
              border: selected?BoxBorder.fromLTRB(
                top: BorderSide(
                  width: 2.w,
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  width: 2.w,
                  color: Colors.black,
                ),
              ):null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocalizedTextView(
                        type.text.tr,
                        fontSize: 16.sp,
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        fontType: FontType.extra,
                      ),
                      LocalizedTextView(
                        type.desc.tr,
                        fontSize: 12.sp,
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        fontType: FontType.medium,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                if (selected)
                  AssetPictureView(
                    "document_library/sort_selection",
                    width: 28.w,
                    height: 28.w,
                  ),
              ],
            ),
          ),
        );
      },
    ),
  );

  _buildTitleSection() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 3.h,
        color: Color(0xff970000),
      ),
      SizedBox(
        width: double.infinity,
        height: 64.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 20.w),
                child: LocalizedTextView(
                  "Sort By".tr,
                  fontSize: 20.sp,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.bold,
                  fontType: FontType.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 16.w),
                child: TapGuardView(
                  onPressed: () {
                    AppNavigator.back();
                  },
                  child: AssetPictureView(
                    "navigation/close",
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
