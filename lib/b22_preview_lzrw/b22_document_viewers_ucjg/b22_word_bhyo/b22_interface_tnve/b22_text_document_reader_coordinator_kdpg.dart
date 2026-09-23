import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class B22TextDocumentReaderCoordinatorXnjj
    extends B22FoundationCoordinatorXsba {
  late final WordFileController b22WordControllerWnao;
  FileToolsFileInfo b22FileInfoSlga =
      Get.arguments['file'] as FileToolsFileInfo;
  bool b22CanLoadViewerZyas = false;

  String get fileName {
    if ((b22FileInfoSlga.name ?? '').isNotEmpty) {
      return b22FileInfoSlga.name!;
    }
    return (b22FileInfoSlga.path ?? '').split(Platform.pathSeparator).last;
  }

  bool get isEditing => b22WordControllerWnao.isEditing;
  bool get isSaving => b22WordControllerWnao.saving;

  @override
  void onInit() {
    super.onInit();
    b22WordControllerWnao = WordFileController(
      filePath: b22FileInfoSlga.path ?? '',
    );
    b22WordControllerWnao.addListener(b22OnViewerStateChangedMltw);
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 160));
      b22CanLoadViewerZyas = true;
      update();
      await b22WordControllerWnao.initialize();
    });
  }

  void b22OnViewerStateChangedMltw() => update();
  Future<void> b22OnEditPressedBpdn() async {
    if (isSaving) return;
    isEditing
        ? await b22WordControllerWnao.cancelEditing()
        : await b22WordControllerWnao.enterEditMode();
  }

  Future<void> b22OnSavePressedJvet() async {
    if (!isEditing || isSaving) return;
    try {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.editor_save_click,
      );
      await b22WordControllerWnao.save();
      final b22PathVjgh = b22FileInfoSlga.path ?? '';
      final b22StatQpus = await File(b22PathVjgh).stat();
      b22FileInfoSlga = b22FileInfoSlga.copyWith(
        size: b22StatQpus.size,
        updateTime: b22StatQpus.modified.millisecondsSinceEpoch,
      );
      Fluttertoast.showToast(msg: 'b22_saved_successfully_dzom'.tr);
    } catch (b22ErrorIdck) {
      Fluttertoast.showToast(msg: '$b22ErrorIdck');
    }
  }

  void b22OnBackPressedDpbg() {
    B22ApplicationRouterJfva.b22BackCwkm();
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
    b22WordControllerWnao.removeListener(b22OnViewerStateChangedMltw);
    b22WordControllerWnao.dispose();
    super.onClose();
  }
}
