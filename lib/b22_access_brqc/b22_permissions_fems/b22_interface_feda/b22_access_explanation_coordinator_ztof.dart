import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class B22AccessExplanationCoordinatorGnhw extends B22FoundationCoordinatorXsba {
  final Permission b22PermissionBmoh;
  B22AccessExplanationCoordinatorGnhw({required this.b22PermissionBmoh});

  String b22BuildPermissionMessageEmen() {
    if (b22PermissionBmoh == Permission.storage ||
        b22PermissionBmoh == Permission.manageExternalStorage) {
      return 'b22_please_allow_storage_access_to_itrf'.tr;
    }
    if (b22PermissionBmoh == Permission.camera) {
      return 'b22_please_allow_camera_access_to_kcbh'.tr;
    }
    return 'b22_please_allow_access_to_continue_nwjo'.tr;
  }

  void b22OnAllowPressedTfnn() =>
      B22ApplicationRouterJfva.b22BackCwkm<bool>(b22ResultNvsq: true);

  void b22OnLaterPressedOpfw() {
    B22ApplicationRouterJfva.b22BackCwkm<bool>(b22ResultNvsq: false);
  }
}
