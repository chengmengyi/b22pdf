import 'package:flutter/material.dart';

class B22TouchGuardComponentKong extends StatefulWidget {
  const B22TouchGuardComponentKong({
    super.key,
    required this.b22ChildWksr,
    this.b22OnPressedXvbd,
    this.b22CooldownAcxc = const Duration(milliseconds: 800),
    this.b22BorderRadiusIzak,
    this.b22EnableFeedbackUqaz = true,
  });

  final Widget b22ChildWksr;
  final VoidCallback? b22OnPressedXvbd;
  final Duration b22CooldownAcxc;
  final BorderRadius? b22BorderRadiusIzak;
  final bool b22EnableFeedbackUqaz;

  @override
  State<B22TouchGuardComponentKong> createState() => B22TouchGuardStateFojq();
}

class B22TouchGuardStateFojq extends State<B22TouchGuardComponentKong> {
  final Stopwatch b22CooldownClockHjti = Stopwatch();

  void b22HandlePressedGgat() {
    if (b22CooldownClockHjti.isRunning &&
        b22CooldownClockHjti.elapsed < widget.b22CooldownAcxc) {
      return;
    }
    b22CooldownClockHjti
      ..reset()
      ..start();
    widget.b22OnPressedXvbd?.call();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.b22OnPressedXvbd == null ? null : b22HandlePressedGgat,
      borderRadius: widget.b22BorderRadiusIzak,
      enableFeedback: widget.b22EnableFeedbackUqaz,
      child: widget.b22ChildWksr,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
