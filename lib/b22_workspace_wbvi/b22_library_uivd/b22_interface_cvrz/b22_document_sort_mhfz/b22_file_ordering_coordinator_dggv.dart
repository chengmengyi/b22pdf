import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';

enum B22OrderingKindDybz {
  b22DateNewWyvg('b22_sort_date_wqme', 'b22_sort_newest_first_jgka'),
  b22DateOldSaca('b22_sort_date_wqme', 'b22_sort_oldest_first_pcuv'),
  b22NameAZQwad('b22_sort_name_xnrv', 'b22_sort_ascending_bhxe'),
  b22NameZAIywj('b22_sort_name_xnrv', 'b22_sort_descending_lmqo');

  final String b22TextLvaa;
  final String b22DescBgjc;
  const B22OrderingKindDybz(this.b22TextLvaa, this.b22DescBgjc);
}

class B22FileOrderingCoordinatorBgjb extends B22FoundationCoordinatorXsba {
  final B22OrderingKindDybz b22SelectedTypeOxra;
  B22FileOrderingCoordinatorBgjb({required this.b22SelectedTypeOxra});

  void b22OnSortPressedXaig(B22OrderingKindDybz b22TypeMvwf) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22FileSortChangeBxtb,
      b22ParametersErwm: {"sort_type": b22TypeMvwf.name},
    );
    B22ApplicationRouterJfva.b22BackCwkm<B22OrderingKindDybz>(
      b22ResultNvsq: b22TypeMvwf,
    );
  }
}
