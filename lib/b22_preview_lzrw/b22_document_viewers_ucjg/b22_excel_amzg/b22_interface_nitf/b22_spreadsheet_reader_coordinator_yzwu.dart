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

class B22SpreadsheetReaderCoordinatorWmkr extends B22FoundationCoordinatorXsba {
  late final ExcelFileController b22ExcelControllerYwlo;
  FileToolsFileInfo b22FileInfoFjvl =
      Get.arguments['file'] as FileToolsFileInfo;
  bool b22CanLoadViewerYksy = false;
  String get fileName {
    if ((b22FileInfoFjvl.name ?? '').isNotEmpty) {
      return b22FileInfoFjvl.name!;
    }
    return (b22FileInfoFjvl.path ?? '').split(Platform.pathSeparator).last;
  }

  bool get isEditing => b22ExcelControllerYwlo.isEditing;
  bool get isSaving => b22ExcelControllerYwlo.saving;
  @override
  void onInit() {
    super.onInit();
    b22ExcelControllerYwlo = ExcelFileController(
      filePath: b22FileInfoFjvl.path ?? '',
    );
    b22ExcelControllerYwlo.addListener(b22OnViewerStateChangedPihx);
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 160));
      b22CanLoadViewerYksy = true;
      update();
      await b22ExcelControllerYwlo.initialize();
    });
  }

  void b22OnViewerStateChangedPihx() => update();
  Future<void> b22OnEditPressedSowt() async {
    if (isSaving) return;
    isEditing
        ? await b22ExcelControllerYwlo.cancelEditing()
        : await b22ExcelControllerYwlo.enterEditMode();
  }

  Future<void> b22OnSavePressedIkfp() async {
    if (!isEditing || isSaving) return;
    try {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.b22EditorSaveClickQazi,
      );
      await b22ExcelControllerYwlo.save();
      final b22PathAqkk = b22FileInfoFjvl.path ?? '';
      final b22StatFddx = await File(b22PathAqkk).stat();
      b22FileInfoFjvl = b22FileInfoFjvl.copyWith(
        size: b22StatFddx.size,
        updateTime: b22StatFddx.modified.millisecondsSinceEpoch,
      );
      Fluttertoast.showToast(msg: 'b22_saved_successfully_dzom'.tr);
    } catch (b22ErrorMarb) {
      Fluttertoast.showToast(msg: '$b22ErrorMarb');
    }
  }

  void b22OnBackPressedFiev() {
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
    b22ExcelControllerYwlo.removeListener(b22OnViewerStateChangedPihx);
    b22ExcelControllerYwlo.dispose();
    super.onClose();
  }
}
