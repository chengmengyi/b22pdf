import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_floating_overlay_zkry/b22_floating_layer_orchestrator_hqqb.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_referrer_manifest_yiaj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter_check_af_new/callback/request_callback.dart';
import 'package:flutter_check_af_new/flutter_check_af_new.dart';
import 'package:flutter_check_af_new/request_af/request_af_callback.dart';
import 'package:flutter_check_af_new/request_cloak/request_cloak_callback.dart';
import 'package:flutter_check_af_new/request_referrer/request_referrer_callback.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';
import 'package:flutter_pdf_risk_control_plugins/callbacks/flutter_pdf_risk_control_callback.dart';
import 'package:flutter_pdf_risk_control_plugins/flutter_pdf_risk_control_plugins.dart';
import 'package:flutter_pdf_risk_control_plugins/models/flutter_pdf_risk_control_ip_config.dart';
import 'package:flutter_pdf_risk_control_plugins/utils/flutter_pdf_risk_control_tag.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class B22AudienceQualificationOrchestratorCaap {
  B22AudienceQualificationOrchestratorCaap._();
  static final B22AudienceQualificationOrchestratorCaap b22InstanceWcsm =
      B22AudienceQualificationOrchestratorCaap._();

  bool b22IsEligibleUserOvsb = false;

  bool get isEligibleUser {
    if (kDebugMode) {
      return true;
    }
    return b22IsEligibleUserOvsb;
  }

  Future<void> b22InitializeAttributionGcmr() async {
    b22ApplyReferrerConfigDvej();
    b22RefreshEligibilityStateLlgu();
    final String b22DistinctIdGtck = await FlutterTbaInfo.instance
        .getDistinctId();
    FlutterCheckAf.instance.init(
      afKey: B22ApplicationManifestPdpm.b22AppsFlyerKeyBwxr,
      afAppId: "",
      distinctId: b22DistinctIdGtck,
      clockUrl: B22ApplicationManifestPdpm.b22ClockEndpointUzyu,
      cloakWhiteKey: 'donor',
      cloakData: <String, dynamic>{
        'caribou': await FlutterTbaInfo.instance.getBundleId(),
        'lewd': Platform.isAndroid ? 'accuracy' : 'triable',
        'avenue': await FlutterTbaInfo.instance.getAppVersion(),
        'puffin': b22DistinctIdGtck,
        'infernal': DateTime.now().millisecondsSinceEpoch,
      },
      requestCallback: RequestCallback(
        requestAfCallback: RequestAfCallback(
          startRequestAf: () {
            B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
              b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AfReqXhkh,
            );
          },
          requestSuccess: (bool b22IsAttributedUserDkjk, String b22AfStrTiqb) {
            B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
              b22PointTypeDrbi: B22TelemetrySignalDbrq.b22AfSucPjoi,
              b22ParametersErwm: {
                //adj_user：【0】【1】，对应【黑名单用户】【自然量用户】
                "af_user": b22IsAttributedUserDkjk ? 1 : 0,
                "af_info": b22AfStrTiqb,
              },
            );
            FlutterPdfAdPlugins.instance.updateAdjustAttribution(
              network: b22AfStrTiqb,
            );
            b22RefreshEligibilityStateLlgu();
          },
          firstRequestAfB: () {},
          startAfSuccess: () {
            B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
              b22PointTypeDrbi: B22TelemetrySignalDbrq.b22StartAfSucBaub,
            );
          },
          startAfFail: (int b22CodeAmrb, String b22MsgXusb) {
            B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
              b22PointTypeDrbi: B22TelemetrySignalDbrq.b22StartAfFailIaye,
              b22ParametersErwm: {"code": b22CodeAmrb, "msg": b22MsgXusb},
            );
          },
        ),
        requestCloakCallback: RequestCloakCallback(
          startRequestCloak: () {
            B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
              b22PointTypeDrbi: B22TelemetrySignalDbrq.b22CloakReqKjjt,
            );
          },
          requestSuccess: (bool b22IsAllowedUserWsvb) {
            B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
              b22PointTypeDrbi: B22TelemetrySignalDbrq.b22CloakSucDnjh,
              b22ParametersErwm: {
                //cloak_user：【0】【1】，对应【黑名单用户】【自然量用户】
                "cloak_user": b22IsAllowedUserWsvb ? 1 : 0,
              },
            );
            b22RefreshEligibilityStateLlgu();
          },
        ),
        requestReferrerCallback: RequestReferrerCallback(
          startRequestReferrer: () {
            B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
              b22PointTypeDrbi: B22TelemetrySignalDbrq.b22ReferrerReqYriq,
            );
          },
          requestSuccess: (String b22ReferrerVcej) {
            b22TrackReferrerResultNwsg(b22ReferrerVcej);
            FlutterPdfAdPlugins.instance.updateInstallReferrer(
              referrer: b22ReferrerVcej,
            );
            b22RefreshEligibilityStateLlgu();
          },
        ),
      ),
    );
  }

  Future<void> b22InitializeRiskControlQhar(String b22RiskConfigGlum) async {
    FlutterPdfRiskControlPlugins.instance.initPdfRiskControl(
      riskConfigJson: b22RiskConfigGlum,
      ipConfig: FlutterPdfRiskControlIpConfig(
        requestUrl: B22ApplicationManifestPdpm.b22RiskUrlCfdx,
        requestData: <String, String>{
          'azebra': await FlutterTbaInfo.instance.getAndroidId(),
        },
        riskResultKey: 'bduck',
        decryptCode: 68,
      ),
      callback: FlutterPdfRiskControlCallback(
        onUploadSessionRisk: (Map<String, int> riskSummary) {},
        onPdfRiskDetected: (FlutterPdfRiskControlTag b22RiskTagAbhz) {
          B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
            b22PointTypeDrbi: B22TelemetrySignalDbrq.b22RiskControlChyf,
            //type：vpn、root、sim、simulator、googleplay、developer、ip
            b22ParametersErwm: {"risk_type": b22RiskTagAbhz.name},
          );
          b22RefreshEligibilityStateLlgu();
        },
      ),
    );
  }

  Future<void> b22ApplyReferrerConfigDvej() async {
    try {
      final String b22ConfigTextDioe = await b22LoadReferrerConfigFgau();
      final dynamic b22ConfigJsonSayj = jsonDecode(b22ConfigTextDioe);
      final dynamic b22ReferrerValuesUzvs = b22ConfigJsonSayj['ilve'];
      final List<String> b22ReferrerListZaoa = <String>[];
      if (b22ReferrerValuesUzvs is List) {
        for (final dynamic b22ValueInuj in b22ReferrerValuesUzvs) {
          if (b22ValueInuj is String) {
            b22ReferrerListZaoa.add(b22ValueInuj);
          }
        }
      }
      FlutterCheckAf.instance.updateReferrerList(
        b22ConfigJsonSayj['door'] == 0,
        b22ReferrerListZaoa,
      );
    } catch (_) {}
  }

  Future<String> b22LoadReferrerConfigFgau() async {
    final String b22StoredConfigVvul = B22ReferrerManifestJght.b22ReadAmbt();
    if (b22StoredConfigVvul.isNotEmpty) {
      return b22StoredConfigVvul;
    }
    var s = await rootBundle.loadString(
      B22ApplicationManifestPdpm.b22LocalReferrerConfigPlsy,
    );
    return FlutterBoomNotificationPlugins.instance.decryptReflectionString(secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi, value: s);
  }

  void b22RefreshEligibilityStateLlgu() {
    final bool b22CheckResultTnnl = FlutterCheckAf.instance.checkUser();
    final bool b22HasSavedRiskXcaq = FlutterPdfRiskControlPlugins.instance
        .hasSavedPdfRisk();
    if (kDebugMode) {
      debugPrint(
        'refresh_b_user_state checkUser:$b22CheckResultTnnl '
        'hasSavedPdfRisk:$b22HasSavedRiskXcaq',
      );
    }
    final bool b22NewEligibilityStateHbqa =
        b22CheckResultTnnl && !b22HasSavedRiskXcaq;
    B22TelemetryOrchestratorNqon.instance.b22SetEligibleUserOotf(
      b22NewEligibilityStateHbqa,
    );
    if (b22IsEligibleUserOvsb == b22NewEligibilityStateHbqa) {
      return;
    }
    b22IsEligibleUserOvsb = b22NewEligibilityStateHbqa;
    B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
      B22ApplicationSignalXfvp(
        b22TypeIafj: B22ApplicationSignalKindJiwh.b22RefreshBUserStateSzod,
        b22BoolValueIejw: b22NewEligibilityStateHbqa,
      ),
    );

    B22AlertOrchestratorNazk.b22InstanceOxzc.b22InitializeJrwh();
    B22PromotionOrchestratorAzwq.instance.b22PreloadEligibleUserAdsFkif();
    if (b22NewEligibilityStateHbqa) {
      unawaited(
        B22FloatingLayerOrchestratorJbeq.b22InstanceAdhr
            .b22InitializeTimerOverlayLofh(),
      );
    }
  }

  Future<void> b22TrackReferrerResultNwsg(String b22ReferrerUknx) async {
    try {
      final String b22ConfigTextOkaw = await b22LoadReferrerConfigFgau();
      final dynamic b22JsonQfni = jsonDecode(b22ConfigTextOkaw);
      final dynamic b22IlveZdqq = b22JsonQfni["ilve"];
      if (b22IlveZdqq is List) {
        int b22ReferrerUserLehy = 0;
        for (final dynamic b22ValueUbri in b22IlveZdqq) {
          if (b22ValueUbri is String &&
              b22ReferrerUknx.contains(b22ValueUbri)) {
            b22ReferrerUserLehy = 1;
            break;
          }
        }
        B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
          b22PointTypeDrbi: B22TelemetrySignalDbrq.b22RefferSucDari,
          b22ParametersErwm: {
            "reffer_info": b22ReferrerUknx,
            "reffer_user": b22ReferrerUserLehy,
          },
        );
      } else {
        B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
          b22PointTypeDrbi: B22TelemetrySignalDbrq.b22RefferSucDari,
          b22ParametersErwm: {
            "reffer_info": b22ReferrerUknx,
            "reffer_user": "list is empty",
          },
        );
      }
    } catch (e) {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.b22RefferSucDari,
        b22ParametersErwm: {
          "reffer_info": b22ReferrerUknx,
          "reffer_user": "error",
        },
      );
    }
  }
}
