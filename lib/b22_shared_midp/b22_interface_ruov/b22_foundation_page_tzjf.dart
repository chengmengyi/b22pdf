import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_coordinator_holder_ulbe.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class B22FoundationPageNhfc<
  B22TVpxi extends B22FoundationCoordinatorXsba
>
    extends StatefulWidget {
  const B22FoundationPageNhfc({super.key});

  String? get controllerTag => null;

  bool get permanentController => false;

  bool get resizeToAvoidBottomInset => true;

  bool get useSafeBottom => true;

  Future<bool> canPopRoute(B22TVpxi controller) async {
    B22ApplicationRouterJfva.b22BackWithExitAdBkvf<void>();
    return false;
  }

  Color get backgroundColor => Color(0xffF5F2E9);

  Color get navigationBarColor => Color(0xffF5F2E9);

  SystemUiOverlayStyle get systemUiOverlayStyle => SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: navigationBarColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  );

  B22TVpxi createController();

  Widget buildContent(BuildContext context, B22TVpxi controller);

  @override
  State<B22FoundationPageNhfc<B22TVpxi>> createState() =>
      B22FoundationPageStateKwnd<B22TVpxi>();
}

class B22FoundationPageStateKwnd<B22TVtmt extends B22FoundationCoordinatorXsba>
    extends State<B22FoundationPageNhfc<B22TVtmt>> {
  late final B22CoordinatorHolderHuqz<B22TVtmt> b22ControllerLeaseCdfv;

  @override
  void initState() {
    super.initState();
    b22ControllerLeaseCdfv = B22CoordinatorHolderHuqz.b22AcquireEhta<B22TVtmt>(
      createController: widget.createController,
      b22TagCgsk: widget.controllerTag,
      b22PermanentXbpd: widget.permanentController,
    );
  }

  @override
  void dispose() {
    b22ControllerLeaseCdfv.b22ReleaseLikm();
    super.dispose();
  }

  @override
  Widget build(BuildContext b22ContextUahm) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: widget.systemUiOverlayStyle,
      child: WillPopScope(
        onWillPop: () async {
          return widget.canPopRoute(b22ControllerLeaseCdfv.b22ControllerYaqk);
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: widget.backgroundColor,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            body: SafeArea(
              top: false,
              bottom: widget.useSafeBottom,
              child: widget.buildContent(
                b22ContextUahm,
                b22ControllerLeaseCdfv.b22ControllerYaqk,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
