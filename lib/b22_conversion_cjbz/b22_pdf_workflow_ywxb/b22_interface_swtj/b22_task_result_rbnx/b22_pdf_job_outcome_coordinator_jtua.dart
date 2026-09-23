import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:get/get.dart';

class B22PdfJobOutcomeCoordinatorUwje extends B22FoundationCoordinatorXsba {
  final FileToolsFileInfo b22FileInfoQdxx =
      Get.arguments['fileInfo'] as FileToolsFileInfo;

  String get fileName {
    final String b22NameOxyk = b22FileInfoQdxx.name ?? '';
    if (b22NameOxyk.isNotEmpty) return b22NameOxyk;
    return (b22FileInfoQdxx.path ?? '').split(Platform.pathSeparator).last;
  }

  String get fileDetailTime {
    final DateTime b22DateOsjw = DateTime.fromMillisecondsSinceEpoch(
      b22FileInfoQdxx.updateTime ?? DateTime.now().millisecondsSinceEpoch,
    );
    final String b22DateTextZzmh =
        '${b22DateOsjw.year}-${b22DateOsjw.month.toString().padLeft(2, '0')}-${b22DateOsjw.day.toString().padLeft(2, '0')}';
    return '$b22DateTextZzmh';
  }

  String get fileDetailSize {
    final double b22SizeJsyb = (b22FileInfoQdxx.size ?? 0) / 1024 / 1024;
    return '${b22SizeJsyb.toStringAsFixed(1)}M';
  }

  void b22OnBackPressedAzjw() =>
      B22ApplicationRouterJfva.b22BackWithExitAdBkvf<void>();

  void b22OnOpenPressedNzlh() {
    B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
      b22RouteNameSrbn: B22ApplicationDestinationsMcbk.b22PreviewPdfRouteLumo,
      b22ArgumentsUsdn: <String, dynamic>{'file': b22FileInfoQdxx},
    );
  }
}
