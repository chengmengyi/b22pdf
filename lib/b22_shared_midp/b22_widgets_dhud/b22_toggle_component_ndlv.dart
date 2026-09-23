import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_widgets_dhud/b22_resource_image_component_qfzh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class B22ToggleComponentUfkj extends StatefulWidget {
  const B22ToggleComponentUfkj({super.key});

  @override
  State<B22ToggleComponentUfkj> createState() => B22ToggleStateFdpc();
}

class B22ToggleStateFdpc extends State<B22ToggleComponentUfkj> {
  static const Duration b22ToggleIntervalWzpw = Duration(milliseconds: 600);

  Timer? b22ToggleTimerLmqw;
  bool b22SwitchEnabledOrmm = false;

  @override
  void initState() {
    super.initState();
    b22ToggleTimerLmqw = Timer.periodic(b22ToggleIntervalWzpw, (Timer timer) {
      if (mounted) {
        setState(() {
          b22SwitchEnabledOrmm = !b22SwitchEnabledOrmm;
        });
      }
    });
  }

  @override
  void dispose() {
    b22ToggleTimerLmqw?.cancel();
    b22ToggleTimerLmqw = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return B22ResourceImageComponentXjch(
      b22SwitchEnabledOrmm
          ? 'b22_access_media_ydmf/b22_permission_guides_nmul/b22_permission_switch_active_wepo'
          : "b22_access_media_ydmf/b22_permission_guides_nmul/b22_permission_switch_inactive_ctkp",
      b22WidthKbfi: 44.w,
      b22HeightUsfn: 22.h,
    );
  }
}
