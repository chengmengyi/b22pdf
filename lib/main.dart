import 'dart:async';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_cloud_gjhk/b22_cloud_orchestrator_utoj.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_application_lexicon_evae.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_first_entry_origin_orchestrator_wwrf.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_shortcuts_itti/b22_operations_iwxd/b22_quick_action_orchestrator_ijhz.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_headless_lifecycle_bootstrap/flutter_headless_lifecycle_bootstrap.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';

@pragma('vm:entry-point')
Future<void> lifecycleMain22() async {
  await FlutterHeadlessLifecycleBootstrap.run(
    backgroundInitializer: backInit22fekpfe,
    uiInitializer: uiInit22dkwod,
  );
}

Future<void> backInit22fekpfe() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  // Service 无界面拉活也上报 install；不要在这里上报 session。
  unawaited(B22TelemetryOrchestratorNqon.instance.b22TrackInstallHdny());

  // 后台首次拉起时 GetMaterialApp 尚未创建，必须先手动初始化 GetX 翻译。
  Get.addTranslations(B22ApplicationLexiconNofd().keys);
  Get.locale = B22ApplicationLexiconNofd.b22ResolveInitialLocaleYfpt();
  Get.fallbackLocale = const Locale('en', 'US');

  B22AlertOrchestratorNazk.b22InstanceOxzc.startSessionBackground();

  unawaited(B22CloudOrchestratorRhpr.b22InstanceBbui.b22InitializePbli());

  await B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm.b22InitializeAttributionGcmr();
}

Future<void> uiInit22dkwod() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await B22ApplicationLexiconNofd.b22InitializeEncryptedLexiconRxye();
  final Locale b22InitialLocaleFoyu = B22ApplicationLexiconNofd.b22ResolveInitialLocaleYfpt();
  Get.locale = b22InitialLocaleFoyu;
  Get.fallbackLocale = B22ApplicationLexiconNofd.b22FallbackLocaleGbqu;
  await B22FirstEntryOriginOrchestratorJicy.instance.b22InitializeLwsd();
  B22PromotionOrchestratorAzwq.instance.b22InitializeYjdz();
  await B22QuickActionOrchestratorYmez.instance.b22InitializeKqab();
  B22TelemetryOrchestratorNqon.instance.b22TrackInstallHdny();
  B22TelemetryOrchestratorNqon.instance.b22TrackSessionIhkh();
  B22AlertOrchestratorNazk.b22InstanceOxzc.b22TrackInitialNotificationEventKvcs();
  B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr.b22CloseTimerOverlayZifz();
  runApp(
    B22FeaturePdfApplicationNgqh(b22InitialLocaleJuhu: b22InitialLocaleFoyu),
  );
}

Future<void> main() async {
  await lifecycleMain22();
}

class B22FeaturePdfApplicationNgqh extends StatelessWidget {
  const B22FeaturePdfApplicationNgqh({
    super.key,
    required this.b22InitialLocaleJuhu,
  });

  final Locale b22InitialLocaleJuhu;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (BuildContext context, Widget? child) => RefreshConfiguration(
        springDescription: const SpringDescription(
          mass: 0.8,
          stiffness: 150,
          damping: 20.0,
        ),
        child: GetMaterialApp(
          title: B22ApplicationManifestPdpm.b22ApplicationNameBjnh,
          enableLog: true,
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          translations: B22ApplicationLexiconNofd(),
          locale: b22InitialLocaleJuhu,
          fallbackLocale: B22ApplicationLexiconNofd.b22FallbackLocaleGbqu,
          supportedLocales: B22ApplicationLexiconNofd.supportedLocales,
          initialRoute: B22ApplicationDestinationsMcbk.b22LauncherRouteFstc,
          getPages: B22ApplicationDestinationsMcbk.b22PagesMdxd,
          defaultTransition: Transition.rightToLeft,
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (BuildContext b22ContextYtha, Widget? b22WidgetCqzx) {
            return MediaQuery(
              data: MediaQuery.of(
                b22ContextYtha,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: b22WidgetCqzx ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
