import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_operations_xopv/b22_first_run_director_xcwj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:get/get.dart';

class B22FloatingLayerAccessCoordinatorNjpi
    extends B22FoundationCoordinatorXsba {
  bool b22PermissionRequestRunningJsor = false;

  @override
  void onInit() {
    super.onInit();
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.float_page_view,
    );
  }

  Future<void> b22OnContinuePressedEdsa() async {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.float_page_click,
      b22ParametersErwm: {"button": "open"},
    );
    if (b22PermissionRequestRunningJsor) {
      return;
    }
    b22PermissionRequestRunningJsor = true;
    try {
      final bool b22HasPermissionPlmg = await FlutterBoomNotificationPlugins
          .instance
          .checkOverlayPermission();
      if (b22HasPermissionPlmg) {
        b22OpenNotificationPermissionScreenDzbs();
        return;
      }
      final bool b22PermissionGrantedUsta = await FlutterBoomNotificationPlugins
          .instance
          .requestOverlayPermission(
            title: 'b22_almost_there_unlock_your_full_xhhm'.tr,
            desc: 'b22_find_n_below_and_toggle_jhdc'.tr,
            overlayPermissionGuideLayout:
                'b22_overlay_permission_guide_layout_rpfa',
          );
      if (b22PermissionGrantedUsta) {
        B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
            .b22ShowProgressOverlayIcnd();
        b22OpenNotificationPermissionScreenDzbs();
      }
    } finally {
      b22PermissionRequestRunningJsor = false;
    }
  }

  void b22OnLaterPressedZntd() {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.float_page_click,
      b22ParametersErwm: {"button": "later"},
    );
    b22OpenNotificationPermissionScreenDzbs();
  }

  void b22OpenNotificationPermissionScreenDzbs() {
    B22FirstRunDirectorYxjn.instance.b22OpenLanguageSelectionClql();
  }
}
