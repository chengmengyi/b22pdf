import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum B22FontKindGnzs { black, extra, medium, semi }

class B22TranslatedLabelComponentJklc extends StatelessWidget {
  const B22TranslatedLabelComponentJklc(
    this.b22ValueVjfu, {
    super.key,
    this.b22TranslateLncu = false,
    this.b22StyleBvqg,
    this.b22ColorZcbj,
    this.b22FontSizeIafw,
    this.b22FontWeightPcyy,
    this.b22TextAlignCzod,
    this.b22MaxLinesHsxg,
    this.b22OverflowUwxb,
    this.b22SoftWrapBszb,
    this.b22DecorationEtco,
    this.b22FontTypeQdme,
  });

  final String b22ValueVjfu;
  final bool b22TranslateLncu;
  final TextStyle? b22StyleBvqg;
  final Color? b22ColorZcbj;
  final double? b22FontSizeIafw;
  final FontWeight? b22FontWeightPcyy;
  final TextAlign? b22TextAlignCzod;
  final int? b22MaxLinesHsxg;
  final TextOverflow? b22OverflowUwxb;
  final bool? b22SoftWrapBszb;
  final TextDecoration? b22DecorationEtco;
  final B22FontKindGnzs? b22FontTypeQdme;

  @override
  Widget build(BuildContext context) {
    final TextStyle b22ResolvedStyleOvif = (b22StyleBvqg ?? const TextStyle())
        .copyWith(
          color: b22ColorZcbj,
          fontSize: b22FontSizeIafw,
          fontWeight: b22FontWeightPcyy,
          decoration: b22DecorationEtco,
          decorationColor: b22ColorZcbj,
          fontFamily: b22FontTypeQdme?.name,
        );
    return Text(
      b22TranslateLncu ? b22ValueVjfu.tr : b22ValueVjfu,
      textAlign: b22TextAlignCzod,
      maxLines: b22MaxLinesHsxg,
      overflow: b22OverflowUwxb,
      softWrap: b22SoftWrapBszb,
      style: b22ResolvedStyleOvif,
    );
  }
}
