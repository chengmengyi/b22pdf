import 'dart:convert';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_promotion_toggle_store_wqpw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_cloud_promotion_manifest_store_irzx.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_recent_promotion_display_timestamp_store_yydg.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_recent_launch_promotion_close_timestamp_rgqv.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_prepare_fresh_entry_promotion_store_vqlx.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_cloud_gjhk/b22_cloud_orchestrator_utoj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_entry_input_gate_qzrn.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter_check_af_new/flutter_check_af_new.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:appsflyer_sdk_plus/appsflyer_sdk.dart';

class B22PromotionOrchestratorAzwq implements FlutterPdfAdListener {
  static final B22PromotionOrchestratorAzwq b22AdUtilsInstanceAsde =
      B22PromotionOrchestratorAzwq._();

  B22PromotionOrchestratorAzwq._();

  bool b22LoadNewLaunchAdSxft = false;
  int b22LastShowCachedSceneAdTimeEela = 0;

  static B22PromotionOrchestratorAzwq get instance => b22AdUtilsInstanceAsde;

  final List<B22PromotionContextSuaj> b22StartupPreloadAdScenesYjme =
      <B22PromotionContextSuaj>[];
  final Set<B22PromotionContextSuaj> b22NoReloadAfterCloseAdScenesIrpa =
      <B22PromotionContextSuaj>{B22PromotionContextSuaj.pr_new_launch};

  Future<void> b22InitializeYjdz() async {
    b22ConfigureStartupPreloadScenesVcly();
    FlutterPdfAdPlugins.instance.setListener(this);
    FlutterPdfAdPlugins.instance.initializeAdmob();
    final UmpConsentResult b22UmpConsentResultKdtf = await FlutterPdfAdPlugins
        .instance
        .handleUmpConsent();
    if (!b22UmpConsentResultKdtf.canRequestAds) {
      return;
    }
    // FlutterPdfAdPlugins.instance.updateDebugPaidRevenueRange(
    //   minRevenue: 100,
    //   maxRevenue: 200,
    // );
    FlutterPdfAdPlugins.instance.updateInterstitialLikeNativePlacements(
      const <B22PromotionContextSuaj>[B22PromotionContextSuaj.pr_user_use],
    );
    FlutterPdfAdPlugins.instance
        .updateSmallTemplateNativePlacements(const <B22PromotionContextSuaj>[
          B22PromotionContextSuaj.pr_ban1,
          B22PromotionContextSuaj.pr_ban2,
          B22PromotionContextSuaj.pr_ban3,
        ]);
    FlutterPdfAdPlugins.instance.updateSkipReloadAfterClosePlacements(
      b22NoReloadAfterCloseAdScenesIrpa,
    );
    await b22RefreshRemoteAdConfigXndd();
    await FlutterPdfAdPlugins.instance.initPlugins(
      distinctId: await FlutterTbaInfo.instance.getDistinctId(),
      fengKongLogic: () {
        return false;
      },
      smallNativeAdLayoutName: 'native_ad_layout',
    );
    await b22PreloadStartupAdScenesLtcj();
  }

  Future<void> b22PreloadStartupAdScenesLtcj() async {
    final List<Future<void>> b22StartupPreloadTasksKnjm =
        b22StartupPreloadAdScenesYjme
            .map(b22PreloadAdScenePlacementFfoh)
            .toList(growable: false);
    await Future.wait(b22StartupPreloadTasksKnjm);
  }

  Future<void> b22PreloadAdScenePlacementFfoh(
    B22PromotionContextSuaj b22AdSceneHabz, {
    B22PromotionSlotZwla? b22AdPosIdRlyd,
  }) async {
    try {
      await b22LoadStartupSceneWithoutShieldWffy(b22AdSceneHabz);
    } catch (_) {
      return;
    }
  }

  Future<void> b22PreloadSceneQjfv(
    B22PromotionContextSuaj b22AdSceneRxbo,
  ) async {
    await Future.wait(<Future<void>>[
      b22PreloadAdScenePlacementFfoh(b22AdSceneRxbo),
    ]);
  }

  Future<void> b22ForceLoadSceneWgcb({
    required B22PromotionContextSuaj b22AdSceneRvij,
    required B22PromotionSlotZwla b22AdPosIdIjec,
  }) async {
    try {
      await FlutterPdfAdPlugins.instance.loadPlacement<B22PromotionContextSuaj>(
        b22AdSceneRvij,
        force: true,
        placementLabelBuilder: (B22PromotionContextSuaj b22SceneStvb) =>
            b22SceneStvb.name,
      );
    } catch (_) {}
  }

  Future<Widget?> b22TakeDocumentListNativeAdUotz({
    bool b22LoadIfNeededOhqi = true,
    bool b22ReloadAfterTakeXonr = false,
    Duration b22DisposeDelayJhsc = const Duration(seconds: 2),
  }) async {
    return FlutterPdfAdPlugins.instance
        .takeCachedAdWidget<B22PromotionContextSuaj>(
          B22PromotionContextSuaj.pr_ban1,
          adPosId: B22PromotionSlotZwla.pr_main_banner1,
          loadIfNeeded: b22LoadIfNeededOhqi,
          reloadAfterTake: b22ReloadAfterTakeXonr,
          disposeDelay: b22DisposeDelayJhsc,
        );
  }

  Future<Widget?> b22BuildCachedNativeAdJqgz({
    required B22PromotionContextSuaj b22AdSceneTbyk,
    required B22PromotionSlotZwla b22AdPosIdXckb,
  }) async {
    return FlutterPdfAdPlugins.instance
        .buildCachedAdWidget<B22PromotionContextSuaj>(
          b22AdSceneTbyk,
          adPosId: b22AdPosIdXckb,
        );
  }

  Future<bool> b22HasDocumentListNativeAdGfmv() {
    return b22HasCachedAdHtkf(
      b22AdSceneVfau: B22PromotionContextSuaj.pr_ban1,
      b22AdPosIdCcfi: B22PromotionSlotZwla.pr_main_banner1,
    );
  }

  Future<void> b22LoadDocumentListNativeAdAfwu() async {
    await FlutterPdfAdPlugins.instance.loadPlacement<B22PromotionContextSuaj>(
      B22PromotionContextSuaj.pr_ban1,
      force: true,
      placementLabelBuilder: (B22PromotionContextSuaj b22AdSceneZulz) =>
          b22AdSceneZulz.name,
    );
  }

  Future<void> b22LoadStartupSceneWithoutShieldWffy(
    B22PromotionContextSuaj b22AdSceneThnt,
  ) async {
    await FlutterPdfAdPlugins.instance.loadPlacement<B22PromotionContextSuaj>(
      b22AdSceneThnt,
      placementLabelBuilder: (B22PromotionContextSuaj b22AdPlacementZxrl) =>
          b22AdPlacementZxrl.name,
    );
  }

  void b22ConfigureStartupPreloadScenesVcly() {
    b22StartupPreloadAdScenesYjme.clear();
    b22StartupPreloadAdScenesYjme.add(B22PromotionContextSuaj.pr_launch);
    b22StartupPreloadAdScenesYjme.add(B22PromotionContextSuaj.pr_ban1);
    if (B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      b22StartupPreloadAdScenesYjme.add(B22PromotionContextSuaj.pr_ban2);
      b22StartupPreloadAdScenesYjme.add(B22PromotionContextSuaj.pr_exit);
    }
    b22LoadNewLaunchAdSxft =
        B22PrepareFreshEntryPromotionStoreUgpz.b22ReadEnabledZang();
    if (b22LoadNewLaunchAdSxft) {
      B22PrepareFreshEntryPromotionStoreUgpz.b22SaveEnabledHmfa(false);
      b22StartupPreloadAdScenesYjme.add(B22PromotionContextSuaj.pr_new_launch);
    }
  }

  Future<void> b22RefreshRemoteAdConfigXndd() async {
    final dynamic b22AdConfigMapPeke = await b22LoadAdConfigurationCguu();
    final Map<B22PromotionContextSuaj, List<AdInfoBean>> b22ParsedAdConfigFjry =
        <B22PromotionContextSuaj, List<AdInfoBean>>{};
    if (b22AdConfigMapPeke is Map) {
      b22AdConfigMapPeke.forEach((
        dynamic b22ConfigSceneKeyPynf,
        dynamic b22ConfigListValueNzvi,
      ) {
        final B22PromotionContextSuaj? b22ConfigAdSceneTfpf =
            b22FindSceneByConfigKeyKorj('$b22ConfigSceneKeyPynf');
        if (b22ConfigAdSceneTfpf == null || b22ConfigListValueNzvi is! List) {
          return;
        }
        final List<AdInfoBean> b22SceneAdConfigsUqnq = b22ParsedAdConfigFjry
            .putIfAbsent(b22ConfigAdSceneTfpf, () => <AdInfoBean>[]);
        for (final dynamic b22ConfigItemElul in b22ConfigListValueNzvi) {
          if (b22ConfigItemElul is! Map) {
            continue;
          }
          b22SceneAdConfigsUqnq.add(
            AdInfoBean.fromPlacementJson(
              Map<String, dynamic>.from(b22ConfigItemElul),
            ),
          );
        }
      });
    }
    FlutterPdfAdPlugins.instance.updateConfigs<B22PromotionContextSuaj>(
      b22ParsedAdConfigFjry,
      placementLabelBuilder: (B22PromotionContextSuaj b22AdSceneFfiz) =>
          b22AdSceneFfiz.name,
    );
  }

  void b22UpdateFacebookPlacementConfigHsgl(String b22PdfAdfbUkei) {
    try {
      final dynamic b22AdConfigMapGskl = jsonDecode(b22PdfAdfbUkei);
      final Map<B22PromotionContextSuaj, List<AdInfoBean>>
      b22ParsedAdConfigBlpd = <B22PromotionContextSuaj, List<AdInfoBean>>{};
      if (b22AdConfigMapGskl is Map) {
        b22AdConfigMapGskl.forEach((
          dynamic b22ConfigSceneKeyNezd,
          dynamic b22ConfigListValueIbgj,
        ) {
          final B22PromotionContextSuaj? b22ConfigAdSceneGnoi =
              b22FindSceneByConfigKeyKorj('$b22ConfigSceneKeyNezd');
          if (b22ConfigAdSceneGnoi == null || b22ConfigListValueIbgj is! List) {
            return;
          }
          final List<AdInfoBean> b22SceneAdConfigsPxss = b22ParsedAdConfigBlpd
              .putIfAbsent(b22ConfigAdSceneGnoi, () => <AdInfoBean>[]);
          for (final dynamic b22ConfigItemRqjk in b22ConfigListValueIbgj) {
            if (b22ConfigItemRqjk is! Map) {
              continue;
            }
            b22SceneAdConfigsPxss.add(
              AdInfoBean.fromPlacementJson(
                Map<String, dynamic>.from(b22ConfigItemRqjk),
              ),
            );
          }
        });
      }
      FlutterPdfAdPlugins.instance
          .updateFacebookConfigs<B22PromotionContextSuaj>(
            b22ParsedAdConfigBlpd,
            placementLabelBuilder: (B22PromotionContextSuaj b22AdSceneXpyu) =>
                b22AdSceneXpyu.name,
          );
    } catch (_) {}
  }

  B22PromotionContextSuaj? b22FindSceneByConfigKeyKorj(
    String b22ConfigKeyQior,
  ) {
    try {
      return B22PromotionContextSuaj.values.byName(b22ConfigKeyQior);
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> b22LoadAdConfigurationCguu() async {
    try {
      final String b22StoredAdConfigOkeo = B22CloudPromotionManifestStoreNdmv.b22ReadConfigNutv();
      if (b22StoredAdConfigOkeo.isNotEmpty) {
        return jsonDecode(b22StoredAdConfigOkeo);
      }
      return jsonDecode(await b22LoadBundledAdConfigurationPqeh());
    } catch (error) {
      return jsonDecode(await b22LoadBundledAdConfigurationPqeh());
    }
  }

  Future<String> b22LoadBundledAdConfigurationPqeh() async {
    final String b22EncryptedLocalAdConfigRrkz = await rootBundle.loadString(
      B22ApplicationManifestPdpm.b22LocalAdConfigMohr,
    );
    return FlutterBoomNotificationPlugins.instance.decryptReflectionString(secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi, value: b22EncryptedLocalAdConfigRrkz);
  }

  Future<bool?> b22ShowCachedAdZzrb({
    required B22PromotionContextSuaj b22AdSceneHfhk,
    required B22PromotionSlotZwla b22AdPosIdEjxk,
    BuildContext? b22AdHostContextQqxr,
    bool b22UploadChanceAhih = true,
    bool b22IgnoreCooldownGkwn = false,
  }) async {
    if (FlutterPdfAdPlugins.instance.isShowingAd()) {
      return false;
    }
    if (!await b22IsPlacementEnabledWiqd(b22AdPosIdEjxk)) {
      return false;
    }
    if (!b22IgnoreCooldownGkwn &&
        !b22ShouldIgnoreCooldownRgam(
          b22AdSceneCxyz: b22AdSceneHfhk,
          b22AdPosIdQclp: b22AdPosIdEjxk,
        )) {
      return false;
    }
    final int b22CurrentShowCachedSceneAdTimeJtpv =
        DateTime.now().millisecondsSinceEpoch;
    final int b22LastShowCachedSceneAdIntervalAxvl =
        b22LastShowCachedSceneAdTimeEela <= 0
        ? -1
        : b22CurrentShowCachedSceneAdTimeJtpv -
              b22LastShowCachedSceneAdTimeEela;
    b22LastShowCachedSceneAdTimeEela = b22CurrentShowCachedSceneAdTimeJtpv;
    if (b22UploadChanceAhih) {
      b22TrackAdOpportunityFbhf(
        b22AdSceneGiep: b22AdSceneHfhk,
        b22AdPosIdEbwa: b22AdPosIdEjxk,
      );
    }
    try {
      final bool b22HasCachedAdEfrv =
          await b22HasCachedAdForSceneAndPlacementOvdc(
            b22AdSceneDmfo: b22AdSceneHfhk,
            b22AdPosIdEfoy: b22AdPosIdEjxk,
          );
      if (!b22HasCachedAdEfrv) {
        B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
          b22PointTypeDrbi: B22TelemetrySignalDbrq.b22ShowAdNoCacheNihq,
          b22ParametersErwm: {
            "ad_context": b22AdSceneHfhk.name,
            "ad_pos_id": b22AdPosIdEjxk.name,
            "last_time": b22LastShowCachedSceneAdIntervalAxvl,
          },
        );
        if (b22NoReloadAfterCloseAdScenesIrpa.contains(b22AdSceneHfhk)) {
          return false;
        }
        b22PreloadAdScenePlacementFfoh(
          b22AdSceneHfhk,
          b22AdPosIdRlyd: b22AdPosIdEjxk,
        );
        return false;
      }
      final BuildContext? b22ValidAdHostContextSgrm = b22AdHostContextQqxr;
      if (b22ValidAdHostContextSgrm != null &&
          !b22ValidAdHostContextSgrm.mounted) {
        return false;
      }
      final bool? b22DidShowCachedAdTidd = await FlutterPdfAdPlugins.instance
          .showCachedAd<B22PromotionContextSuaj>(
            b22AdSceneHfhk,
            adPosId: b22AdPosIdEjxk,
            context: b22ValidAdHostContextSgrm,
          );
      return b22DidShowCachedAdTidd;
    } catch (b22ErrorHfnj, b22StackTraceJmtx) {
      debugPrint(
        'show cached placement error: scene=$b22AdSceneHfhk, error=$b22ErrorHfnj',
      );
      debugPrint(b22StackTraceJmtx.toString());
      return false;
    }
  }

  Future<bool> b22IsPlacementEnabledWiqd(
    B22PromotionSlotZwla b22AdPosIdArwg,
  ) async {
    try {
      String b22SwitchConfigTsnq = B22PromotionToggleStoreYbdo.b22ReadConfigYgej();
      if (b22SwitchConfigTsnq.isEmpty) {
        var s = await rootBundle.loadString(
          B22ApplicationManifestPdpm.b22LocalAdSwitchKvrw,
        );
        b22SwitchConfigTsnq=await FlutterBoomNotificationPlugins.instance.decryptReflectionString(secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi, value: s);
      }
      final dynamic b22SwitchJsonKlhe = jsonDecode(b22SwitchConfigTsnq);
      if (b22SwitchJsonKlhe is! Map<String, dynamic>) {
        return true;
      }
      final dynamic b22SwitchValueMabz = b22SwitchJsonKlhe[b22AdPosIdArwg.name];
      return b22SwitchValueMabz != 0;
    } catch (_) {
      return true;
    }
  }

  void b22TrackAdOpportunityFbhf({
    required B22PromotionContextSuaj b22AdSceneGiep,
    required B22PromotionSlotZwla b22AdPosIdEbwa,
  }) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdChanceVisn,
      b22ParametersErwm: {
        "ad_context": b22AdSceneGiep.name,
        "ad_pos_id": b22AdPosIdEbwa.name,
      },
    );
  }

  Future<bool> b22HasCachedAdHtkf({
    required B22PromotionContextSuaj b22AdSceneVfau,
    required B22PromotionSlotZwla b22AdPosIdCcfi,
  }) {
    return b22HasCachedAdForSceneAndPlacementOvdc(
      b22AdSceneDmfo: b22AdSceneVfau,
      b22AdPosIdEfoy: b22AdPosIdCcfi,
    );
  }

  Future<void> b22PreloadEligibleUserAdsFkif() async {
    if (!B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      return;
    }
    b22PreloadSceneQjfv(B22PromotionContextSuaj.pr_exit);
    b22PreloadSceneQjfv(B22PromotionContextSuaj.pr_ban2);
  }

  bool b22ShouldIgnoreCooldownRgam({
    required B22PromotionContextSuaj b22AdSceneCxyz,
    required B22PromotionSlotZwla b22AdPosIdQclp,
  }) {
    final bool b22IsBPackageVzbi =
        B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm.isEligibleUser;
    final bool b22ShouldCheckCooldownHlbx =
        !b22IsBPackageVzbi ||
        <B22PromotionSlotZwla>{
          B22PromotionSlotZwla.pr_up_int,
          B22PromotionSlotZwla.pr_down_int,
          B22PromotionSlotZwla.pr_readback,
          B22PromotionSlotZwla.pr_exit_app,
        }.contains(b22AdPosIdQclp);
    if (!b22ShouldCheckCooldownHlbx) {
      debugPrint(
        'showLifecycleAd cooldown scene=${b22AdSceneCxyz.name}, '
        'posid=${b22AdPosIdQclp.name}, canShow=true, '
        'cooldownMs=0, intervalMs=-1, reason=no-cooldown',
      );
      return true;
    }
    final int b22LastShowTimeMsXacn =
        B22RecentPromotionDisplayTimestampStoreZobt.b22ReadTimeMgqm();
    final int b22CooldownSecondsNlso = b22IsBPackageVzbi
        ? B22CloudOrchestratorRhpr.b22InstanceBbui.b22AdCooldownSecondsNmts
        : B22CloudOrchestratorRhpr
              .b22InstanceBbui
              .b22SecondaryAdCooldownSecondsBnlw;
    final int b22CooldownMsNhyq = b22CooldownSecondsNlso * 1000;
    if (b22LastShowTimeMsXacn <= 0) {
      debugPrint(
        'showLifecycleAd cooldown scene=${b22AdSceneCxyz.name}, '
        'posid=${b22AdPosIdQclp.name}, canShow=true, '
        'cooldownMs=$b22CooldownMsNhyq, intervalMs=-1, '
        'reason=no-last-show',
      );
      return true;
    }
    final int b22NowMsMltj = DateTime.now().millisecondsSinceEpoch;
    final int b22ShowIntervalMsPkkh = b22NowMsMltj - b22LastShowTimeMsXacn;
    final bool b22CanShowSqtz = b22ShowIntervalMsPkkh >= b22CooldownMsNhyq;
    debugPrint(
      'showLifecycleAd cooldown scene=${b22AdSceneCxyz.name}, '
      'posid=${b22AdPosIdQclp.name}, canShow=$b22CanShowSqtz, '
      'cooldownMs=$b22CooldownMsNhyq, '
      'intervalMs=$b22ShowIntervalMsPkkh',
    );
    return b22CanShowSqtz;
  }

  Future<bool> b22HasCachedAdForSceneAndPlacementOvdc({
    required B22PromotionContextSuaj b22AdSceneDmfo,
    required B22PromotionSlotZwla b22AdPosIdEfoy,
  }) async {
    try {
      final AdInfoBean? b22CachedAdInfoWotj = await FlutterPdfAdPlugins.instance
          .getAvailableCachedAdInfo<B22PromotionContextSuaj>(b22AdSceneDmfo);
      return b22CachedAdInfoWotj != null;
    } catch (b22ErrorYuos, b22StackTraceYvzp) {
      debugPrint(
        'HasAvailableCachedAd catch scene=$b22AdSceneDmfo, error=$b22ErrorYuos',
      );
      debugPrint(b22StackTraceYvzp.toString());
      return false;
    }
  }

  @override
  void onAdClicked(
    Object b22AdPlacementEcoo,
    AdInfoBean b22AdInfoYnqi,
    Object b22AdPosIdYrqw,
    String b22AdNetworkLxls,
    String adSourceName,
  ) {
    B22AlertOrchestratorNazk.b22InstanceOxzc
        .b22ShowAdFollowUpNotificationQtyb();
    if (b22AdPlacementEcoo is! B22PromotionContextSuaj) {
      return;
    }
    if (b22AdPosIdYrqw is! B22PromotionSlotZwla) {
      return;
    }
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdClickMypx,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementEcoo.name,
        "ad_format": b22AdInfoYnqi.adType,
        "ad_code_id": b22AdInfoYnqi.adId,
        "ad_pos_id": b22AdPosIdYrqw.name,
        "ad_network": b22AdNetworkLxls,
        "ad_source_client": b22AdInfoYnqi.adPlat,
      },
    );
  }

  @override
  void onAdClosed(
    Object b22AdPlacementKlcs,
    AdInfoBean b22AdInfoFzbh,
    Object b22AdPosIdHrkd,
    String b22AdNetworkCpri,
    String adSourceName,
  ) {
    if (b22AdInfoFzbh.parsedAdType?.isFullScreen == true) {
      B22RecentPromotionDisplayTimestampStoreZobt.b22SaveTimeWuxl(
        b22TimestampYivv: DateTime.now().millisecondsSinceEpoch,
      );
    }
    if (b22AdPlacementKlcs is! B22PromotionContextSuaj) {
      return;
    }
    b22SaveLastOpenAdCloseTimeScqy(b22AdPlacementKlcs);
    if (b22AdPosIdHrkd is! B22PromotionSlotZwla) {
      return;
    }
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdCloseRodc,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementKlcs.name,
        "ad_format": b22AdInfoFzbh.adType,
        "ad_code_id": b22AdInfoFzbh.adId,
        "ad_pos_id": b22AdPosIdHrkd.name,
        "ad_network": b22AdNetworkCpri,
        "ad_source_client": b22AdInfoFzbh.adPlat,
      },
    );
  }

  void b22SaveLastOpenAdCloseTimeScqy(
    B22PromotionContextSuaj b22AdPlacementJjht,
  ) {
    if (b22AdPlacementJjht != B22PromotionContextSuaj.pr_new_launch &&
        b22AdPlacementJjht != B22PromotionContextSuaj.pr_launch) {
      return;
    }
    B22RecentLaunchPromotionCloseTimestampVfuy.b22SaveTimeTnvx(
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  void onAdPaidEvent(
    Object b22AdPlacementOpyz,
    Object b22AdPosIdHuvs,
    double b22RevenueStgv,
    String b22CurrencyCodeFqwi,
    String b22AdNetworkBwmw,
    String b22PrecisionTypeUrmf,
    AdInfoBean b22AdInfoDjqh,
  ) {
    if (b22AdPlacementOpyz is! B22PromotionContextSuaj) {
      return;
    }
    if (b22AdPosIdHuvs is! B22PromotionSlotZwla) {
      return;
    }
    if (b22RevenueStgv >= 0.01) {
      B22CloudOrchestratorRhpr.b22InstanceBbui.b22LogAnalyticsEventKass(
        b22NameIebq: B22TelemetrySignalDbrq.b22PrTotal001RevenueBmxi.name,
        b22ParametersTazs: {
          "currency": b22CurrencyCodeFqwi,
          "value": b22RevenueStgv,
        },
      );
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.b22PrTotal001RevenueBmxi,
        b22ParametersErwm: {
          "ad_context": b22AdPlacementOpyz.name,
          "ad_pos_id": b22AdPosIdHuvs.name,
          "ad_format": b22AdInfoDjqh.adType,
          "ad_code_id": b22AdInfoDjqh.adId,
          "currency": b22CurrencyCodeFqwi,
          "value": b22RevenueStgv,
          "ad_network": b22AdNetworkBwmw,
          "ad_source_client": b22AdInfoDjqh.adPlat,
        },
      );
    }

    FlutterCheckAf.instance.uploadAdRevenue(
      b22AdNetworkBwmw,
      b22RevenueStgv,
      b22AdInfoDjqh.adId ?? "",
      b22AdPlacementOpyz.name,
      AFMediationNetwork.googleAdMob,
      b22CurrencyCodeFqwi,
    );

    B22CloudOrchestratorRhpr.b22InstanceBbui.b22LogFacebookPurchaseDlnr(
      b22RevenueStgv,
      b22CurrencyCodeFqwi,
    );

    B22CloudOrchestratorRhpr.b22InstanceBbui.b22LogAnalyticsEventKass(
      b22NameIebq: B22TelemetrySignalDbrq.b22AdImpressionRevenueVcyn.name,
      b22ParametersTazs: {
        "currency": b22CurrencyCodeFqwi,
        "value": b22RevenueStgv,
      },
    );
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdImpressionRevenueVcyn,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementOpyz.name,
        "ad_pos_id": b22AdPosIdHuvs.name,
        "ad_format": b22AdInfoDjqh.adType,
        "ad_code_id": b22AdInfoDjqh.adId,
        "currency": b22CurrencyCodeFqwi,
        "value": b22RevenueStgv,
        "ad_network": b22AdNetworkBwmw,
        "ad_source_client": b22AdInfoDjqh.adPlat,
      },
    );

    B22TelemetryOrchestratorNqon.instance.b22TrackAdRevenueMpwr(
      b22AdInfoRjkm: b22AdInfoDjqh,
      b22AdSceneOrxw: b22AdPlacementOpyz,
      b22PositionIdMoto: b22AdPosIdHuvs,
      b22RevenueEnbe: b22RevenueStgv,
      b22CurrencyMcfw: b22CurrencyCodeFqwi,
      b22AdNetworkOnmo: b22AdNetworkBwmw,
      b22PrecisionUagp: b22PrecisionTypeUrmf,
    );
  }

  @override
  void onAdRequestFailure(
    Object b22AdPlacementFwjb,
    AdInfoBean b22AdInfoTddb,
    String b22FailReasonSbia,
    String b22AdNetworkTxrn,
    String adSourceName,
    double b22LoadDurationSecondsYvsb,
  ) {
    if (b22AdPlacementFwjb is! B22PromotionContextSuaj) {
      return;
    }
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdLoadFailSmyx,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementFwjb.name,
        "ad_format": b22AdInfoTddb.adType,
        "ad_code_id": b22AdInfoTddb.adId,
        "error_message": b22FailReasonSbia,
        "ad_source_client": b22AdInfoTddb.adPlat,
        "ad_network": b22AdNetworkTxrn,
        "load_time": b22LoadDurationSecondsYvsb,
      },
    );
  }

  @override
  void onAdRequestStart(Object b22AdPlacementYkmc, AdInfoBean b22AdInfoEefm) {
    if (b22AdPlacementYkmc is! B22PromotionContextSuaj) {
      return;
    }
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdRequestPlfv,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementYkmc.name,
        "ad_format": b22AdInfoEefm.adType,
        "ad_code_id": b22AdInfoEefm.adId,
        "ad_source_client": b22AdInfoEefm.adPlat,
      },
    );
  }

  @override
  void onAdRequestSuccess(
    Object b22AdPlacementEuvh,
    AdInfoBean b22AdInfoCsbx,
    String b22AdNetworkIacf,
    String adSourceName,
    double b22LoadDurationSecondsCtqv,
  ) {
    if (b22AdPlacementEuvh is! B22PromotionContextSuaj) {
      return;
    }
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdLoadSuccessIrqt,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementEuvh.name,
        "ad_format": b22AdInfoCsbx.adType,
        "ad_code_id": b22AdInfoCsbx.adId,
        "ad_source_client": b22AdInfoCsbx.adPlat,
        "ad_network": b22AdNetworkIacf,
        "load_time": b22LoadDurationSecondsCtqv,
      },
    );
  }

  @override
  void onAdShowFailure(
    Object b22AdPlacementMzvx,
    AdInfoBean b22AdInfoSpms,
    Object b22AdPosIdObys,
    String b22AdNetworkVlmx,
    String adSourceName,
    String b22ErrorMessageXjlk,
  ) {
    if (b22AdPlacementMzvx is! B22PromotionContextSuaj) {
      return;
    }
    if (b22AdPosIdObys is! B22PromotionSlotZwla) {
      return;
    }
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdShowFailNzji,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementMzvx.name,
        "ad_format": b22AdInfoSpms.adType,
        "ad_code_id": b22AdInfoSpms.adId,
        "ad_pos_id": b22AdPosIdObys.name,
        "ad_network": b22AdNetworkVlmx,
        "ad_source_client": b22AdInfoSpms.adPlat,
        "error_message": b22ErrorMessageXjlk,
      },
    );
  }

  @override
  void onAdShowStart(
    Object b22AdPlacementFhpl,
    AdInfoBean b22AdInfoApvf,
    Object b22AdPosIdOdlw,
    String b22AdNetworkDddd,
    String adSourceName,
  ) {
    if (b22AdPlacementFhpl is! B22PromotionContextSuaj) {
      return;
    }
    if (b22AdPosIdOdlw is! B22PromotionSlotZwla) {
      return;
    }
    B22EntryInputGateKjfv.b22InstanceHthn.b22MarkLauncherAdShownIfMatchedRacq(
      b22AdSceneBptf: b22AdPlacementFhpl,
      b22AdPosIdLlho: b22AdPosIdOdlw,
    );
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AdShowClve,
      b22ParametersErwm: {
        "ad_context": b22AdPlacementFhpl.name,
        "ad_format": b22AdInfoApvf.adType,
        "ad_code_id": b22AdInfoApvf.adId,
        "ad_pos_id": b22AdPosIdOdlw.name,
        "ad_network": b22AdNetworkDddd,
        "ad_source_client": b22AdInfoApvf.adPlat,
        "ad_source":
            B22CloudOrchestratorRhpr.b22InstanceBbui.b22AdConfigSourceNfkz,
      },
    );
  }

  @override
  void onAdShowSuccess(
    Object b22AdPlacementHjua,
    AdInfoBean adInfo,
    Object b22AdPosIdUyfr,
    String adNetwork,
    String adSourceName,
  ) {
    if (b22AdPlacementHjua is! B22PromotionContextSuaj) {
      return;
    }
    if (b22AdPosIdUyfr is! B22PromotionSlotZwla) {
      return;
    }
  }

  @override
  void onAdmobInitialized() {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22SdkInitializationMnez,
    );
  }

  @override
  void onTachi25OneDayRevenueEvent(String eventName) {}

  @override
  void onTachi25TotalRevenueEvent(String eventName) {}

  @override
  void onUmpConsentCanRequestAds(bool b22CanRequestAdsDufa) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22CanRequestAdsIfsm,
      b22ParametersErwm: {"canRequest": b22CanRequestAdsDufa ? 1 : 0},
    );
  }

  @override
  void onUmpConsentFlowComplete(UmpConsentResult b22ResultBvof) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22ConsentStatusUpdateXbyz,
      b22ParametersErwm: {
        "countryCode": b22ResultBvof.countryCode,
        "requiresCmpByLocale": b22ResultBvof.requiresCmpByLocale,
        "purpose_ads": b22ResultBvof.canRequestAds,
        "result": b22ResultBvof.consentStatus.name,
        "privacyOptionsRequirementStatus":
            b22ResultBvof.privacyOptionsRequirementStatus.name,
        "formError":
            "code:${b22ResultBvof.formError?.errorCode},message:${b22ResultBvof.formError?.message}",
      },
    );
  }

  @override
  void onUmpConsentFlowStart(
    String b22CountryCodeHmfa,
    bool b22RequiresCmpByLocaleWnbt,
  ) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22ConsentFlowTriggerWixg,
      b22ParametersErwm: {
        "countryCode": b22CountryCodeHmfa,
        "requiresCmp": b22RequiresCmpByLocaleWnbt,
      },
    );
  }

  @override
  void onUmpConsentFormShow() {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22ConsentUiShowWpwq,
    );
  }

  @override
  void onUmpFormLoad() {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22UmpFormLoadNmpu,
    );
  }

  @override
  void onUmpFormRequest() {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22UmpFormRequestEixo,
    );
  }

  @override
  void onUserGroupResolved(int b22UserGroupLwnv) {
    B22TelemetryOrchestratorNqon.instance.b22AddUserGroupBsqx(b22UserGroupLwnv);
  }
}
