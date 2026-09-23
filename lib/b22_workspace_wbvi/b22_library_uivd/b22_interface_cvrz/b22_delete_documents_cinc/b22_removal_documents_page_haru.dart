import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_delete_documents_cinc/b22_removal_documents_coordinator_sgyk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_safe_area_inset_component_yugr.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class B22RemovalDocumentsPageFvnv
    extends B22FoundationPageNhfc<B22RemovalDocumentsCoordinatorWqnn> {
  const B22RemovalDocumentsPageFvnv({super.key});

  @override
  B22RemovalDocumentsCoordinatorWqnn createController() {
    return B22RemovalDocumentsCoordinatorWqnn();
  }

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  Widget buildContent(
    BuildContext context,
    B22RemovalDocumentsCoordinatorWqnn b22ControllerIqvm,
  ) {
    return GetBuilder<B22RemovalDocumentsCoordinatorWqnn>(
      init: b22ControllerIqvm,
      builder: (b22ControllerIixp) => Column(
        children: [
          b22BuildTitleSectionOtkn(b22ControllerIixp),
          b22BuildLanguageListSlth(b22ControllerIixp),
          b22BuildBottomSectionMgdr(b22ControllerIixp),
        ],
      ),
    );
  }

  b22BuildLanguageListSlth(
    B22RemovalDocumentsCoordinatorWqnn b22ControllerMhym,
  ) => Expanded(
    child: Container(
      margin: EdgeInsets.all(12.w),
      child: B22SafeAreaInsetComponentUiga(
        b22ChildVezd: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          itemCount: b22ControllerMhym.b22FilesKjqb.length,
          itemBuilder: (BuildContext context, int b22IndexDfxf) {
            final b22FileHquc = b22ControllerMhym.b22FilesKjqb[b22IndexDfxf];
            return B22TouchGuardComponentKong(
              b22OnPressedXvbd: () {
                b22ControllerMhym.b22OnItemPressedJgqk(b22FileHquc);
              },
              b22ChildWksr: Container(
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
                        B22ResourceImageComponentXjch(
                          b22ControllerMhym.b22ResolveFileIconUnjz(b22FileHquc),
                          b22WidthKbfi: 40.w,
                          b22HeightUsfn: 40.w,
                        ),
                        Spacer(),
                        B22ResourceImageComponentXjch(
                          b22ControllerMhym.b22IsSelectedZzng(b22FileHquc)
                              ? "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_active_rpff"
                              : "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_inactive_yslq",
                          b22WidthKbfi: 28.w,
                          b22HeightUsfn: 28.w,
                        ),
                      ],
                    ),
                    B22TranslatedLabelComponentJklc(
                      b22FileHquc.name ?? '',
                      b22FontSizeIafw: 14.sp,
                      b22ColorZcbj: Color(0xff000000),
                      b22OverflowUwxb: TextOverflow.ellipsis,
                      b22FontTypeQdme: B22FontKindGnzs.black,
                    ),
                    B22TranslatedLabelComponentJklc(
                      b22FormatFileMetadataPemb(b22FileHquc),
                      b22FontSizeIafw: 10.sp,
                      b22ColorZcbj: const Color(0xff5E5E5E),
                      b22OverflowUwxb: TextOverflow.ellipsis,
                      b22FontTypeQdme: B22FontKindGnzs.medium,
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

  Color b22FileBackgroundColorNqae(FileToolsFileInfo b22FileYbrh) =>
      switch (b22FileYbrh.type) {
        FileToolsDocumentType.word => const Color(0xff2C90FE),
        FileToolsDocumentType.excel => const Color(0xff01C87C),
        _ => const Color(0xffF85758),
      };

  String b22FormatFileMetadataPemb(FileToolsFileInfo b22FileAltp) {
    final DateTime b22DateCpvx = DateTime.fromMillisecondsSinceEpoch(
      b22FileAltp.updateTime ?? 0,
    );
    final String b22DateTextUqbi =
        '${b22DateCpvx.year}-${b22DateCpvx.month.toString().padLeft(2, '0')}-${b22DateCpvx.day.toString().padLeft(2, '0')}';
    final double b22SizeUfsq = (b22FileAltp.size ?? 0) / 1024 / 1024;
    return '$b22DateTextUqbi｜${b22SizeUfsq.toStringAsFixed(1)}M';
  }

  b22BuildBottomSectionMgdr(
    B22RemovalDocumentsCoordinatorWqnn b22ControllerQokw,
  ) => Container(
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
    child: B22TouchGuardComponentKong(
      b22OnPressedXvbd: () {
        b22ControllerQokw.b22OnDeletePressedVanr();
      },
      b22ChildWksr: Container(
        width: double.infinity,
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: b22ControllerQokw.b22SelectedPathsWufp.isEmpty
              ? const Color(0xff5E5E5E)
              : const Color(0xffC40000),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            B22ResourceImageComponentXjch(
              "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_delete_action_ghsa",
              b22WidthKbfi: 18.w,
              b22HeightUsfn: 18.w,
            ),
            SizedBox(width: 8.w),
            B22TranslatedLabelComponentJklc(
              'b22_delete_xejt'.tr,
              b22FontSizeIafw: 16.sp,
              b22ColorZcbj: Colors.white,
              b22FontWeightPcyy: FontWeight.bold,
              b22FontTypeQdme: B22FontKindGnzs.black,
            ),
          ],
        ),
      ),
    ),
  );

  b22BuildTitleSectionOtkn(
    B22RemovalDocumentsCoordinatorWqnn b22ControllerQdub,
  ) => Container(
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
            B22TouchGuardComponentKong(
              b22OnPressedXvbd: b22ControllerQdub.b22OnSelectAllPressedKxvd,
              b22ChildWksr: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  B22ResourceImageComponentXjch(
                    b22ControllerQdub.allSelected
                        ? "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_active_rpff"
                        : "b22_shared_controls_ybsz/b22_common_actions_lskr/b22_choice_inactive_yslq",
                    b22WidthKbfi: 28.w,
                    b22HeightUsfn: 28.w,
                  ),
                  B22TranslatedLabelComponentJklc(
                    'b22_select_all_gjow'.tr,
                    b22FontSizeIafw: 12.sp,
                    b22ColorZcbj: Color(0xff970000),
                    b22FontTypeQdme: B22FontKindGnzs.medium,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: B22TranslatedLabelComponentJklc(
                'b22_n_selected_fuvl'.tr.replaceAll(
                  '{n}',
                  b22ControllerQdub.b22SelectedPathsWufp.length.toString(),
                ),
                b22FontSizeIafw: 16.sp,
                b22ColorZcbj: Color(0xff1A1D22),
                b22FontWeightPcyy: FontWeight.bold,
                b22FontTypeQdme: B22FontKindGnzs.black,
              ),
            ),
            SizedBox(width: 12.w),
            B22TouchGuardComponentKong(
              b22OnPressedXvbd: () {
                B22ApplicationRouterJfva.b22BackWithExitAdBkvf<void>();
              },
              b22ChildWksr: B22TranslatedLabelComponentJklc(
                'b22_cancel_mdzi'.tr,
                b22FontSizeIafw: 12.sp,
                b22ColorZcbj: Color(0xff5E5E5E),
                b22FontWeightPcyy: FontWeight.w500,
                b22FontTypeQdme: B22FontKindGnzs.medium,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
