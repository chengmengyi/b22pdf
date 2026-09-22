import 'dart:convert';
import 'dart:io';

import 'package:b21pdf/core/config/app_config.dart';
import 'package:b21pdf/core/overlay/large_overlay_content.dart';
import 'package:b21pdf/core/overlay/small_overlay_content.dart';
import 'package:b21pdf/core/storage/preferences/float_oho_cache.dart';
import 'package:b21pdf/core/user/user_eligibility_service.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OverlayService {
  OverlayService._();

  static final OverlayService instance = OverlayService._();
  static const String defaultTaskId = 'pdf_processing_task';

  final FlutterBoomNotificationPlugins _plugin =
      FlutterBoomNotificationPlugins.instance;

  Future<void> initializeTimerOverlay() async {
    if (!UserEligibilityService.instance.isEligibleUser) {
      return;
    }
    await _plugin.setTimerOverlayInfo(
      layoutName: 'large_overlay_layout',
      lastPdfSubtitleTemplate: "You were on page {n}. Let's finish it!".tr,
      lastPdfButtonText: 'Open'.tr,
      continueReadingStr: 'Continue Reading'.tr,
      contentList: LargeOverlayContent.build(),
      layoutName2: 'small_overlay_layout',
      contentList2: SmallOverlayContent.build(),
      closeOverlayProbability: FloatOhoCache.read(),
      reflectionConfig: await _buildTimerReflectionConfig(),
      contentList3: [
        TimerOverlayContent(
          title: 'Home'.tr,
          subtitle: 'home_func',
          button: "",
        ),
        TimerOverlayContent(
          title: 'Scan'.tr,
          subtitle: 'scan_func',
          button: "",
        ),
        TimerOverlayContent(
          title: 'Word To PDF'.tr,
          subtitle: 'word_func',
          button: "",
        ),
        TimerOverlayContent(
          title: 'Image To PDF'.tr,
          subtitle: 'image_func',
          button: "",
        ),
      ],
    );
  }

  Future<bool> hasOverlayPermission() async {
    if (!Platform.isAndroid) return true;
    return _plugin.checkOverlayPermission();
  }

  Future<bool> requestOverlayPermission() async {
    if (!Platform.isAndroid) return true;
    return _plugin.requestOverlayPermission(
      title: 'Almost there! Unlock your full potential:'.tr,
      desc: 'Find {n} below and toggle the switch to ON.'.tr,
      overlayPermissionGuideLayout: 'overlay_layout',
    );
  }

  Future<void> showProgressOverlay({String taskId = defaultTaskId}) async {
    if (!Platform.isAndroid || !await _plugin.checkOverlayPermission()) return;
    await _plugin.showProcessingOverlay(
      taskId: taskId,
      title: AppConfig.applicationName,
      progress: 0,
      reflectionConfig: await _buildProcessingReflectionConfig(),
    );
  }

  Future<void> updateProgressOverlay({
    required double progress,
    String taskId = defaultTaskId,
  }) async {
    if (!Platform.isAndroid || !await _plugin.checkOverlayPermission()) return;
    final double safeProgress = progress.clamp(0, 1).toDouble();
    if (!await _plugin.isProcessingOverlayActive()) {
      await showProgressOverlay(taskId: taskId);
      if (safeProgress == 0) return;
    }
    await _plugin.updateProcessingOverlay(
      taskId: taskId,
      title: AppConfig.applicationName,
      progress: safeProgress,
    );
  }

  void closeTimerOverlay() => _plugin.closeTimerOverlay();

  void closeProgressOverlay() => _plugin.closeProcessingOverlay();

  Future<TimerOverlayReflectionConfig> _buildTimerReflectionConfig() async {
    return TimerOverlayReflectionConfig(
      secret: AppConfig.secretKey,
      settingsClass: 'v1:6U79jeTgY6IeI9vt:KIZzkStvxEyxwD02EcYJW0FGRWvm4ZEo9YvVF0B9tBgUTgTN/nDj1bk=',
      canDrawOverlaysMethod: 'v1:SwPTP7+KBhG5siui:HHU03MjGGNiWmomVjONQckDTICJ2yP1cxfgunw9mYQ==',
      contextGetSystemServiceMethod: 'v1:l8kn0XpEwgGouMKX:L2AtoD03JDcjA7iInxT5K31TzpO2PKrGjfNBAet9+jE=',
      windowServiceName: 'v1:UrajAHzG4qbpP/bX:fvGJ8CKbyjBI4NDvy9v2o5fv0vpUyQ==',
      windowManagerLayoutParamsClass: 'v1:BQIQSox8HJ28/UMF:7JpJEnCUOudJOLMm72KTDYsa8gTpDCjz+XVsvfgf/2xjp2iHaSdbQPsq1aZRVEmCiUy8NA/Ffw==',
      viewGroupLayoutParamsClass: 'v1:bwuGupYzRAASYZ6/:Aoh90wq3FMb76Atknoh4P037KQTMlzSuXOU86Fo5KKPotmIce+Bi4pe+Lis1kXRHCbv9',
      windowManagerClass: 'v1:s4S5XdkABfbLpCeU:D86T2uvDwTULAY1DSLovJ42Jle4biK09dGU0Xtyn0Jc4VYS2SV1D2Gl4',
      addViewMethod: 'v1:+11fPayiakKOetdx:WsMBLthPP0L1MriqjT0MqeyVF3D1nk0=',
      removeViewMethod: 'v1:Y3HZdmDQgMB4Z+Vg:nZZfBz1joSaJO1rpJOXxXZVoJ6aLM2HiyXE=',
      gravityField: 'v1:fBR66BdXKTgsUniW:BDRUaJnD/M4ACFPCypg0fxtyGzbzl18=',
      xField: 'v1:fv/I3XSvQDn96dcH:brQbtOGm2E8w+zHc+kggrBE=',
      yField: 'v1:/L0te1MNihhvleqV:38GtYEIyFnIkJdJdzBJ4u00=',
    );
  }

  Future<ProcessingOverlayReflectionConfig>
  _buildProcessingReflectionConfig() async {
    return ProcessingOverlayReflectionConfig(
      secret: AppConfig.secretKey,
      settingsClass: 'v1:CnY0El7HVRjVX2Mw:x+fJm29i4+fSL85c1VSaT9LinLRPsbZlH96Bi4uhWaWIgmIyVvHfJM8=',
      canDrawOverlaysMethod: 'v1:Ir5yV/xZno2qEZDQ:tVfaetgBRlWa7uyG/tx+IqapXdUWbxuEH9XU+xUdWA==',
      contextGetSystemServiceMethod: 'v1:xFDzLEkVB74yp3Oz:rIS8+G1HZF7BZgg0F0thZInjwtzqZukoDh0nPMF+s4s=',
      windowServiceName: 'v1:hpaZWpZ1TJPRM7Z+:fs+vHPyXCNRtlgsrLJdqjnedFN11fA==',
      windowManagerLayoutParamsClass: 'v1:yERhCpROWtBz61of:i5AnKM8M6zyeS759F/JoIBua1BqDBpKr+/0v3TPHkNVV1P6F9Pdkgw4gumS8hhSuJB4NaCD3dw==',
      viewGroupLayoutParamsClass: 'v1:F9Gic5peEA/pmcVV:PXfU6D3OCwHTzcwpSGC6gSW45mAEO921NPIOX3QxVnMGodk/8WKR+A3CQruMxMtkZYHs',
      windowManagerClass: 'v1:mxtHV6kxoSMycgHO:Wld35N60GrVg5LmUTAU6/fi/sJtc/Ky7fl0eB6DwWzCIHmCCOFEd3ndn',
      addViewMethod: 'v1:AL+/xFctvPyHHGEk:Bh9dbtVGY8mQEaKk+IHtOB+ToQOEPP8=',
      removeViewMethod: 'v1:L8q/xqCpkBwx/mgI:TYh5bItb63nZVxr6av7AnJF/Aoplw6hmRZI=',
      updateViewLayoutMethod: 'v1:WY2fD/9mHp/tFTvK:Nnl5OctU4HLweGFAEPwdzbZRlF0ibPNfo1+ikdHnhDg=',
      gravityField: 'v1:s4M8rA0rXBIqAYbK:PvMsweQLcnzW6P6/1wZ8L9ptbrMDBYY=',
      xField: 'v1:PJVhMzAwrMkk4aFq:GsNDchrd1KFG4VuBWZjQMfA=',
      yField: 'v1:FYQj+Eyc95YWxuHu:OoZ2ibzq7TAFE74Ntl0r8Qs=',
    );
  }
}
