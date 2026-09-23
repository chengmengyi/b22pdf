import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_operations_xopv/b22_first_run_director_xcwj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:app_settings/app_settings.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class B22AlertAccessCoordinatorVaez extends B22FoundationCoordinatorXsba {
  bool b22WaitingSettingsLwlv = false;
  bool b22EnteredBackgroundAguk = false;
  bool b22CheckingPermissionRxto = false;

  @override
  void onInit() {
    super.onInit();
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22PushGuideViewNzyw,
      b22ParametersErwm: {"show_type": "secondary"},
    );
  }

  Future<void> b22OnUpdatePressedAsvc() async {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22PushGuideClickXcde,
      b22ParametersErwm: {"state": "turn_on"},
    );
    b22WaitingSettingsLwlv = true;
    b22EnteredBackgroundAguk = false;
    await AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  void b22OnLaterPressedGjhp() {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22PushGuideClickXcde,
      b22ParametersErwm: {"state": "later"},
    );
    b22ToNextPageHifj();
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  void onAppEvent(B22ApplicationSignalXfvp b22EventDurs) {
    if (b22EventDurs.b22TypeIafj !=
            B22ApplicationSignalKindJiwh.b22AppLifecycleZpzc ||
        !b22WaitingSettingsLwlv) {
      return;
    }

    if (b22EventDurs.b22IntValueVddo == 1) {
      b22EnteredBackgroundAguk = true;
      return;
    }

    if (b22EventDurs.b22IntValueVddo == 0 &&
        b22EnteredBackgroundAguk &&
        !b22CheckingPermissionRxto) {
      b22CheckNotificationPermissionLssp();
    }
  }

  Future<void> b22CheckNotificationPermissionLssp() async {
    b22CheckingPermissionRxto = true;
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final PermissionStatus b22PermissionStatusDarn =
        await Permission.notification.status;
    final bool b22PermissionGrantedRmpd =
        b22PermissionStatusDarn.isGranted || b22PermissionStatusDarn.isLimited;

    b22WaitingSettingsLwlv = false;
    b22EnteredBackgroundAguk = false;
    b22CheckingPermissionRxto = false;
    if (b22PermissionGrantedRmpd) {
      b22ToNextPageHifj();
    }
  }

  b22ToNextPageHifj() {
    var b22FromHomeRlwt =
        B22ApplicationRouterJfva.b22RouteArgumentsFahs()["fromHome"] ?? false;
    if (b22FromHomeRlwt) {
      B22ApplicationRouterJfva.b22BackCwkm();
    } else {
      B22FirstRunDirectorYxjn.instance.b22OpenHomeSzxy();
    }
  }
}
