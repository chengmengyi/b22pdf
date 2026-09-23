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

import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  await B22FirstEntryOriginOrchestratorJicy.instance.b22InitializeLwsd();
  B22CloudOrchestratorRhpr.b22InstanceBbui.b22InitializePbli();
  B22PromotionOrchestratorAzwq.instance.b22InitializeYjdz();
  await B22QuickActionOrchestratorYmez.instance.b22InitializeKqab();
  B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm
      .b22InitializeAttributionGcmr();
  final Locale b22InitialLocaleFoyu =
      B22ApplicationLexiconNofd.b22ResolveInitialLocaleYfpt();
  B22AlertOrchestratorNazk.b22InstanceOxzc.b22InitializeJrwh(
    b22RequestPermissionTulq: true,
  );
  B22TelemetryOrchestratorNqon.instance.b22TrackInstallHdny();
  B22AlertOrchestratorNazk.b22InstanceOxzc
      .b22TrackInitialNotificationEventKvcs();
  B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr.b22CloseTimerOverlayZifz();
  runApp(
    B22FeaturePdfApplicationNgqh(b22InitialLocaleJuhu: b22InitialLocaleFoyu),
  );
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
