import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_preview_lzrw/b22_document_viewers_ucjg/b22_excel_amzg/b22_interface_nitf/b22_spreadsheet_reader_coordinator_yzwu.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22SpreadsheetReaderPageFkwp
    extends B22FoundationPageNhfc<B22SpreadsheetReaderCoordinatorWmkr> {
  const B22SpreadsheetReaderPageFkwp({super.key});
  @override
  B22SpreadsheetReaderCoordinatorWmkr createController() =>
      B22SpreadsheetReaderCoordinatorWmkr();

  @override
  Future<bool> canPopRoute(
    B22SpreadsheetReaderCoordinatorWmkr b22ControllerXomf,
  ) async {
    b22ControllerXomf.b22OnBackPressedFiev();
    return false;
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22SpreadsheetReaderCoordinatorWmkr b22ControllerRkvg,
  ) => GetBuilder<B22SpreadsheetReaderCoordinatorWmkr>(
    init: b22ControllerRkvg,
    global: false,
    builder: (b22ControllerCnvf) => Column(
      children: [
        b22BuildTitleBarDqhk(b22ControllerCnvf),
        b22BuildMainContentJsyo(b22ControllerCnvf),
        b22BuildBottomBarButk(b22ControllerCnvf),
      ],
    ),
  );
  Widget b22BuildMainContentJsyo(
    B22SpreadsheetReaderCoordinatorWmkr b22ControllerEiok,
  ) => Expanded(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.all(8.w),
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
      child: !b22ControllerEiok.b22CanLoadViewerYksy
          ? const Center(child: CircularProgressIndicator())
          : ExcelFileView(
              controller: b22ControllerEiok.b22ExcelControllerYwlo,
              autoInitialize: false,
              loadingBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              messageBuilder: (_, message) => Center(
                child: B22TranslatedLabelComponentJklc(
                  File(
                        b22ControllerEiok.b22FileInfoFjvl.path ?? '',
                      ).existsSync()
                      ? 'b22_preview_unavailable_dlyi'.tr
                      : 'b22_file_not_found_ygdu'.tr,
                ),
              ),
            ),
    ),
  );
  Widget b22BuildBottomBarButk(
    B22SpreadsheetReaderCoordinatorWmkr b22ControllerRbsw,
  ) => Padding(
    padding: EdgeInsets.all(8.w),
    child: Row(
      children: [
        Expanded(
          child: b22BuildActionButtonSpls(
            b22TextFfgi: b22ControllerRbsw.isSaving
                ? 'b22_saving_ijrs'.tr
                : (b22ControllerRbsw.isEditing
                      ? 'b22_cancel_mdzi'.tr
                      : 'b22_edit_dzer'.tr),
            b22OnTapHwho: b22ControllerRbsw.b22OnEditPressedSowt,
            b22ColorKmcb: b22ControllerRbsw.isEditing
                ? const Color(0xff858C92)
                : const Color(0xff970000),
          ),
        ),
        if (b22ControllerRbsw.isEditing) SizedBox(width: 8.w),
        if (b22ControllerRbsw.isEditing)
          Expanded(
            child: b22BuildActionButtonSpls(
              b22TextFfgi: b22ControllerRbsw.isSaving
                  ? 'b22_saving_ijrs'.tr
                  : 'b22_save_blpm'.tr,
              b22OnTapHwho: b22ControllerRbsw.b22OnSavePressedIkfp,
              b22ColorKmcb: const Color(0xff970000),
            ),
          ),
      ],
    ),
  );
  Widget b22BuildActionButtonSpls({
    required String b22TextFfgi,
    required VoidCallback b22OnTapHwho,
    required Color b22ColorKmcb,
  }) => B22TouchGuardComponentKong(
    b22OnPressedXvbd: b22OnTapHwho,
    b22ChildWksr: Container(
      height: 44.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: b22ColorKmcb,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: B22TranslatedLabelComponentJklc(
        b22TextFfgi,
        b22FontSizeIafw: 16.sp,
        b22ColorZcbj: Colors.white,
        b22FontWeightPcyy: FontWeight.bold,
        b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
      ),
    ),
  );

  Widget b22BuildTitleBarDqhk(
    B22SpreadsheetReaderCoordinatorWmkr b22ControllerPuxb,
  ) => Container(
    width: double.infinity,
    color: Color(0xffFFFAF6),
    child: SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        height: 54.h,
        child: Stack(
          children: [
            B22TouchGuardComponentKong(
              b22OnPressedXvbd: b22ControllerPuxb.b22OnBackPressedFiev,
              b22ChildWksr: SizedBox(
                width: 44.w,
                height: 44.h,
                child: Center(
                  child: B22ResourceImageComponentXjch(
                    'b22_shared_controls_ybsz/b22_navigation_actions_dmkw/b22_navigate_back_fylg',
                    b22WidthKbfi: 28.w,
                    b22HeightUsfn: 28.w,
                  ),
                ),
              ),
            ),
            Align(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 52.w),
                child: B22TranslatedLabelComponentJklc(
                  b22ControllerPuxb.fileName,
                  b22FontSizeIafw: 12.sp,
                  b22ColorZcbj: Colors.black,
                  b22FontWeightPcyy: FontWeight.w500,
                  b22OverflowUwxb: TextOverflow.ellipsis,
                  b22FontTypeQdme: B22FontKindGnzs.b22BlackWgka,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
