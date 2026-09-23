import 'package:flutter/material.dart';

class B22ResourceImageComponentXjch extends StatelessWidget {
  const B22ResourceImageComponentXjch(
    this.b22FileNameDdln, {
    super.key,
    this.b22WidthKbfi,
    this.b22HeightUsfn,
    this.b22FitKddk,
    this.b22AlignmentUgnj = Alignment.center,
    this.b22TintColorBknv,
    this.b22SemanticLabelMjar,
    this.b22ExcludeSemanticsHbyz = false,
  });

  static const String b22AssetRootQvmd = 'assets/';

  final String b22FileNameDdln;
  final double? b22WidthKbfi;
  final double? b22HeightUsfn;
  final BoxFit? b22FitKddk;
  final AlignmentGeometry b22AlignmentUgnj;
  final Color? b22TintColorBknv;
  final String? b22SemanticLabelMjar;
  final bool b22ExcludeSemanticsHbyz;

  String get b22AssetPathXvcr => '$b22AssetRootQvmd$b22FileNameDdln.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      b22AssetPathXvcr,
      width: b22WidthKbfi,
      height: b22HeightUsfn,
      fit: b22FitKddk ?? BoxFit.fill,
      alignment: b22AlignmentUgnj,
      color: b22TintColorBknv,
      semanticLabel: b22SemanticLabelMjar,
      excludeFromSemantics: b22ExcludeSemanticsHbyz,
    );
  }
}
