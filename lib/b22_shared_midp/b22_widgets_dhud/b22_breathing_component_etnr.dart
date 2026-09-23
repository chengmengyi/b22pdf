import 'package:flutter/material.dart';

class B22BreathingComponentFhqe extends StatefulWidget {
  const B22BreathingComponentFhqe({
    super.key,
    required this.b22ChildFnjn,
    this.b22LowerScaleOxgn = 0.96,
    this.b22UpperScaleDhok = 1,
    this.b22CycleDurationCqjp = const Duration(milliseconds: 400),
    this.b22CurveLtja = Curves.easeInOut,
  }) : assert(b22LowerScaleOxgn > 0),
       assert(b22LowerScaleOxgn <= b22UpperScaleDhok),
       assert(b22CycleDurationCqjp > Duration.zero);

  final Widget b22ChildFnjn;
  final double b22LowerScaleOxgn;
  final double b22UpperScaleDhok;
  final Duration b22CycleDurationCqjp;
  final Curve b22CurveLtja;

  @override
  State<B22BreathingComponentFhqe> createState() =>
      B22BreathingComponentStateYmdm();
}

class B22BreathingComponentStateYmdm extends State<B22BreathingComponentFhqe>
    with SingleTickerProviderStateMixin {
  late final AnimationController b22MotionControllerYfrc;
  late Animation<double> b22ScaleMotionElql;
  bool b22AnimationsDisabledOpkg = false;

  @override
  void initState() {
    super.initState();
    b22MotionControllerYfrc = AnimationController(
      vsync: this,
      duration: widget.b22CycleDurationCqjp,
    );
    b22UpdateAnimationAccessibilityEnul();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool b22DisableMotionRwjb = MediaQuery.disableAnimationsOf(context);
    if (b22DisableMotionRwjb == b22AnimationsDisabledOpkg) {
      return;
    }
    b22AnimationsDisabledOpkg = b22DisableMotionRwjb;
    b22SyncAnimationPlaybackCxws();
  }

  @override
  void didUpdateWidget(covariant B22BreathingComponentFhqe b22OldWidgetJgfg) {
    super.didUpdateWidget(b22OldWidgetJgfg);
    if (b22OldWidgetJgfg.b22CycleDurationCqjp != widget.b22CycleDurationCqjp) {
      b22MotionControllerYfrc.duration = widget.b22CycleDurationCqjp;
    }
    if (b22OldWidgetJgfg.b22LowerScaleOxgn != widget.b22LowerScaleOxgn ||
        b22OldWidgetJgfg.b22UpperScaleDhok != widget.b22UpperScaleDhok ||
        b22OldWidgetJgfg.b22CurveLtja != widget.b22CurveLtja) {
      b22UpdateAnimationAccessibilityEnul();
    }
  }

  void b22UpdateAnimationAccessibilityEnul() {
    b22ScaleMotionElql =
        Tween<double>(
          begin: widget.b22LowerScaleOxgn,
          end: widget.b22UpperScaleDhok,
        ).animate(
          CurvedAnimation(
            parent: b22MotionControllerYfrc,
            curve: widget.b22CurveLtja,
          ),
        );
    b22SyncAnimationPlaybackCxws();
  }

  void b22SyncAnimationPlaybackCxws() {
    if (b22AnimationsDisabledOpkg) {
      b22MotionControllerYfrc.stop();
      b22MotionControllerYfrc.value = 1;
    } else if (!b22MotionControllerYfrc.isAnimating) {
      b22MotionControllerYfrc.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    b22MotionControllerYfrc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: b22ScaleMotionElql,
      child: widget.b22ChildFnjn,
    );
  }
}
