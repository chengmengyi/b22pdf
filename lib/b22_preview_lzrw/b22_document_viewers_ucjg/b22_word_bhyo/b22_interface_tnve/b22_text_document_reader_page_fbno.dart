import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_preview_lzrw/b22_document_viewers_ucjg/b22_word_bhyo/b22_interface_tnve/b22_text_document_reader_coordinator_kdpg.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22TextDocumentReaderPageBzae
    extends B22FoundationPageNhfc<B22TextDocumentReaderCoordinatorXnjj> {
  const B22TextDocumentReaderPageBzae({super.key});
  @override
  B22TextDocumentReaderCoordinatorXnjj createController() =>
      B22TextDocumentReaderCoordinatorXnjj();

  @override
  Future<bool> canPopRoute(
    B22TextDocumentReaderCoordinatorXnjj b22ControllerMebu,
  ) async {
    b22ControllerMebu.b22OnBackPressedDpbg();
    return false;
  }

  @override
  Widget buildContent(
    BuildContext context,
    B22TextDocumentReaderCoordinatorXnjj b22ControllerHtuf,
  ) => GetBuilder<B22TextDocumentReaderCoordinatorXnjj>(
    init: b22ControllerHtuf,
    global: false,
    builder: (b22ControllerJytn) => Column(
      children: [
        b22BuildTitleBarWnmi(b22ControllerJytn),
        b22BuildMainContentYmru(b22ControllerJytn),
        b22BuildBottomBarUlli(b22ControllerJytn),
      ],
    ),
  );

  Widget b22BuildMainContentYmru(
    B22TextDocumentReaderCoordinatorXnjj b22ControllerGscd,
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
      child: !b22ControllerGscd.b22CanLoadViewerZyas
          ? const Center(child: CircularProgressIndicator())
          : WordFileView(
              controller: b22ControllerGscd.b22WordControllerWnao,
              autoInitialize: false,
              loadingBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              messageBuilder: (_, message) => Center(
                child: B22TranslatedLabelComponentJklc(
                  File(
                        b22ControllerGscd.b22FileInfoSlga.path ?? '',
                      ).existsSync()
                      ? 'Preview unavailable'.tr
                      : 'File not found'.tr,
                ),
              ),
            ),
    ),
  );

  Widget b22BuildBottomBarUlli(
    B22TextDocumentReaderCoordinatorXnjj b22ControllerDidc,
  ) => Padding(
    padding: EdgeInsets.all(8.w),
    child: Row(
      children: [
        Expanded(
          child: b22BuildActionButtonUksy(
            b22TextZzfg: b22ControllerDidc.isSaving
                ? 'Saving...'.tr
                : (b22ControllerDidc.isEditing ? 'Cancel'.tr : 'Edit'.tr),
            b22OnTapLhry: b22ControllerDidc.b22OnEditPressedBpdn,
            b22ColorDnow: b22ControllerDidc.isEditing
                ? const Color(0xff858C92)
                : const Color(0xff970000),
          ),
        ),
        if (b22ControllerDidc.isEditing) SizedBox(width: 8.w),
        if (b22ControllerDidc.isEditing)
          Expanded(
            child: b22BuildActionButtonUksy(
              b22TextZzfg: b22ControllerDidc.isSaving
                  ? 'Saving...'.tr
                  : 'Save'.tr,
              b22OnTapLhry: b22ControllerDidc.b22OnSavePressedJvet,
              b22ColorDnow: const Color(0xff970000),
            ),
          ),
      ],
    ),
  );
  Widget b22BuildActionButtonUksy({
    required String b22TextZzfg,
    required VoidCallback b22OnTapLhry,
    required Color b22ColorDnow,
  }) => B22TouchGuardComponentKong(
    b22OnPressedXvbd: b22OnTapLhry,
    b22ChildWksr: Container(
      height: 44.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: b22ColorDnow,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: B22TranslatedLabelComponentJklc(
        b22TextZzfg,
        b22FontSizeIafw: 16.sp,
        b22ColorZcbj: Colors.white,
        b22FontWeightPcyy: FontWeight.bold,
        b22FontTypeQdme: B22FontKindGnzs.b22MediumElwt,
      ),
    ),
  );
  Widget b22BuildTitleBarWnmi(
    B22TextDocumentReaderCoordinatorXnjj b22ControllerEjzm,
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
              b22OnPressedXvbd: b22ControllerEjzm.b22OnBackPressedDpbg,
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
                  b22ControllerEjzm.fileName,
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
