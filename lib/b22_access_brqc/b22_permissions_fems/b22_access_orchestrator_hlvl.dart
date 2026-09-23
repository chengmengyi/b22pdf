import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_permissions_fems/b22_interface_feda/b22_access_explanation_panel_cufw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_lifecycle_wopk/b22_application_lifecycle_orchestrator_xzfv.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:permission_handler/permission_handler.dart';

class B22AccessOutcomeGgzz {
  final bool b22IsGrantedPfwf;
  final bool b22IsShowPermissionAdTkie;
  const B22AccessOutcomeGgzz({
    required this.b22IsGrantedPfwf,
    required this.b22IsShowPermissionAdTkie,
  });
}

class B22AccessOrchestratorRwgw {
  B22AccessOrchestratorRwgw._();
  static final B22AccessOrchestratorRwgw b22InstanceWzjp =
      B22AccessOrchestratorRwgw._();

  Future<B22AccessOutcomeGgzz> b22RequestPermissionVmnw({
    required Permission b22PermissionUlwh,
  }) async {
    if (await b22PermissionUlwh.isGranted) {
      return const B22AccessOutcomeGgzz(
        b22IsGrantedPfwf: true,
        b22IsShowPermissionAdTkie: false,
      );
    }
    final b22ShouldRequestSzcj =
        await B22ApplicationRouterJfva.b22ShowDialogKwkf<bool>(
          b22ChildNodo: B22AccessExplanationPanelPulh(
            b22PermissionUiuw: b22PermissionUlwh,
          ),
        ) ??
        false;
    if (!b22ShouldRequestSzcj) {
      return const B22AccessOutcomeGgzz(
        b22IsGrantedPfwf: false,
        b22IsShowPermissionAdTkie: true,
      );
    }
    B22ApplicationLifecycleOrchestratorPhic.b22InstanceGfkl
        .b22SuppressNextForegroundAdMmft();
    final b22StatusUijz = await b22PermissionUlwh.request();
    return B22AccessOutcomeGgzz(
      b22IsGrantedPfwf: b22StatusUijz.isGranted,
      b22IsShowPermissionAdTkie: true,
    );
  }
}
