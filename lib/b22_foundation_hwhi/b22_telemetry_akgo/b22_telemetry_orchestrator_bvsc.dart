import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_submit_install_signal_store_vgue.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdf_ad_plugins/bean/ad_info_bean.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class B22TelemetryOrchestratorNqon {
  B22TelemetryOrchestratorNqon._();

  static final B22TelemetryOrchestratorNqon b22InstanceHnze =
      B22TelemetryOrchestratorNqon._();
  static B22TelemetryOrchestratorNqon get instance => b22InstanceHnze;

  final Dio b22DioClientLfjx = Dio();

  Future<void> b22TrackInstallHdny() async {
    b22IncrementLifetimeDaysXfiy();
    b22TrackSessionIhkh();
    if (!B22SubmitInstallSignalStoreKmvw.b22ReadEnabledLrfs()) {
      return;
    }

    final Map<String, dynamic> b22RequestBodyAtnj =
        await b22BuildCommonPayloadLzlq();
    final Map<dynamic, dynamic> b22ReferrerDataLcuf = await FlutterTbaInfo
        .instance
        .getReferrerMap();
    b22RequestBodyAtnj["abide"] = "gamble";
    b22RequestBodyAtnj["space"] = b22ReferrerDataLcuf["build"];
    b22RequestBodyAtnj["ground"] = b22ReferrerDataLcuf["referrer_url"];
    b22RequestBodyAtnj["utter"] = b22ReferrerDataLcuf["install_version"];
    b22RequestBodyAtnj["giddy"] = b22ReferrerDataLcuf["user_agent"];
    b22RequestBodyAtnj["paucity"] = "butt";
    b22RequestBodyAtnj["slept"] =
        b22ReferrerDataLcuf["referrer_click_timestamp_seconds"];
    b22RequestBodyAtnj["surah"] =
        b22ReferrerDataLcuf["install_begin_timestamp_seconds"];
    b22RequestBodyAtnj["signpost"] =
        b22ReferrerDataLcuf["referrer_click_timestamp_server_seconds"];
    b22RequestBodyAtnj["pristine"] =
        b22ReferrerDataLcuf["install_begin_timestamp_server_seconds"];
    b22RequestBodyAtnj["beside"] = b22ReferrerDataLcuf["install_first_seconds"];
    b22RequestBodyAtnj["gown"] = b22ReferrerDataLcuf["last_update_seconds"];

    final bool b22UploadedUebt = await b22SendWithRetryGnul(
      b22BodySrey: b22RequestBodyAtnj,
      b22EventTypeQdpi: 'install',
      b22EventNameVgpn: 'install',
    );
    if (b22UploadedUebt) {
      await B22SubmitInstallSignalStoreKmvw.b22SaveEnabledBllf(false);
    }
  }

  Future<void> b22TrackSessionIhkh() async {
    final Map<String, dynamic> b22RequestBodyFetl =
        await b22BuildCommonPayloadLzlq();
    b22RequestBodyFetl['die'] = {};
    await b22SendWithRetryGnul(
      b22BodySrey: b22RequestBodyFetl,
      b22EventTypeQdpi: 'session',
      b22EventNameVgpn: 'session',
    );
  }

  Future<void> b22TrackAdRevenueMpwr({
    required AdInfoBean b22AdInfoRjkm,
    required B22PromotionContextSuaj b22AdSceneOrxw,
    required B22PromotionSlotZwla? b22PositionIdMoto,
    required double b22RevenueEnbe,
    required String b22CurrencyMcfw,
    required String b22AdNetworkOnmo,
    required String b22PrecisionUagp,
  }) async {
    final Map<String, dynamic> b22RequestBodyTqev =
        await b22BuildCommonPayloadLzlq();
    b22RequestBodyTqev['blest'] = <String, dynamic>{
      'macmahon': b22RevenueEnbe * 1000000,
      'next': b22CurrencyMcfw,
      'exhale': b22AdNetworkOnmo,
      'partial': b22AdInfoRjkm.adPlat ?? '',
      'ridicule': b22AdInfoRjkm.adId ?? '',
      'include': b22PositionIdMoto?.name ?? '',
      'villa': b22AdSceneOrxw.name,
      'surprise': b22PrecisionUagp,
      'fivefold': b22AdInfoRjkm.adType,
    };
    await b22SendWithRetryGnul(
      b22BodySrey: b22RequestBodyTqev,
      b22EventTypeQdpi: 'ad',
      b22EventNameVgpn: b22AdSceneOrxw.name,
    );
  }

  Future<void> b22TrackEventWyre({
    required B22TelemetrySignalDbrq b22PointTypeDrbi,
    Map<String, dynamic>? b22ParametersErwm,
    Map<String, dynamic>? b22UserGroupJayl,
  }) async {
    var b22RequestBodyOqhi = await b22CreateEventPayloadAwjl(
      b22PointTypeSktl: b22PointTypeDrbi,
      b22ParametersNfej: b22ParametersErwm,
      b22UserGroupQyio: b22UserGroupJayl,
    );
    await b22SendWithRetryGnul(
      b22BodySrey: b22RequestBodyOqhi,
      b22EventTypeQdpi: 'point',
      b22EventNameVgpn: b22PointTypeDrbi.name,
    );
  }

  Future<Map<String, dynamic>> b22CreateEventPayloadAwjl({
    required B22TelemetrySignalDbrq b22PointTypeSktl,
    Map<String, dynamic>? b22ParametersNfej,
    Map<String, dynamic>? b22UserGroupQyio,
  }) async {
    final Map<String, dynamic> b22RequestBodyCypm =
        await b22BuildCommonPayloadLzlq();
    b22RequestBodyCypm['abide'] = b22PointTypeSktl.name;
    b22ParametersNfej?.forEach((String b22KeyErau, dynamic b22ValueKizf) {
      b22RequestBodyCypm['$b22KeyErau#mit'] = b22ValueKizf;
    });
    if (null != b22UserGroupQyio) {
      b22RequestBodyCypm["cookery"] = b22UserGroupQyio;
    }
    return b22RequestBodyCypm;
  }

  Future<bool> b22SendWithRetryGnul({
    required Map<String, dynamic> b22BodySrey,
    required String b22EventTypeQdpi,
    required String b22EventNameVgpn,
  }) async {
    final Map<String, dynamic> b22HeadersTfxo =
        await b22BuildRequestHeadersAwcm();
    final String b22RequestUrlRcmt = await b22BuildEndpointUrlWwbz();

    for (int b22AttemptLfqn = 1; b22AttemptLfqn <= 5; b22AttemptLfqn++) {
      try {
        debugPrint(
          'tba-$b22EventTypeQdpi-$b22EventNameVgpn-'
          '请求前-$b22BodySrey-',
        );
        final Response<dynamic> b22ResponseEual = await b22DioClientLfjx
            .post<dynamic>(
              b22RequestUrlRcmt,
              data: b22BodySrey,
              options: Options(
                headers: b22HeadersTfxo,
                contentType: Headers.jsonContentType,
              ),
            );
        final int? b22StatusCodeDiub = b22ResponseEual.statusCode;
        if (b22StatusCodeDiub != null &&
            b22StatusCodeDiub >= 200 &&
            b22StatusCodeDiub < 300) {
          debugPrint(
            'tba-$b22EventTypeQdpi-$b22EventNameVgpn-'
            '请求结果-true-$b22BodySrey-${b22ResponseEual.data}',
          );
          return true;
        }
        debugPrint(
          'tba-$b22EventTypeQdpi-$b22EventNameVgpn-'
          '请求结果-false-$b22BodySrey-${b22ResponseEual.data}',
        );
      } catch (b22RequestErrorIldy) {
        debugPrint(
          'tba-$b22EventTypeQdpi-$b22EventNameVgpn-'
          '请求结果-false-$b22BodySrey-$b22RequestErrorIldy',
        );
      }

      if (b22AttemptLfqn < 5) {
        await Future<void>.delayed(const Duration(seconds: 1));
      }
    }
    return false;
  }

  Future<Map<String, dynamic>> b22BuildCommonPayloadLzlq() async {
    return {
      "dextrous": {
        "caribou": await FlutterTbaInfo.instance.getBundleId(),
        "puffin": await FlutterTbaInfo.instance.getDistinctId(),
        "friend": await FlutterTbaInfo.instance.getBrand(),
        "mix": await FlutterTbaInfo.instance.getDeviceModel(),
        "casein": await FlutterTbaInfo.instance.getOperator(),
        "sloane": await FlutterTbaInfo.instance.getSystemLanguage(),
      },
      "cabot": {
        "lewd": Platform.isAndroid ? "accuracy" : "triable",
        "avenue": await FlutterTbaInfo.instance.getAppVersion(),
        "borate": await FlutterTbaInfo.instance.getOsVersion(),
        "monk": await FlutterTbaInfo.instance.getNetworkType(),
        "cinema": await FlutterTbaInfo.instance.getAndroidId(),
        "risible": await FlutterTbaInfo.instance.getIdfv(),
        "earphone": await FlutterTbaInfo.instance.getOsCountry(),
      },
      "maya": {
        "heart": await FlutterTbaInfo.instance.getLogId(),
        "infernal": DateTime.now().millisecondsSinceEpoch,
        "mazda": await FlutterTbaInfo.instance.getManufacturer(),
        "visage": await FlutterTbaInfo.instance.getIdfa(),
        "olympic": await FlutterTbaInfo.instance.getGaid(),
      },
    };
  }

  Future<Map<String, String>> b22BuildRequestHeadersAwcm() async {
    return <String, String>{
      'cinema': await FlutterTbaInfo.instance.getAndroidId(),
    };
  }

  Future<String> b22BuildEndpointUrlWwbz() async {
    return '${B22ApplicationManifestPdpm.b22TbaEndpointZoda}?mazda=${await FlutterTbaInfo.instance.getManufacturer()}&cinema=${await FlutterTbaInfo.instance.getAndroidId()}';
  }

  b22AddUserGroupBsqx(int b22UserGroupLnle) async {
    b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.ironside,
      b22ParametersErwm: {
        "puffin": await FlutterTbaInfo.instance.getDistinctId(),
      },
      b22UserGroupJayl: {"user_group": b22UserGroupLnle},
    );
  }

  b22SetEligibleUserOotf(bool b22NewEligibilityStateVfxa) async {
    b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.ironside,
      b22ParametersErwm: {
        "puffin": await FlutterTbaInfo.instance.getDistinctId(),
      },
      b22UserGroupJayl: {"user_bv": b22NewEligibilityStateVfxa ? 1 : 0},
    );
  }

  Future<void> b22IncrementLifetimeDaysXfiy() async {
    final Map<dynamic, dynamic> b22ReferrerMapUveu = await FlutterTbaInfo
        .instance
        .getReferrerMap();
    final dynamic b22InstallFirstSecondsXqnb =
        b22ReferrerMapUveu["install_first_seconds"];
    final int? b22InstallTimestampJojy = int.tryParse(
      '$b22InstallFirstSecondsXqnb',
    );
    bool b22IsInstalledTodayYgrj = false;
    if (b22InstallTimestampJojy != null && b22InstallTimestampJojy > 0) {
      final int b22InstallMillisecondsYgqc =
          b22InstallTimestampJojy < 100000000000
          ? b22InstallTimestampJojy * 1000
          : b22InstallTimestampJojy;
      final DateTime b22InstallDateTxdm = DateTime.fromMillisecondsSinceEpoch(
        b22InstallMillisecondsYgqc,
      );
      final DateTime b22NowHgnl = DateTime.now();
      b22IsInstalledTodayYgrj =
          b22InstallDateTxdm.year == b22NowHgnl.year &&
          b22InstallDateTxdm.month == b22NowHgnl.month &&
          b22InstallDateTxdm.day == b22NowHgnl.day;
    }
    b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.ironside,
      b22ParametersErwm: {
        "puffin": await FlutterTbaInfo.instance.getDistinctId(),
      },
      b22UserGroupJayl: {"life_time": b22IsInstalledTodayYgrj ? "d0" : "d1"},
    );
  }
}
