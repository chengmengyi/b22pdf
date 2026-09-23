import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:get/get.dart';

class B22FloatingLayerAccessNudgeCoordinatorQkdz
    extends B22FoundationCoordinatorXsba {
  B22FloatingLayerAccessNudgeCoordinatorQkdz({
    required this.b22OnSettingsCompleteIjip,
    required this.b22OnLaterJkla,
  });

  final FutureOr<void> Function() b22OnSettingsCompleteIjip;
  final FutureOr<void> Function() b22OnLaterJkla;
  bool b22HandlingActionQyma = false;

  @override
  void onInit() {
    super.onInit();
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22FloatPopViewTmrg,
    );
  }

  Future<void> b22OpenSettingsDcxa() async {
    if (b22HandlingActionQyma) return;
    b22HandlingActionQyma = true;
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22FloatPopClickZcme,
      b22ParametersErwm: <String, dynamic>{'button': 'open'},
    );
    await B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
        .b22RequestOverlayPermissionEvau();
    b22ClosePromptLmha();
    await Future<void>.sync(b22OnSettingsCompleteIjip);
  }

  Future<void> b22ContinueWithoutPermissionQmrd() async {
    if (b22HandlingActionQyma) return;
    b22HandlingActionQyma = true;
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22FloatPopClickZcme,
      b22ParametersErwm: <String, dynamic>{'button': 'later'},
    );
    b22ClosePromptLmha();
    await Future<void>.sync(b22OnLaterJkla);
  }

  void b22ClosePromptLmha() {
    if (Get.isBottomSheetOpen == true) {
      B22ApplicationRouterJfva.b22BackCwkm<void>();
    }
  }
}
