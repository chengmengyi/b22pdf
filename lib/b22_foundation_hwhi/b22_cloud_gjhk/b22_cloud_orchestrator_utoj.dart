import 'dart:convert';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_lifecycle_wopk/b22_application_lifecycle_orchestrator_xzfv.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_floating_oho_store_jvlw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_promotion_toggle_store_wqpw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_cloud_promotion_manifest_store_irzx.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_referrer_manifest_yiaj.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter_custom_facebook/flutter_custom_facebook.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';

class B22CloudOrchestratorRhpr {
  B22CloudOrchestratorRhpr._();
  static final B22CloudOrchestratorRhpr b22InstanceBbui =
      B22CloudOrchestratorRhpr._();

  FirebaseRemoteConfig? b22RemoteConfigRziz;
  FirebaseAnalytics? b22AnalyticsVwav;

  bool b22FacebookInitializedWmqb = false;

  int b22AdCooldownSecondsNmts = 30, b22SecondaryAdCooldownSecondsBnlw = 180;
  bool b22SupportsKoreanNotificationsCxeq = false;
  String b22AdConfigSourceNfkz = "local";

  Future<void> b22InitializePbli() async {
    if (B22CloudPromotionManifestStoreNdmv.b22ReadConfigNutv().isNotEmpty) {
      b22AdConfigSourceNfkz = "remote";
    }
    try {
      await Firebase.initializeApp();
      b22AnalyticsVwav ??= FirebaseAnalytics.instance;
      b22RemoteConfigRziz = FirebaseRemoteConfig.instance;
      await b22RemoteConfigRziz?.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      await b22RemoteConfigRziz?.fetchAndActivate();
      b22ApplyRemoteConfigurationUops();
    } catch (error) {
      await Future.delayed(const Duration(milliseconds: 1000));
      return b22InitializePbli();
    }
  }

  void b22ApplyRemoteConfigurationUops() {
    final int b22OpenCooldownBihw =
        b22RemoteConfigRziz?.getInt('new_op_cd') ?? 0;
    if (b22OpenCooldownBihw > 0) {
      B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
        B22ApplicationSignalXfvp(
          b22TypeIafj: B22ApplicationSignalKindJiwh.b22NewOpenAdCheckTimeCqpg,
          b22IntValueVddo: b22OpenCooldownBihw,
        ),
      );
    }

    final String b22PdfAdConfigHsgh =
        b22RemoteConfigRziz?.getString('pdf_ad_22') ?? '';
    if (b22PdfAdConfigHsgh.isNotEmpty) {
      b22AdConfigSourceNfkz = "remote";
      B22CloudPromotionManifestStoreNdmv.b22SaveConfigAilx(b22PdfAdConfigHsgh);
      B22PromotionOrchestratorAzwq.instance.b22RefreshRemoteAdConfigXndd();
    }

    final String b22FacebookAdConfigNaue =
        b22RemoteConfigRziz?.getString('pdf_adfb') ?? '';
    if (b22FacebookAdConfigNaue.isNotEmpty) {
      B22PromotionOrchestratorAzwq.instance
          .b22UpdateFacebookPlacementConfigHsgl(b22FacebookAdConfigNaue);
    }

    b22ApplyAdCooldownConfigurationMwga();

    final String b22ReferrerConfigWpng =
        b22RemoteConfigRziz?.getString('pr_refer') ?? '';
    if (b22ReferrerConfigWpng.isNotEmpty) {
      B22ReferrerManifestJght.b22SaveXqdi(b22ReferrerConfigWpng);
      B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm
          .b22ApplyReferrerConfigDvej();
    }

    final String b22RiskConfigNnap =
        b22RemoteConfigRziz?.getString('risk_control') ?? '';
    if (b22RiskConfigNnap.isNotEmpty) {
      B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm
          .b22InitializeRiskControlQhar(b22RiskConfigNnap);
    }

    var b22FloatOhoWyks = b22RemoteConfigRziz?.getInt("float_oho") ?? 0;
    if (b22FloatOhoWyks > 0) {
      B22FloatingOhoStoreHxpr.b22SaveOaaq(b22TimestampAvvh: b22FloatOhoWyks);
      FlutterBoomNotificationPlugins.instance.updateCloseOverlayProbability(
        closeOverlayProbability: b22FloatOhoWyks,
      );
    }

    b22InitializeFacebookZcfm();

    final int b22KoreanPushModeQxdn =
        b22RemoteConfigRziz?.getInt('krsamsung_push_time') ?? 0;
    if (b22KoreanPushModeQxdn > 0) {
      b22SupportsKoreanNotificationsCxeq = b22KoreanPushModeQxdn == 1;
      B22AlertOrchestratorNazk.b22InstanceOxzc.b22InitializeJrwh();
    }
    b22PersistFeatureSwitchConfigClmh();

    var b22RemoteTimeoutXhnx = b22RemoteConfigRziz?.getInt("isk_time") ?? 0;
    if (b22RemoteTimeoutXhnx > 0) {
      FlutterPdfAdPlugins.instance.updateAdRequestTimeoutSeconds(
        b22RemoteTimeoutXhnx,
      );
    }

    final int b22HotLaunchCooldownPygh =
        b22RemoteConfigRziz?.getInt("cd_hot") ?? 0;
    if (b22HotLaunchCooldownPygh > 0) {
      B22ApplicationLifecycleOrchestratorPhic
              .b22InstanceGfkl
              .b22HotLaunchCooldownSecondsDqtg =
          b22HotLaunchCooldownPygh;
    }
    b22LoadAdEngagementConfigKbyc();
  }

  void b22PersistFeatureSwitchConfigClmh() {
    try {
      final String b22SwitchConfigTtun =
          b22RemoteConfigRziz?.getString('switch_config') ?? '';
      if (b22SwitchConfigTtun.isNotEmpty) {
        B22PromotionToggleStoreYbdo.b22SaveConfigIcqw(b22SwitchConfigTtun);
      }
    } catch (_) {}
  }

  void b22LoadAdEngagementConfigKbyc() {
    try {
      final String b22AdEngagementConfigSrux =
          b22RemoteConfigRziz?.getString("ad_config") ?? "";
      if (b22AdEngagementConfigSrux.isNotEmpty) {
        final dynamic b22ConfigXjtm = jsonDecode(b22AdEngagementConfigSrux);
        final dynamic b22MaximumShowsOcvr = b22ConfigXjtm["ad_show"];
        final dynamic b22MaximumClicksCvhw = b22ConfigXjtm["ad_click"];
        FlutterPdfAdPlugins.instance.setMaxShowAndClickNum(
          maxShowNum: b22MaximumShowsOcvr,
          maxClickNum: b22MaximumClicksCvhw,
        );
      }
    } catch (_) {}
  }

  void b22ApplyAdCooldownConfigurationMwga() {
    final int b22RemoteCooldownTgub = b22RemoteConfigRziz?.getInt('kc_cd') ?? 0;
    if (b22RemoteCooldownTgub > 0) {
      b22AdCooldownSecondsNmts = b22RemoteCooldownTgub;
    }
    final int b22SecondaryCooldownGeph =
        b22RemoteConfigRziz?.getInt('a_kc_cd') ?? 0;
    if (b22SecondaryCooldownGeph > 0) {
      b22SecondaryAdCooldownSecondsBnlw = b22SecondaryCooldownGeph;
    }
  }

  Future<void> b22InitializeFacebookZcfm() async {
    if (b22FacebookInitializedWmqb) {
      return;
    }
    final String b22FacebookConfigJogy =
        b22RemoteConfigRziz?.getString('pr_fb') ?? '';
    if (b22FacebookConfigJogy.isEmpty) {
      return;
    }
    try {
      final dynamic b22FacebookJsonHsnf = jsonDecode(b22FacebookConfigJogy);
      final bool b22InitializedJrmq = await FlutterCustomFacebook.instance
          .initFaceBook(
            facebookId: b22FacebookJsonHsnf['app_id'],
            facebookToken: b22FacebookJsonHsnf['token'],
            facebookAppName: B22ApplicationManifestPdpm.b22ApplicationNameBjnh,
          );
      b22FacebookInitializedWmqb = b22InitializedJrmq;
    } catch (_) {}
  }

  Future<void> b22LogFacebookPurchaseDlnr(
    double b22AmountDdnv,
    String b22CurrencyFwlm,
  ) async {
    try {
      if (!b22FacebookInitializedWmqb) {
        return;
      }
      FlutterCustomFacebook.instance.logPurchase(
        amount: b22AmountDdnv,
        currency: b22CurrencyFwlm,
      );
    } catch (_) {}
  }

  Future<void> b22LogAnalyticsEventKass({
    required String b22NameIebq,
    Map<String, Object>? b22ParametersTazs,
  }) async {
    try {
      if (Firebase.apps.isEmpty) {
        await b22InitializePbli();
      }
      b22AnalyticsVwav ??= FirebaseAnalytics.instance;
      await b22AnalyticsVwav?.logEvent(
        name: b22NameIebq,
        parameters: b22ParametersTazs,
      );
    } catch (_) {}
  }
}
