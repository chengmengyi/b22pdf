import 'dart:convert';
import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_expanded_floating_layer_panel_wqcs.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_compact_floating_layer_panel_lhpi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_floating_oho_store_jvlw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class B22FloatingLayerOrchestratorJbeq {
  B22FloatingLayerOrchestratorJbeq._();

  static final B22FloatingLayerOrchestratorJbeq b22InstanceAdhr =
      B22FloatingLayerOrchestratorJbeq._();
  static const String b22DefaultTaskIdMtzo = 'pdf_processing_task';

  final FlutterBoomNotificationPlugins b22PluginHiby =
      FlutterBoomNotificationPlugins.instance;

  Future<void> b22InitializeTimerOverlayLofh() async {
    if (!B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      return;
    }
    await b22PluginHiby.setTimerOverlayInfo(
      layoutName: 'large_overlay_layout',
      lastPdfSubtitleTemplate: 'b22_last_pdf_page_resume_xmka'.tr,
      lastPdfButtonText: 'b22_open_azmj'.tr,
      continueReadingStr: 'b22_continue_reading_fjse'.tr,
      contentList: B22ExpandedFloatingLayerPanelWpzr.build(),
      layoutName2: 'small_overlay_layout',
      contentList2: B22CompactFloatingLayerPanelJvcs.build(),
      closeOverlayProbability: B22FloatingOhoStoreHxpr.b22ReadUzvw(),
      reflectionConfig: await b22BuildTimerReflectionConfigYlcs(),
      contentList3: [
        TimerOverlayContent(
          title: 'b22_home_fdyl'.tr,
          subtitle: 'home_func',
          button: "",
        ),
        TimerOverlayContent(
          title: 'b22_scan_tbqg'.tr,
          subtitle: 'scan_func',
          button: "",
        ),
        TimerOverlayContent(
          title: 'b22_word_to_pdf_zmcn'.tr,
          subtitle: 'word_func',
          button: "",
        ),
        TimerOverlayContent(
          title: 'b22_image_to_pdf_veiz'.tr,
          subtitle: 'image_func',
          button: "",
        ),
      ],
    );
  }

  Future<bool> b22HasOverlayPermissionBaud() async {
    if (!Platform.isAndroid) return true;
    return b22PluginHiby.checkOverlayPermission();
  }

  Future<bool> b22RequestOverlayPermissionEvau() async {
    if (!Platform.isAndroid) return true;
    return b22PluginHiby.requestOverlayPermission(
      title: 'b22_almost_there_unlock_colon_owpz'.tr,
      desc: 'b22_find_n_below_and_toggle_jhdc'.tr,
      overlayPermissionGuideLayout: 'overlay_layout',
    );
  }

  Future<void> b22ShowProgressOverlayIcnd({
    String b22TaskIdQuzk = b22DefaultTaskIdMtzo,
  }) async {
    if (!Platform.isAndroid || !await b22PluginHiby.checkOverlayPermission())
      return;
    await b22PluginHiby.showProcessingOverlay(
      taskId: b22TaskIdQuzk,
      title: B22ApplicationManifestPdpm.b22ApplicationNameBjnh,
      progress: 0,
      reflectionConfig: await b22BuildProcessingReflectionConfigItzc(),
    );
  }

  Future<void> b22UpdateProgressOverlayIbax({
    required double b22ProgressUhui,
    String b22TaskIdMqdo = b22DefaultTaskIdMtzo,
  }) async {
    if (!Platform.isAndroid || !await b22PluginHiby.checkOverlayPermission())
      return;
    final double b22SafeProgressJssf = b22ProgressUhui.clamp(0, 1).toDouble();
    if (!await b22PluginHiby.isProcessingOverlayActive()) {
      await b22ShowProgressOverlayIcnd(b22TaskIdQuzk: b22TaskIdMqdo);
      if (b22SafeProgressJssf == 0) return;
    }
    await b22PluginHiby.updateProcessingOverlay(
      taskId: b22TaskIdMqdo,
      title: B22ApplicationManifestPdpm.b22ApplicationNameBjnh,
      progress: b22SafeProgressJssf,
    );
  }

  void b22CloseTimerOverlayZifz() => b22PluginHiby.closeTimerOverlay();

  void closeProgressOverlay() => b22PluginHiby.closeProcessingOverlay();

  Future<TimerOverlayReflectionConfig>
  b22BuildTimerReflectionConfigYlcs() async {
    return TimerOverlayReflectionConfig(
      secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi,
      settingsClass:
          'v1:6U79jeTgY6IeI9vt:KIZzkStvxEyxwD02EcYJW0FGRWvm4ZEo9YvVF0B9tBgUTgTN/nDj1bk=',
      canDrawOverlaysMethod:
          'v1:SwPTP7+KBhG5siui:HHU03MjGGNiWmomVjONQckDTICJ2yP1cxfgunw9mYQ==',
      contextGetSystemServiceMethod:
          'v1:l8kn0XpEwgGouMKX:L2AtoD03JDcjA7iInxT5K31TzpO2PKrGjfNBAet9+jE=',
      windowServiceName: 'v1:UrajAHzG4qbpP/bX:fvGJ8CKbyjBI4NDvy9v2o5fv0vpUyQ==',
      windowManagerLayoutParamsClass:
          'v1:BQIQSox8HJ28/UMF:7JpJEnCUOudJOLMm72KTDYsa8gTpDCjz+XVsvfgf/2xjp2iHaSdbQPsq1aZRVEmCiUy8NA/Ffw==',
      viewGroupLayoutParamsClass:
          'v1:bwuGupYzRAASYZ6/:Aoh90wq3FMb76Atknoh4P037KQTMlzSuXOU86Fo5KKPotmIce+Bi4pe+Lis1kXRHCbv9',
      windowManagerClass:
          'v1:s4S5XdkABfbLpCeU:D86T2uvDwTULAY1DSLovJ42Jle4biK09dGU0Xtyn0Jc4VYS2SV1D2Gl4',
      addViewMethod: 'v1:+11fPayiakKOetdx:WsMBLthPP0L1MriqjT0MqeyVF3D1nk0=',
      removeViewMethod:
          'v1:Y3HZdmDQgMB4Z+Vg:nZZfBz1joSaJO1rpJOXxXZVoJ6aLM2HiyXE=',
      gravityField: 'v1:fBR66BdXKTgsUniW:BDRUaJnD/M4ACFPCypg0fxtyGzbzl18=',
      xField: 'v1:fv/I3XSvQDn96dcH:brQbtOGm2E8w+zHc+kggrBE=',
      yField: 'v1:/L0te1MNihhvleqV:38GtYEIyFnIkJdJdzBJ4u00=',
    );
  }

  Future<ProcessingOverlayReflectionConfig>
  b22BuildProcessingReflectionConfigItzc() async {
    return ProcessingOverlayReflectionConfig(
      secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi,
      settingsClass:
          'v1:CnY0El7HVRjVX2Mw:x+fJm29i4+fSL85c1VSaT9LinLRPsbZlH96Bi4uhWaWIgmIyVvHfJM8=',
      canDrawOverlaysMethod:
          'v1:Ir5yV/xZno2qEZDQ:tVfaetgBRlWa7uyG/tx+IqapXdUWbxuEH9XU+xUdWA==',
      contextGetSystemServiceMethod:
          'v1:xFDzLEkVB74yp3Oz:rIS8+G1HZF7BZgg0F0thZInjwtzqZukoDh0nPMF+s4s=',
      windowServiceName: 'v1:hpaZWpZ1TJPRM7Z+:fs+vHPyXCNRtlgsrLJdqjnedFN11fA==',
      windowManagerLayoutParamsClass:
          'v1:yERhCpROWtBz61of:i5AnKM8M6zyeS759F/JoIBua1BqDBpKr+/0v3TPHkNVV1P6F9Pdkgw4gumS8hhSuJB4NaCD3dw==',
      viewGroupLayoutParamsClass:
          'v1:F9Gic5peEA/pmcVV:PXfU6D3OCwHTzcwpSGC6gSW45mAEO921NPIOX3QxVnMGodk/8WKR+A3CQruMxMtkZYHs',
      windowManagerClass:
          'v1:mxtHV6kxoSMycgHO:Wld35N60GrVg5LmUTAU6/fi/sJtc/Ky7fl0eB6DwWzCIHmCCOFEd3ndn',
      addViewMethod: 'v1:AL+/xFctvPyHHGEk:Bh9dbtVGY8mQEaKk+IHtOB+ToQOEPP8=',
      removeViewMethod:
          'v1:L8q/xqCpkBwx/mgI:TYh5bItb63nZVxr6av7AnJF/Aoplw6hmRZI=',
      updateViewLayoutMethod:
          'v1:WY2fD/9mHp/tFTvK:Nnl5OctU4HLweGFAEPwdzbZRlF0ibPNfo1+ikdHnhDg=',
      gravityField: 'v1:s4M8rA0rXBIqAYbK:PvMsweQLcnzW6P6/1wZ8L9ptbrMDBYY=',
      xField: 'v1:PJVhMzAwrMkk4aFq:GsNDchrd1KFG4VuBWZjQMfA=',
      yField: 'v1:FYQj+Eyc95YWxuHu:OoZ2ibzq7TAFE74Ntl0r8Qs=',
    );
  }
}
