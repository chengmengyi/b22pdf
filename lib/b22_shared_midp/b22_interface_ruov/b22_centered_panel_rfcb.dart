import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_holder_ulbe.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/material.dart';

abstract class B22CenteredPanelDsjg<
  B22TNchh extends B22FoundationCoordinatorXsba
>
    extends StatefulWidget {
  const B22CenteredPanelDsjg({super.key});

  String? get controllerTag => null;

  bool get permanentController => false;

  bool get allowBackDismiss => false;

  bool get dismissKeyboard => true;

  EdgeInsets get contentPadding => const EdgeInsets.all(16);

  B22TNchh createController();

  Widget buildDialog(BuildContext context, B22TNchh controller);

  @override
  State<B22CenteredPanelDsjg<B22TNchh>> createState() =>
      B22CenteredPopupStatePvow<B22TNchh>();
}

class B22CenteredPopupStatePvow<B22TQrib extends B22FoundationCoordinatorXsba>
    extends State<B22CenteredPanelDsjg<B22TQrib>> {
  static const Duration keyboardMotion = Duration(milliseconds: 180);

  late final B22CoordinatorHolderHuqz<B22TQrib> b22ControllerLeaseGhhj;

  @override
  void initState() {
    super.initState();
    b22ControllerLeaseGhhj = B22CoordinatorHolderHuqz.b22AcquireEhta<B22TQrib>(
      createController: widget.createController,
      b22TagCgsk: widget.controllerTag,
      b22PermanentXbpd: widget.permanentController,
    );
  }

  @override
  void dispose() {
    b22ControllerLeaseGhhj.b22ReleaseLikm();
    super.dispose();
  }

  @override
  Widget build(BuildContext b22ContextOfwq) {
    final EdgeInsets b22KeyboardInsetsVnqa = MediaQuery.viewInsetsOf(
      b22ContextOfwq,
    );
    return PopScope(
      canPop: widget.allowBackDismiss,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.dismissKeyboard
            ? () => FocusManager.instance.primaryFocus?.unfocus()
            : null,
        child: Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: Center(
              child: widget.buildDialog(
                b22ContextOfwq,
                b22ControllerLeaseGhhj.b22ControllerYaqk,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
