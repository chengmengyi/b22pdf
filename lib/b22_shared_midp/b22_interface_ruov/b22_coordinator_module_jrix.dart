import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_holder_ulbe.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/widgets.dart';

abstract class B22CoordinatorModuleFqaw<
  B22TKbnn extends B22FoundationCoordinatorXsba
>
    extends StatefulWidget {
  const B22CoordinatorModuleFqaw({super.key});

  String? get controllerTag => null;

  bool get permanentController => false;

  B22TKbnn createController();

  Widget buildContent(BuildContext context, B22TKbnn controller);

  @override
  State<B22CoordinatorModuleFqaw<B22TKbnn>> createState() =>
      B22CoordinatorModuleStateRisv<B22TKbnn>();
}

class B22CoordinatorModuleStateRisv<
  B22TEgoz extends B22FoundationCoordinatorXsba
>
    extends State<B22CoordinatorModuleFqaw<B22TEgoz>> {
  late final B22CoordinatorHolderHuqz<B22TEgoz> b22ControllerLeasePfmb;

  @override
  void initState() {
    super.initState();
    b22ControllerLeasePfmb = B22CoordinatorHolderHuqz.b22AcquireEhta<B22TEgoz>(
      createController: widget.createController,
      b22TagCgsk: widget.controllerTag,
      b22PermanentXbpd: widget.permanentController,
    );
  }

  @override
  void dispose() {
    b22ControllerLeasePfmb.b22ReleaseLikm();
    super.dispose();
  }

  @override
  Widget build(BuildContext b22ContextYyvf) {
    return widget.buildContent(
      b22ContextYyvf,
      b22ControllerLeasePfmb.b22ControllerYaqk,
    );
  }
}
