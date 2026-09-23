import 'dart:typed_data';

import 'package:b22_document_workspace_kmzm/b22_preview_lzrw/b22_document_viewers_ucjg/b22_pdf_tlyq/b22_interface_rtpg/b22_pdf_reader_coordinator_liin.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_page_tzjf.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_translated_label_component_yfqz.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_touch_guard_component_nxqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class B22PdfReaderPageFneh
    extends B22FoundationPageNhfc<B22PdfReaderPageCoordinatorIiyu> {
  const B22PdfReaderPageFneh({super.key});
  @override
  B22PdfReaderPageCoordinatorIiyu createController() =>
      B22PdfReaderPageCoordinatorIiyu();

  @override
  Future<bool> canPopRoute(B22PdfReaderPageCoordinatorIiyu b22ControllerUgwq) =>
      b22ControllerUgwq.b22OnSystemBackRequestedUmvr();

  @override
  Color get navigationBarColor => Color(0xffFFFAF6);

  @override
  Widget buildContent(
    BuildContext context,
    B22PdfReaderPageCoordinatorIiyu b22ControllerFsar,
  ) => GetBuilder<B22PdfReaderPageCoordinatorIiyu>(
    init: b22ControllerFsar,
    global: false,
    builder: (b22ControllerKzza) => Column(
      children: [
        b22BuildTitleBarPufx(b22ControllerKzza),
        b22RedoSaveWidgetGhea(b22ControllerKzza),
        b22BuildMainContentWgoh(b22ControllerKzza),
        b22BottomFuncWidgetEpxl(b22ControllerKzza),
      ],
    ),
  );

  Widget b22BuildMainContentWgoh(
    B22PdfReaderPageCoordinatorIiyu b22ControllerFpqw,
  ) => Expanded(
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
      child: !b22ControllerFpqw.b22CanLoadViewerSnhe
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, b22ConstraintsCuhx) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: b22ControllerFpqw.penMode
                    ? (b22DetailsZrhv) =>
                          b22ControllerFpqw.b22BeginPenStrokePinn(
                            b22NormalizeKupv(
                              b22DetailsZrhv.localPosition,
                              b22ConstraintsCuhx.biggest,
                            ),
                          )
                    : null,
                onPanUpdate: b22ControllerFpqw.penMode
                    ? (b22DetailsFkcx) =>
                          b22ControllerFpqw.b22ExtendPenStrokeMffc(
                            b22NormalizeKupv(
                              b22DetailsFkcx.localPosition,
                              b22ConstraintsCuhx.biggest,
                            ),
                          )
                    : null,
                onPanEnd: b22ControllerFpqw.penMode
                    ? (_) => b22ControllerFpqw.b22FinishPenStrokeZclk()
                    : null,
                child: Stack(
                  children: [
                    PdfFileView(
                      filePath: b22ControllerFpqw.b22FileInfoOqvs.path ?? '',
                      viewerKey: b22ControllerFpqw.b22ViewerKeyVyky,
                      controller: b22ControllerFpqw.b22ViewerControllerWvqa,
                      undoController: b22ControllerFpqw.b22UndoControllerCwvu,
                      pageLayoutMode: PdfPageLayoutMode.single,
                      onDocumentLoaded:
                          b22ControllerFpqw.b22OnDocumentLoadedHsuj,
                      onPageChanged: b22ControllerFpqw.b22OnPageChangedWapa,
                      onTextSelectionChanged:
                          b22ControllerFpqw.b22OnTextSelectionChangedCynl,
                      loadingBuilder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      messageBuilder: (_, message) => Center(
                        child: B22TranslatedLabelComponentJklc(
                          'b22_preview_unavailable_dlyi'.tr,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: B22FeaturePdfPenPainterRxpr(
                            b22StrokesEdzl: b22ControllerFpqw.b22PenStrokesGztj
                                .where(
                                  (b22StrokeLesm) =>
                                      b22StrokeLesm.b22PageNumberXnut ==
                                      b22ControllerFpqw.b22CurrentPageZogt,
                                )
                                .toList(),
                            b22DraftPcth: b22ControllerFpqw.b22DraftPointsWhrf,
                            b22DraftColorMifr:
                                b22ControllerFpqw.b22PenColorGofe,
                            b22DraftWidthLegv:
                                b22ControllerFpqw.b22PenWidthYgkl,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: b22PenPanelIfoe(b22ControllerFpqw),
                    ),
                    if (b22ControllerFpqw.b22DocumentLoadedCxey)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: b22PagesWidgetGjjc(b22ControllerFpqw),
                      ),
                  ],
                ),
              ),
            ),
    ),
  );

  Offset b22NormalizeKupv(Offset b22PointLivv, Size b22SizeVnuh) => Offset(
    (b22PointLivv.dx / b22SizeVnuh.width).clamp(0, 1),
    (b22PointLivv.dy / b22SizeVnuh.height).clamp(0, 1),
  );

  b22PagesWidgetGjjc(
    B22PdfReaderPageCoordinatorIiyu b22ControllerVcpg,
  ) => Container(
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
      color: Color(0xffF2E9D9).withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(2.w),
      border: Border.all(width: 1.w, color: Colors.black),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerVcpg.b22CurrentPageZogt > 1
              ? b22ControllerVcpg.b22ShowPreviousPageDmqu
              : null,
          b22ChildWksr: B22ResourceImageComponentXjch(
            "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_previous_page_control_jlfh",
            b22WidthKbfi: 32.w,
            b22HeightUsfn: 32.w,
          ),
        ),
        Container(width: 1.w, height: 16.h, color: Colors.black),
        SizedBox(width: 24.w),
        B22TranslatedLabelComponentJklc(
          "${b22ControllerVcpg.b22PageCountRjgk == 0 ? 0 : b22ControllerVcpg.b22CurrentPageZogt} / ${b22ControllerVcpg.b22PageCountRjgk}",
          b22FontSizeIafw: 14.sp,
          b22ColorZcbj: Colors.black,
          b22FontTypeQdme: B22FontKindGnzs.medium,
        ),
        SizedBox(width: 24.w),
        Container(width: 1.w, height: 16.h, color: Colors.black),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd:
              b22ControllerVcpg.b22CurrentPageZogt <
                  b22ControllerVcpg.b22PageCountRjgk
              ? b22ControllerVcpg.b22ShowNextPageYidz
              : null,
          b22ChildWksr: B22ResourceImageComponentXjch(
            "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_next_page_control_roec",
            b22WidthKbfi: 32.w,
            b22HeightUsfn: 32.w,
          ),
        ),
      ],
    ),
  );

  b22BottomFuncWidgetEpxl(
    B22PdfReaderPageCoordinatorIiyu b22ControllerQocs,
  ) => Container(
    width: double.infinity,
    height: 64.h,
    decoration: BoxDecoration(
      color: Color(0xffFFFAF6),
      border: BoxBorder.fromLTRB(
        top: BorderSide(width: 2.w, color: Colors.black),
      ),
    ),
    child: Row(
      children: B22PdfEditKindMfnt.values.map((b22TypeJqch) {
        final b22SelectedDdpp =
            b22TypeJqch == b22ControllerQocs.b22SelectedTypeFzcz;
        return Expanded(
          child: B22TouchGuardComponentKong(
            b22OnPressedXvbd: () =>
                b22ControllerQocs.b22OnAnnotationToolSelectedHfci(b22TypeJqch),
            b22ChildWksr: Container(
              width: double.infinity,
              height: 64.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: b22SelectedDdpp ? Color(0xff970000) : Color(0xffFFFAF6),
              ),
              child: B22ResourceImageComponentXjch(
                b22SelectedDdpp
                    ? b22TypeJqch.b22IconSelFwmy
                    : b22TypeJqch.b22IconUnsQcbz,
                b22WidthKbfi: 28.w,
                b22HeightUsfn: 28.w,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );

  Widget b22BuildTitleBarPufx(
    B22PdfReaderPageCoordinatorIiyu b22ControllerGchl,
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
              b22OnPressedXvbd: b22ControllerGchl.b22OnBackPressedCzcp,
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
                  b22ControllerGchl.fileName,
                  b22FontSizeIafw: 12.sp,
                  b22ColorZcbj: Colors.black,
                  b22FontWeightPcyy: FontWeight.w500,
                  b22OverflowUwxb: TextOverflow.ellipsis,
                  b22FontTypeQdme: B22FontKindGnzs.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget b22PenPanelIfoe(
    B22PdfReaderPageCoordinatorIiyu b22ControllerShev,
  ) => IgnorePointer(
    ignoring: !b22ControllerShev.b22PenPanelVisibleKmue,
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 260),
      opacity: b22ControllerShev.b22PenPanelVisibleKmue ? 1 : 0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        offset: b22ControllerShev.b22PenPanelVisibleKmue
            ? Offset.zero
            : const Offset(0, 0.12),
        child: Container(
          margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
          padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(color: const Color(0xffE7EAEB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 18.w,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  B22TranslatedLabelComponentJklc(
                    'b22_color_lwjm'.tr,
                    b22FontSizeIafw: 12.sp,
                    b22ColorZcbj: const Color(0xff1A1D22),
                    b22FontWeightPcyy: FontWeight.bold,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: b22ControllerShev.b22PenColorsOsbg
                          .map(
                            (b22ColorVcnq) => B22TouchGuardComponentKong(
                              b22OnPressedXvbd: () => b22ControllerShev
                                  .b22SelectPenColorKgwp(b22ColorVcnq),
                              b22ChildWksr: Container(
                                width: 24.w,
                                height: 24.w,
                                decoration: BoxDecoration(
                                  color: b22ColorVcnq,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width:
                                        b22ColorVcnq ==
                                            b22ControllerShev.b22PenColorGofe
                                        ? 3.w
                                        : 1.w,
                                    color:
                                        b22ColorVcnq ==
                                            b22ControllerShev.b22PenColorGofe
                                        ? const Color(0xff1A1D22)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  B22TranslatedLabelComponentJklc(
                    'b22_width_lskj'.tr,
                    b22FontSizeIafw: 12.sp,
                    b22ColorZcbj: const Color(0xff1A1D22),
                    b22FontWeightPcyy: FontWeight.bold,
                  ),
                  Expanded(
                    child: Slider(
                      value: b22ControllerShev.b22PenWidthYgkl,
                      min: 2,
                      max: 30,
                      activeColor: b22ControllerShev.b22PenColorGofe,
                      onChanged: b22ControllerShev.b22SelectPenWidthKkmd,
                    ),
                  ),
                  SizedBox(
                    width: 26.w,
                    child: B22TranslatedLabelComponentJklc(
                      b22ControllerShev.b22PenWidthYgkl.toStringAsFixed(0),
                      b22FontSizeIafw: 12.sp,
                      b22ColorZcbj: const Color(0xff858C92),
                      b22TextAlignCzod: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

  b22RedoSaveWidgetGhea(
    B22PdfReaderPageCoordinatorIiyu b22ControllerHbbw,
  ) => Container(
    width: double.infinity,
    height: 44.h,
    color: Color(0xffFFFAF6),
    child: Row(
      children: [
        SizedBox(width: 16.w),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerHbbw.b22OnUndoPressedOxis,
          b22ChildWksr: B22ResourceImageComponentXjch(
            'b22_preview_media_dzro/b22_annotation_controls_kigz/b22_undo_mlrr',
            b22WidthKbfi: 28.w,
            b22HeightUsfn: 28.w,
          ),
        ),
        SizedBox(width: 16.w),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerHbbw.b22OnRedoPressedBttf,
          b22ChildWksr: B22ResourceImageComponentXjch(
            'b22_preview_media_dzro/b22_annotation_controls_kigz/b22_redo_rwff',
            b22WidthKbfi: 28.w,
            b22HeightUsfn: 28.w,
          ),
        ),
        const Spacer(),
        B22TouchGuardComponentKong(
          b22OnPressedXvbd: b22ControllerHbbw.b22OnSavePressedGddb,
          b22ChildWksr: Container(
            width: 82.w,
            height: 32.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xff970000),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: B22TranslatedLabelComponentJklc(
              b22ControllerHbbw.b22SavingIjsl
                  ? 'b22_saving_ijrs'.tr
                  : 'b22_save_blpm'.tr,
              b22FontSizeIafw: 12.sp,
              b22ColorZcbj: Colors.white,
              b22FontWeightPcyy: FontWeight.bold,
              b22FontTypeQdme: B22FontKindGnzs.medium,
            ),
          ),
        ),
        SizedBox(width: 16.w),
      ],
    ),
  );
}

class B22FeaturePdfPenPainterRxpr extends CustomPainter {
  final List<B22FeaturePdfStrokeEtrl> b22StrokesEdzl;
  final List<Offset> b22DraftPcth;
  final Color b22DraftColorMifr;
  final double b22DraftWidthLegv;
  const B22FeaturePdfPenPainterRxpr({
    required this.b22StrokesEdzl,
    required this.b22DraftPcth,
    required this.b22DraftColorMifr,
    required this.b22DraftWidthLegv,
  });
  @override
  void paint(Canvas b22CanvasFacf, Size b22SizeTfls) {
    final b22StrokeEntriesXmzm =
        <({List<Offset> points, Color color, double width})>[
          ...b22StrokesEdzl.map(
            (b22ItemYopf) => (
              points: b22ItemYopf.b22PointsNjue,
              color: b22ItemYopf.b22ColorZqbq,
              width: b22ItemYopf.b22WidthRsdx,
            ),
          ),
          (
            points: b22DraftPcth,
            color: b22DraftColorMifr,
            width: b22DraftWidthLegv,
          ),
        ];
    for (final b22EntryTwsr in b22StrokeEntriesXmzm) {
      final b22StrokeSsqq = b22EntryTwsr.points;
      if (b22StrokeSsqq.length < 2) continue;
      final paint = Paint()
        ..color = b22EntryTwsr.color
        ..strokeWidth = b22EntryTwsr.width
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      final b22PathFaly = Path()
        ..moveTo(
          b22StrokeSsqq.first.dx * b22SizeTfls.width,
          b22StrokeSsqq.first.dy * b22SizeTfls.height,
        );
      for (final b22PointRvhl in b22StrokeSsqq.skip(1)) {
        b22PathFaly.lineTo(
          b22PointRvhl.dx * b22SizeTfls.width,
          b22PointRvhl.dy * b22SizeTfls.height,
        );
      }
      b22CanvasFacf.drawPath(b22PathFaly, paint);
    }
  }

  @override
  bool shouldRepaint(covariant B22FeaturePdfPenPainterRxpr oldDelegate) => true;
}
