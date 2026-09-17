import 'package:b21pdf/features/pdf_tools/services/image_import_service.dart';
import 'package:b21pdf/features/library/presentation/home/home_controller.dart';
import 'package:b21pdf/core/presentation/base_screen.dart';
import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:b21pdf/shared/widgets/localized_text_view.dart';
import 'package:b21pdf/shared/widgets/tap_guard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  HomeController createController() {
    return HomeController();
  }

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  bool get resizeToAvoidBottomInset => false;
  

  @override
  Future<bool> canPopRoute(HomeController controller) =>
      controller.onSystemBackRequested();

  @override
  Widget buildContent(BuildContext context, HomeController controller) {
    return GetBuilder<HomeController>(
      id: HomeController.tabUpdateId,
      builder: (HomeController controller) {
        return Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: controller.tabIndex,
                children: controller.pages,
              ),
            ),
            buildBottomNavigation(controller, context),
          ],
        );
      },
    );
  }

  Widget buildBottomNavigation(
    HomeController controller,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      height: 64.h,
      decoration: BoxDecoration(
        color: Color(0xffFFFAF6),
      ),
      child: Row(
        children: [
          itemWidget(HomeTab.files, controller, context),
          Expanded(
            child: TapGuardView(
              onPressed: () {
                ImageImportService.instance.scanDocuments();
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AssetPictureView(
                      'home/scan_action',
                      width: 32.w,
                      height: 32.w,
                    ),
                    LocalizedTextView(
                      "Scan".tr,
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontType: FontType.semi,
                    ),
                  ],
                ),
              ),
            ),
          ),
          itemWidget(HomeTab.tools, controller, context),
        ],
      ),
    );
  }

  Widget itemWidget(
    HomeTab type,
    HomeController controller,
    BuildContext context,
  ) {
    final bool selected = controller.tabIndex == type.index;
    return Expanded(
      child: TapGuardView(
        onPressed: () {
          controller.onTabSelected(type, context);
        },
        child: Container(
          alignment: Alignment.center,
          color: selected?Color(0xff970000):Color(0xffFFFAF6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetPictureView(
                selected ? type.iconSelected : type.iconUnselected,
                width: 32.w,
                height: 32.w,
              ),
              LocalizedTextView(
                type.text.tr,
                fontSize: 10.sp,
                color: selected
                    ? const Color(0xffFFFFFF)
                    : const Color(0xff000000),
                fontWeight: FontWeight.bold,
                fontType: FontType.semi,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
