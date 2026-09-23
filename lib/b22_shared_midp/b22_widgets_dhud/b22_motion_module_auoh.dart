import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class B22MotionModuleZzdd extends StatelessWidget {
  String b22NameDssf;
  double? b22WidthQfop;
  double? b22HeightJgrv;
  BoxFit? b22BoxFitJozk;
  bool? b22RepeatPhsc;
  B22MotionModuleZzdd({
    required this.b22NameDssf,
    this.b22WidthQfop,
    this.b22HeightJgrv,
    this.b22RepeatPhsc,
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
    "assets/b22_motion_sequences_qnev/b22_document_processing_plaj/$b22NameDssf.json",
    width: b22WidthQfop,
    height: b22HeightJgrv,
    fit: b22BoxFitJozk,
    repeat: b22RepeatPhsc ?? false,
  );
}
