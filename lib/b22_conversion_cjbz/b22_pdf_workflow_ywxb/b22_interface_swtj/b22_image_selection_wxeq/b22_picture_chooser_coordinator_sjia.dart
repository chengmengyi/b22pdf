import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_operations_tqim/b22_picture_ingest_orchestrator_wuuu.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_permissions_fems/b22_access_orchestrator_hlvl.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

enum B22PictureInputOriginVwda { b22ScanPzjp, b22ChooseUgax }

class B22PictureChooserCoordinatorYvnf extends B22FoundationCoordinatorXsba {
  final List<String> b22ImagePathsVrel = List<String>.from(
    (Get.arguments?['imag'] as List?)?.whereType<String>() ?? const <String>[],
  );
  final B22PictureInputOriginVwda b22SourceDgio =
      Get.arguments?['source'] as B22PictureInputOriginVwda? ??
      B22PictureInputOriginVwda.b22ChooseUgax;
  final PageController b22PageControllerNxbn = PageController();
  final ScrollController b22ThumbnailControllerJumj = ScrollController();
  int b22SelectedIndexAjvl = 0;

  void b22OnBackPressedRbqo() =>
      B22ApplicationRouterJfva.b22BackWithExitAdBkvf<void>();

  void b22SelectImageOqiw(int b22IndexOcig) {
    if (b22IndexOcig < 0 || b22IndexOcig >= b22ImagePathsVrel.length) {
      return;
    }
    b22SelectedIndexAjvl = b22IndexOcig;
    b22PageControllerNxbn.animateToPage(
      b22IndexOcig,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
    );
    b22ScrollThumbnailJrqf();
    update();
  }

  void b22OnPageChangedIljj(int b22IndexDlia) {
    b22SelectedIndexAjvl = b22IndexDlia;
    b22ScrollThumbnailJrqf();
    update();
  }

  void b22ShowPreviousPageJgkn() =>
      b22SelectImageOqiw(b22SelectedIndexAjvl - 1);

  void b22ShowNextPageSscg() => b22SelectImageOqiw(b22SelectedIndexAjvl + 1);

  Future<void> b22OnReplacePressedQrex() async {
    final List<String> b22NewPathsOgfy = await b22PickImagesEhzf();
    if (b22NewPathsOgfy.isEmpty || b22ImagePathsVrel.isEmpty) return;
    b22ImagePathsVrel[b22SelectedIndexAjvl] = b22NewPathsOgfy.first;
    update();
  }

  Future<void> b22OnAddPressedIkhb() async {
    final List<String> b22NewPathsEfuz = await b22PickImagesEhzf();
    if (b22NewPathsEfuz.isEmpty) return;
    b22ImagePathsVrel.addAll(b22NewPathsEfuz);
    update();
  }

  Future<List<String>> b22PickImagesEhzf() {
    return switch (b22SourceDgio) {
      B22PictureInputOriginVwda.b22ScanPzjp =>
        B22PictureIngestOrchestratorIybt.b22InstancePyok.b22ScanDocumentsNogs(
          b22OpenResultKhoq: false,
        ),
      B22PictureInputOriginVwda.b22ChooseUgax =>
        B22PictureIngestOrchestratorIybt.b22InstancePyok.b22PickImagesNwpc(
          b22OpenResultBhrs: false,
        ),
    };
  }

  Future<void> b22OnSavePressedUysx() async {
    if (b22ImagePathsVrel.isEmpty) return;
    if (b22ImagePathsVrel.length > 100) {
      Fluttertoast.showToast(msg: 'Max 100 images allowed'.tr);
      return;
    }
    final Permission b22PermissionCxro =
        await b22ResolveRequiredStoragePermissionRjsl();
    final B22AccessOutcomeGgzz b22ResultWfiz = await B22AccessOrchestratorRwgw
        .b22InstanceWzjp
        .b22RequestPermissionVmnw(b22PermissionUlwh: b22PermissionCxro);
    if (!b22ResultWfiz.b22IsGrantedPfwf) return;
    B22ApplicationRouterJfva.b22PushNamedWarf<void>(
      b22RouteNameHlpz:
          B22ApplicationDestinationsMcbk.b22ProcessWaitingRouteGtfb,
      b22ArgumentsEnwl: <String, dynamic>{
        'imag': List<String>.from(b22ImagePathsVrel),
        'source': b22SourceDgio,
      },
    );
  }

  Future<Permission> b22ResolveRequiredStoragePermissionRjsl() async {
    if (!Platform.isAndroid) return Permission.storage;
    final b22AndroidInfoVwhi = await DeviceInfoPlugin().androidInfo;
    return b22AndroidInfoVwhi.version.sdkInt >= 30
        ? Permission.manageExternalStorage
        : Permission.storage;
  }

  void b22ScrollThumbnailJrqf() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!b22ThumbnailControllerJumj.hasClients) return;
      final double b22TargetIbip = (b22SelectedIndexAjvl * 80.0).clamp(
        0,
        b22ThumbnailControllerJumj.position.maxScrollExtent,
      );
      b22ThumbnailControllerJumj.animateTo(
        b22TargetIbip,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    b22PageControllerNxbn.dispose();
    b22ThumbnailControllerJumj.dispose();
    super.onClose();
  }
}
