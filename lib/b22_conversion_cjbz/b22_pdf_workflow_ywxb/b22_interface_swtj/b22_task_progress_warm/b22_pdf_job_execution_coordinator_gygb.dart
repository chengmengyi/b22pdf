import 'dart:async';
import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_overlay_permission_dajf/b22_floating_layer_access_nudge_sjxl.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:get/get.dart';

class B22PdfJobExecutionCoordinatorDyvo extends B22FoundationCoordinatorXsba {
  final List<String> b22ImagePathsQxot = List<String>.from(
    (Get.arguments?['imag'] as List?)?.whereType<String>() ?? const <String>[],
  );
  double b22ProgressTana = 0;
  bool b22GeneratingIefl = false;

  int get processedCount {
    if (b22ImagePathsQxot.isEmpty) return 0;
    return (b22ProgressTana * b22ImagePathsQxot.length).ceil().clamp(
      0,
      b22ImagePathsQxot.length,
    );
  }

  int get progressPercent => (b22ProgressTana * 100).round();

  void b22OnBackPressedCelg() => B22ApplicationRouterJfva.b22BackCwkm();

  @override
  void onReady() {
    super.onReady();
    unawaited(b22CheckOverlayPermissionAndGeneratePdfNqhw());
  }

  Future<void> b22CheckOverlayPermissionAndGeneratePdfNqhw() async {
    if (b22ImagePathsQxot.isEmpty) return;
    if (await B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
        .b22HasOverlayPermissionBaud()) {
      await b22GeneratePdfLabo();
      return;
    }
    await B22ApplicationRouterJfva.b22ShowBottomSheetLzuf<void>(
      b22DismissibleUnqq: false,
      b22ChildBzzg: B22FloatingLayerAccessNudgeMeau(
        b22OnSettingsCompleteFwnq: b22GeneratePdfLabo,
        b22OnLaterMnlt: b22GeneratePdfLabo,
      ),
    );
  }

  Future<void> b22GeneratePdfLabo() async {
    if (b22GeneratingIefl || b22ImagePathsQxot.isEmpty) return;
    b22GeneratingIefl = true;
    await B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
        .b22ShowProgressOverlayIcnd();
    try {
      final List<FileToolsFileInfo> b22ImagesPbjr = <FileToolsFileInfo>[];
      for (final String b22PathRtfb in b22ImagePathsQxot) {
        final File b22FileSwmx = File(b22PathRtfb);
        final FileStat b22StatAlih = await b22FileSwmx.stat();
        b22ImagesPbjr.add(
          FileToolsFileInfo(
            name: b22PathRtfb.split(Platform.pathSeparator).last,
            path: b22PathRtfb,
            size: b22StatAlih.size,
            updateTime: b22StatAlih.modified.millisecondsSinceEpoch,
          ),
        );
      }
      final FileToolsFileInfo b22ResultQniv =
          await FlutterPreviewFile.generatePdfFromImages(
            imageList: b22ImagesPbjr,
            onProgress: (double b22ValueTgul) {
              if (isClosed) return;
              b22ProgressTana = b22ValueTgul.clamp(0, 1);
              unawaited(
                B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
                    .b22UpdateProgressOverlayIbax(
                      b22ProgressUhui: b22ProgressTana,
                    ),
              );
              update();
            },
          );
      if (isClosed) return;
      b22ProgressTana = 1;
      unawaited(
        B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
            .b22UpdateProgressOverlayIbax(b22ProgressUhui: b22ProgressTana),
      );
      update();
      B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
        b22RouteNameSrbn:
            B22ApplicationDestinationsMcbk.b22ProcessResultRouteAjen,
        b22ArgumentsUsdn: <String, dynamic>{'fileInfo': b22ResultQniv},
      );
    } catch (b22ErrorVcyt) {
      if (isClosed ||
          b22ErrorVcyt.toString().contains('generate_pdf_replaced')) {
        return;
      }
      rethrow;
    } finally {
      if (!isClosed) {
        b22GeneratingIefl = false;
      }
    }
  }
}
