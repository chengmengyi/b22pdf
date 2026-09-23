import 'package:flutter/material.dart';

class B22SafeAreaInsetComponentUiga extends StatelessWidget {
  const B22SafeAreaInsetComponentUiga({
    super.key,
    required this.b22ChildVezd,
    this.b22RemoveTopJtgl = true,
    this.b22RemoveBottomIcls = true,
    this.b22RemoveLeftMrcb = true,
    this.b22RemoveRightLxvr = true,
  });

  final Widget b22ChildVezd;
  final bool b22RemoveTopJtgl;
  final bool b22RemoveBottomIcls;
  final bool b22RemoveLeftMrcb;
  final bool b22RemoveRightLxvr;

  @override
  Widget build(BuildContext b22ContextQvzy) {
    return MediaQuery.removePadding(
      context: b22ContextQvzy,
      removeTop: b22RemoveTopJtgl,
      removeBottom: b22RemoveBottomIcls,
      removeLeft: b22RemoveLeftMrcb,
      removeRight: b22RemoveRightLxvr,
      child: b22ChildVezd,
    );
  }
}
