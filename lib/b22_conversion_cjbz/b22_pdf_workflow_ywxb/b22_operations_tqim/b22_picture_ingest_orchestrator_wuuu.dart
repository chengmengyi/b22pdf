import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_permissions_fems/b22_access_orchestrator_hlvl.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_conversion_cjbz/b22_pdf_workflow_ywxb/b22_interface_swtj/b22_image_selection_wxeq/b22_picture_chooser_coordinator_sjia.dart';
import 'package:doc_scan_flutter/doc_scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final class B22PictureIngestOrchestratorIybt {
  B22PictureIngestOrchestratorIybt._();

  static final B22PictureIngestOrchestratorIybt b22InstancePyok =
      B22PictureIngestOrchestratorIybt._();

  Future<List<String>> b22ScanDocumentsNogs({
    bool b22OpenResultKhoq = true,
  }) async {
    if (b22OpenResultKhoq) {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.tool_scan,
      );
    }
    if (!await Permission.camera.isGranted) {
      final B22AccessOutcomeGgzz b22PermissionResultBcxm =
          await B22AccessOrchestratorRwgw.b22InstanceWzjp
              .b22RequestPermissionVmnw(b22PermissionUlwh: Permission.camera);
      if (!b22PermissionResultBcxm.b22IsGrantedPfwf) {
        return const <String>[];
      }
    }

    final List<String>? b22ScanPathListPxjx = await DocumentScanner.scan(
      format: DocScanFormat.jpeg,
    );
    final List<String> b22PathsIsgq = b22FilterValidImagePathsPjiw(
      b22ScanPathListPxjx,
    );
    if (b22OpenResultKhoq) {
      b22OpenImageSelectionTihs(
        b22PathsIsgq,
        B22PictureInputOriginVwda.scan,
      );
    }
    return b22PathsIsgq;
  }

  Future<List<String>> b22PickImagesNwpc({
    bool b22OpenResultBhrs = true,
  }) async {
    if (b22OpenResultBhrs) {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.tool_image_to_pdf,
      );
    }
    final List<XFile> b22ImageListWbgx = await ImagePicker().pickMultiImage();
    final List<String> b22PathsGnde = b22FilterValidImagePathsPjiw(
      b22ImageListWbgx.map((XFile b22ImageYqdt) => b22ImageYqdt.path),
    );
    if (b22OpenResultBhrs) {
      b22OpenImageSelectionTihs(
        b22PathsGnde,
        B22PictureInputOriginVwda.choose,
      );
    }
    return b22PathsGnde;
  }

  List<String> b22FilterValidImagePathsPjiw(
    Iterable<String>? b22ImagePathsOibv,
  ) {
    return b22ImagePathsOibv
            ?.where((String b22PathAheo) => b22PathAheo.isNotEmpty)
            .toList(growable: false) ??
        const <String>[];
  }

  void b22OpenImageSelectionTihs(
    List<String> b22ValidPathsWpqq,
    B22PictureInputOriginVwda b22SourceArug,
  ) {
    if (b22ValidPathsWpqq.isEmpty) return;

    B22ApplicationRouterJfva.b22PushNamedWarf<void>(
      b22RouteNameHlpz: B22ApplicationDestinationsMcbk.b22ImagesResultRouteZkhv,
      b22ArgumentsEnwl: <String, dynamic>{
        'imag': b22ValidPathsWpqq,
        'source': b22SourceArug,
      },
    );
  }
}
