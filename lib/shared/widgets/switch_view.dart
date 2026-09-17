import 'dart:async';

import 'package:b21pdf/shared/widgets/asset_picture_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchView extends StatefulWidget {
  const SwitchView({super.key});

  @override
  State<SwitchView> createState() => _SwitchState();
}

class _SwitchState extends State<SwitchView> {
  static const Duration toggleInterval = Duration(milliseconds: 600);

  Timer? toggleTimer;
  bool switchEnabled = false;

  @override
  void initState() {
    super.initState();
    toggleTimer = Timer.periodic(toggleInterval, (Timer timer) {
      if (mounted) {
        setState(() {
          switchEnabled = !switchEnabled;
        });
      }
    });
  }

  @override
  void dispose() {
    toggleTimer?.cancel();
    toggleTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AssetPictureView(
      switchEnabled?'permissions/switch_on':"permissions/switch_off",
      width: 44.w,
      height: 22.h,
    );
  }
}
