import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

enum B22PdfEditKindMfnt {
  b22HighlightWgxm(
    'b22_preview_media_dzro/b22_annotation_controls_kigz/b22_highlight_tool_aleh',
    "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_highlight_tool_sel_byjk",
  ),
  b22UnderlineDsti(
    'b22_preview_media_dzro/b22_annotation_controls_kigz/b22_underline_tool_ieef',
    "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_underline_tool_sel_evmv",
  ),
  b22StrikeThroughCiuz(
    'b22_preview_media_dzro/b22_annotation_controls_kigz/b22_strikethrough_tool_pqeq',
    "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_strikethrough_tool_sel_ooon",
  ),
  b22PenOmpc(
    'b22_preview_media_dzro/b22_annotation_controls_kigz/b22_freehand_tool_vbbk',
    "b22_preview_media_dzro/b22_annotation_controls_kigz/b22_freehand_tool_sel_ound",
  );

  final String b22IconUnsQcbz;
  final String b22IconSelFwmy;
  const B22PdfEditKindMfnt(this.b22IconUnsQcbz, this.b22IconSelFwmy);
}

class B22FeaturePdfStrokeEtrl {
  final int b22PageNumberXnut;
  final List<Offset> b22PointsNjue;
  final Color b22ColorZqbq;
  final double b22WidthRsdx;
  const B22FeaturePdfStrokeEtrl({
    required this.b22PageNumberXnut,
    required this.b22PointsNjue,
    required this.b22ColorZqbq,
    required this.b22WidthRsdx,
  });
}

class B22PdfReaderPageCoordinatorIiyu extends B22FoundationCoordinatorXsba {
  final FileToolsFileInfo b22FileInfoOqvs =
      Get.arguments['file'] as FileToolsFileInfo;
  final GlobalKey<SfPdfViewerState> b22ViewerKeyVyky =
      GlobalKey<SfPdfViewerState>();
  final PdfViewerController b22ViewerControllerWvqa = PdfViewerController();
  final UndoHistoryController b22UndoControllerCwvu = UndoHistoryController();
  final Map<int, Uint8List?> b22ThumbnailsWgcc = <int, Uint8List?>{};
  final Map<int, Size> b22PageSizesEjgs = <int, Size>{};
  final List<B22FeaturePdfStrokeEtrl> b22PenStrokesGztj =
      <B22FeaturePdfStrokeEtrl>[];
  final List<B22FeaturePdfStrokeEtrl> b22RedoStrokesSjuz =
      <B22FeaturePdfStrokeEtrl>[];
  List<Offset> b22DraftPointsWhrf = <Offset>[];
  B22PdfEditKindMfnt? b22SelectedTypeFzcz;
  bool b22CanLoadViewerSnhe = false;
  bool b22DocumentLoadedCxey = false;
  bool b22SavingIjsl = false;
  bool b22PenPanelVisibleKmue = false;
  bool b22HasTextSelectionFxjg = false;
  bool b22IsExitingYhls = false;
  DateTime? b22SelectionDismissedAtXiju;
  int b22PageCountRjgk = 0;
  int b22CurrentPageZogt = 1;
  Color b22PenColorGofe = const Color(0xff067BF2);
  double b22PenWidthYgkl = 8;
  Timer? b22PenPanelTimerCytr;
  final List<Color> b22PenColorsOsbg = const [
    Color(0xffF4411F),
    Color(0xff1A1D22),
    Color(0xff067BF2),
    Color(0xff23A55A),
    Color(0xffF4C542),
  ];

  String get fileName {
    if ((b22FileInfoOqvs.name ?? '').isNotEmpty) {
      return b22FileInfoOqvs.name!;
    }
    return (b22FileInfoOqvs.path ?? '').split(Platform.pathSeparator).last;
  }

  bool get penMode => b22SelectedTypeFzcz == B22PdfEditKindMfnt.b22PenOmpc;

  @override
  void onInit() {
    super.onInit();
    b22UndoControllerCwvu.addListener(b22OnViewerStateChangedOiha);
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 120));
      b22CanLoadViewerSnhe = true;
      update();
    });
  }

  void b22OnViewerStateChangedOiha() => update();
  void b22OnDocumentLoadedHsuj(PdfDocumentLoadedDetails b22DetailsPwml) {
    b22DocumentLoadedCxey = true;
    b22PageCountRjgk = b22DetailsPwml.document.pages.count;
    b22PageSizesEjgs.clear();
    for (
      var b22IndexWfyl = 0;
      b22IndexWfyl < b22PageCountRjgk;
      b22IndexWfyl++
    ) {
      b22PageSizesEjgs[b22IndexWfyl + 1] =
          b22DetailsPwml.document.pages[b22IndexWfyl].size;
    }
    update();
    b22LoadThumbnailsGwlm();
  }

  void b22OnPageChangedWapa(PdfPageChangedDetails b22DetailsLyfx) {
    b22CurrentPageZogt = b22DetailsLyfx.newPageNumber;
    update();
  }

  void b22OnTextSelectionChangedCynl(
    PdfTextSelectionChangedDetails b22DetailsVykv,
  ) {
    final b22HasSelectionWfga = b22DetailsVykv.selectedText?.isNotEmpty == true;
    if (b22HasTextSelectionFxjg && !b22HasSelectionWfga) {
      b22SelectionDismissedAtXiju = DateTime.now();
    }
    b22HasTextSelectionFxjg = b22HasSelectionWfga;
  }

  void b22OnAnnotationToolSelectedHfci(B22PdfEditKindMfnt b22TypeCcth) {
    if (b22TypeCcth == B22PdfEditKindMfnt.b22PenOmpc) {
      b22OnPenPressedAevq();
      return;
    }
    b22HidePenSettingsUqly();
    b22DraftPointsWhrf = <Offset>[];
    final b22SelectedLinesOrha =
        b22ViewerKeyVyky.currentState?.getSelectedTextLines() ??
        <PdfTextLine>[];
    b22SelectedTypeFzcz = b22TypeCcth;
    b22ViewerControllerWvqa.annotationMode = PdfAnnotationMode.none;
    if (b22SelectedLinesOrha.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select text first'.tr);
      update();
      return;
    }
    final Annotation b22AnnotationPien = switch (b22TypeCcth) {
      B22PdfEditKindMfnt.b22HighlightWgxm => HighlightAnnotation(
        textBoundsCollection: b22SelectedLinesOrha,
      ),
      B22PdfEditKindMfnt.b22UnderlineDsti => UnderlineAnnotation(
        textBoundsCollection: b22SelectedLinesOrha,
      ),
      B22PdfEditKindMfnt.b22StrikeThroughCiuz => StrikethroughAnnotation(
        textBoundsCollection: b22SelectedLinesOrha,
      ),
      _ => throw StateError('Unsupported text annotation type'),
    };
    b22ViewerControllerWvqa.addAnnotation(b22AnnotationPien);
    update();
  }

  void b22OnPenPressedAevq() {
    if (!b22DocumentLoadedCxey || b22SavingIjsl) return;
    final b22EnablePenKlnb = !penMode;
    b22SelectedTypeFzcz = b22EnablePenKlnb
        ? B22PdfEditKindMfnt.b22PenOmpc
        : null;
    b22DraftPointsWhrf = <Offset>[];
    b22ViewerControllerWvqa.annotationMode = PdfAnnotationMode.none;
    b22ViewerControllerWvqa.clearSelection();
    if (b22EnablePenKlnb) {
      b22ShowPenSettingsLgci();
    } else {
      b22HidePenSettingsUqly();
    }
    update();
  }

  void b22ShowPenSettingsLgci() {
    b22PenPanelTimerCytr?.cancel();
    b22PenPanelVisibleKmue = true;
    update();
    b22PenPanelTimerCytr = Timer(const Duration(seconds: 3), () {
      b22PenPanelVisibleKmue = false;
      update();
    });
  }

  void b22HidePenSettingsUqly() {
    b22PenPanelTimerCytr?.cancel();
    b22PenPanelTimerCytr = null;
    b22PenPanelVisibleKmue = false;
  }

  void b22SelectPenColorKgwp(Color b22ColorNhkx) {
    b22PenColorGofe = b22ColorNhkx;
    b22ShowPenSettingsLgci();
  }

  void b22SelectPenWidthKkmd(double b22WidthMwbr) {
    b22PenWidthYgkl = b22WidthMwbr;
    b22ShowPenSettingsLgci();
  }

  void b22NavigateToPageEpnh(int b22PageNumberIjyo) {
    if (b22PageNumberIjyo < 1 || b22PageNumberIjyo > b22PageCountRjgk) return;
    b22ViewerControllerWvqa.jumpToPage(b22PageNumberIjyo);
    b22CurrentPageZogt = b22PageNumberIjyo;
    update();
  }

  void b22ShowPreviousPageDmqu() =>
      b22NavigateToPageEpnh(b22CurrentPageZogt - 1);

  void b22ShowNextPageYidz() => b22NavigateToPageEpnh(b22CurrentPageZogt + 1);

  void b22BeginPenStrokePinn(Offset b22PointAkhc) {
    if (!penMode || b22SavingIjsl) return;
    b22DraftPointsWhrf = <Offset>[b22PointAkhc];
    update();
  }

  void b22ExtendPenStrokeMffc(Offset b22PointXqpd) {
    if (b22DraftPointsWhrf.isEmpty || !penMode) return;
    b22DraftPointsWhrf.add(b22PointXqpd);
    update();
  }

  void b22FinishPenStrokeZclk() {
    if (b22DraftPointsWhrf.isEmpty) return;
    b22PenStrokesGztj.add(
      B22FeaturePdfStrokeEtrl(
        b22PageNumberXnut: b22CurrentPageZogt,
        b22PointsNjue: List<Offset>.from(b22DraftPointsWhrf),
        b22ColorZqbq: b22PenColorGofe,
        b22WidthRsdx: b22PenWidthYgkl,
      ),
    );
    b22RedoStrokesSjuz.clear();
    b22DraftPointsWhrf = <Offset>[];
    update();
  }

  void b22OnUndoPressedOxis() {
    if (b22PenStrokesGztj.isNotEmpty) {
      b22RedoStrokesSjuz.add(b22PenStrokesGztj.removeLast());
    } else {
      b22UndoControllerCwvu.undo();
    }
    update();
  }

  void b22OnRedoPressedBttf() {
    if (b22RedoStrokesSjuz.isNotEmpty) {
      b22PenStrokesGztj.add(b22RedoStrokesSjuz.removeLast());
    } else {
      b22UndoControllerCwvu.redo();
    }
    update();
  }

  Future<void> b22OnSavePressedGddb() async {
    if (!b22DocumentLoadedCxey || b22SavingIjsl) return;
    b22SavingIjsl = true;
    update();
    try {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.b22EditorSaveClickQazi,
      );
      List<int> b22BytesUlfi = await b22ViewerControllerWvqa.saveDocument();
      if (b22PenStrokesGztj.isNotEmpty) {
        final b22DocumentSiya = PdfDocument(inputBytes: b22BytesUlfi);
        for (final b22StrokeCgez in b22PenStrokesGztj) {
          if (b22StrokeCgez.b22PageNumberXnut > b22DocumentSiya.pages.count) {
            continue;
          }
          final dynamic b22PageSkrn =
              b22DocumentSiya.pages[b22StrokeCgez.b22PageNumberXnut - 1];
          final Size b22SizeWdsj = b22PageSkrn.size as Size;
          final b22PathXxmu = PdfPath();
          for (
            var b22IndexOwli = 1;
            b22IndexOwli < b22StrokeCgez.b22PointsNjue.length;
            b22IndexOwli++
          ) {
            final b22FromEzkb = b22StrokeCgez.b22PointsNjue[b22IndexOwli - 1];
            final b22ToNgvc = b22StrokeCgez.b22PointsNjue[b22IndexOwli];
            b22PathXxmu.addLine(
              Offset(
                b22FromEzkb.dx * b22SizeWdsj.width,
                b22FromEzkb.dy * b22SizeWdsj.height,
              ),
              Offset(
                b22ToNgvc.dx * b22SizeWdsj.width,
                b22ToNgvc.dy * b22SizeWdsj.height,
              ),
            );
          }
          b22PageSkrn.graphics.drawPath(
            b22PathXxmu,
            pen: PdfPen(
              PdfColor(
                (b22StrokeCgez.b22ColorZqbq.r * 255).round(),
                (b22StrokeCgez.b22ColorZqbq.g * 255).round(),
                (b22StrokeCgez.b22ColorZqbq.b * 255).round(),
              ),
              width: (b22StrokeCgez.b22WidthRsdx / 800) * b22SizeWdsj.width,
            ),
          );
        }
        b22BytesUlfi = await b22DocumentSiya.save();
        b22DocumentSiya.dispose();
      }
      await File(b22FileInfoOqvs.path!).writeAsBytes(b22BytesUlfi, flush: true);
      b22PenStrokesGztj.clear();
      b22RedoStrokesSjuz.clear();
      Fluttertoast.showToast(msg: 'Saved successfully'.tr);
    } catch (b22ErrorDsbo) {
      Fluttertoast.showToast(msg: '$b22ErrorDsbo');
    } finally {
      b22SavingIjsl = false;
      update();
    }
  }

  Future<void> b22LoadThumbnailsGwlm() async {
    for (var b22PageLunq = 1; b22PageLunq <= b22PageCountRjgk; b22PageLunq++) {
      try {
        b22ThumbnailsWgcc[b22PageLunq] =
            await FlutterPreviewFile.renderPdfPageToImageBytes(
              pdfPath: b22FileInfoOqvs.path!,
              pageIndex: b22PageLunq - 1,
              width: 160,
            );
        update();
      } catch (_) {
        b22ThumbnailsWgcc[b22PageLunq] = null;
      }
    }
  }

  Future<bool> b22OnSystemBackRequestedUmvr() async {
    if (b22IsExitingYhls) return true;
    if (b22HasTextSelectionFxjg) {
      b22ViewerControllerWvqa.clearSelection();
      return false;
    }
    final b22DismissedAtOrxl = b22SelectionDismissedAtXiju;
    if (b22DismissedAtOrxl != null &&
        DateTime.now().difference(b22DismissedAtOrxl) <
            const Duration(milliseconds: 500)) {
      return false;
    }
    b22IsExitingYhls = true;
    b22ShowExitAdIfEligibleBqwf();
    return true;
  }

  void b22OnBackPressedCzcp() {
    if (b22IsExitingYhls) return;
    b22IsExitingYhls = true;
    B22ApplicationRouterJfva.b22BackCwkm();
    b22ShowExitAdIfEligibleBqwf();
  }

  void b22ShowExitAdIfEligibleBqwf() {
    if (B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
        b22AdSceneHfhk: B22PromotionContextSuaj.pr_exit,
        b22AdPosIdEjxk: B22PromotionSlotZwla.pr_readback,
      );
    }
  }

  @override
  void onClose() {
    b22PenPanelTimerCytr?.cancel();
    b22UndoControllerCwvu.removeListener(b22OnViewerStateChangedOiha);
    b22UndoControllerCwvu.dispose();
    b22ViewerControllerWvqa.dispose();
    super.onClose();
  }
}
