import 'dart:async';
import 'dart:convert';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_language_choice_zfoo.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_lifecycle_wopk/b22_application_lifecycle_orchestrator_xzfv.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_cloud_gjhk/b22_cloud_orchestrator_utoj.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_first_entry_origin_orchestrator_wwrf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_startup_ppmh/b22_operations_zxfh/b22_entry_input_gate_qzrn.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:flutter_tba_info_new/flutter_tba_info_new.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:permission_handler/permission_handler.dart';

class B22AlertOrchestratorNazk {
  B22AlertOrchestratorNazk._();
  static final B22AlertOrchestratorNazk b22InstanceOxzc =
      B22AlertOrchestratorNazk._();

  bool b22PluginInitializedEtah = false;
  bool b22ListenersInitializedVjqo = false;
  bool b22TbaInitializedQkbr = false;
  bool b22PeriodicNotificationsStartedMwxe = false;
  bool b22BroadcastsInitializedPqiy = false;
  bool b22FcmInitializedDzku = false;
  bool b22MediaNotificationsStartedYvca = false;
  bool b22ShortcutNotificationInitializedLhfg = false;
  Future<void>? b22BaseInitializationFutureRjns;
  Future<void> b22PermissionRequestTailKxwa = Future<void>.value();

  Future<void> b22InitializeJrwh() async {
    final bool b22CanInitializeOwzu = await b22IsInitializationAllowedCgbv();
    if (!b22CanInitializeOwzu) {
      return;
    }

    final Future<void> b22InitializationFutureEtzf =
        b22BaseInitializationFutureRjns ??=
            b22InitializeNotificationBaseUgwp();
    try {
      await b22InitializationFutureEtzf;
    } catch (_) {
      if (identical(
        b22BaseInitializationFutureRjns,
        b22InitializationFutureEtzf,
      )) {
        b22BaseInitializationFutureRjns = null;
      }
      rethrow;
    }

    await b22InitializeMediaNotificationNxyd();
  }

  Future<void> b22InitializeNotificationBaseUgwp() async {
    await b22InitializeLocalInfoTfxi();
    await b22InitializeTbaInfoVnwr();
    b22InitializeListenersBaae();
    b22InitializeShortcutNotificationNtfl();
    b22ScheduleLocalNotificationsGzvp();
    b22InitializeBroadcastsMpzh();
    b22InitializeFcmDlde();
  }

  Future<void> b22RequestNotificationPermissionYwht() async {
    final bool b22CanInitializeOwzu = await b22IsInitializationAllowedCgbv();
    if (!b22CanInitializeOwzu) {
      return;
    }
    final Future<void> b22RequestFutureNkue = b22PermissionRequestTailKxwa
        .then<void>(
          (_) => b22PerformNotificationPermissionRequestCqza(),
          onError: (_) => b22PerformNotificationPermissionRequestCqza(),
        );
    b22PermissionRequestTailKxwa = b22RequestFutureNkue;
    return b22RequestFutureNkue;
  }

  Future<void> b22PerformNotificationPermissionRequestCqza() async {
    await Permission.notification.request();
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.storage_system_result,
      b22ParametersErwm: {
        "open": (await b22HasNotificationPermissionAqao()) ? 1 : 0,
      },
    );
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.push_guide_view,
      b22ParametersErwm: {"show_type": "system"},
    );
  }

  startSessionBackground()async{
    var header = await B22TelemetryOrchestratorNqon.instance.b22BuildRequestHeadersAwcm();
    final String url = await B22TelemetryOrchestratorNqon.instance.b22BuildEndpointUrlWwbz();
    var map = await B22TelemetryOrchestratorNqon.instance.b22CreateEventPayloadAwjl(
      b22PointTypeSktl: B22TelemetrySignalDbrq.session_bac,
    );
    FlutterBoomNotificationPlugins.instance.startSessionBackground(
      enabled: true,
      url: url,
      headers: header,
      payloadTemplate: map,
      distinctIdKey: "puffin",
      logIdKey: "heart",
      clientTsKey: "infernal",
      packageKey: "caribou",
    );
  }

  Future<bool> b22HasNotificationPermissionAqao() async {
    var b22PermissionStatusThqa = await Permission.notification.status;
    var b22IsGrantedWnts =
        b22PermissionStatusThqa.isGranted || b22PermissionStatusThqa.isLimited;
    return b22IsGrantedWnts;
  }

  Future<void> b22InitializeTbaInfoVnwr() async {
    if (b22TbaInitializedQkbr) {
      return;
    }
    final Map<String, String> b22HeaderMapYwfg = Map<String, String>.from(
      await B22TelemetryOrchestratorNqon.instance.b22BuildRequestHeadersAwcm(),
    );
    final String b22RequestUrlHprb = await B22TelemetryOrchestratorNqon.instance
        .b22BuildEndpointUrlWwbz();
    final Map<String, dynamic> b22PushPayloadHxas =
        await B22TelemetryOrchestratorNqon.instance.b22CreateEventPayloadAwjl(
          b22PointTypeSktl: B22TelemetrySignalDbrq.push,
          b22ParametersNfej: {'sourse': "local"},
        );
    await FlutterBoomNotificationPlugins.instance.configureNativePushReporting(
      enabled: true,
      url: b22RequestUrlHprb,
      headers: b22HeaderMapYwfg,
      payloadTemplate: b22PushPayloadHxas,
      distinctIdKey: "puffin",
      logIdKey: "heart",
      clientTsKey: "infernal",
      notificationSourceKey: "sourse#mit",
      packageKey: "caribou",
    );
    b22TbaInitializedQkbr = true;
  }

  Future<void> b22InitializeShortcutNotificationNtfl({
    bool b22ForceYwov = false,
  }) async {
    if (!b22ForceYwov && b22ShortcutNotificationInitializedLhfg) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance
        .showPersistentShortcutNotification(
      homeText: 'b22_home_fdyl'.tr,
      mergeText: 'b22_scan_tbqg'.tr,
      importText: 'b22_word_to_pdf_zmcn'.tr,
      convertText: 'b22_image_to_pdf_veiz'.tr,
      homeIcon: 'b22_home_shortcut_icon_clta',
      mergeIcon: 'b22_scan_shortcut_icon_mfzi',
      importIcon: 'b22_word_conversion_icon_otcr',
      convertIcon: 'b22_image_conversion_icon_ajfk',
    );
    b22ShortcutNotificationInitializedLhfg = true;
  }

  Future<void> b22InitializeMediaNotificationNxyd() async {
    final bool b22CanInitializeCmhs = await b22IsInitializationAllowedCgbv();
    if (!b22CanInitializeCmhs || b22MediaNotificationsStartedYvca) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance.updateShowMediaTag(
      showMedia: true,
    );
    await FlutterBoomNotificationPlugins.instance
        .periodicallyShowMediaWithDuration(
      reflectionConfig: MediaReflectionConfig(
        secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi,
        mediaSessionClass:
            'v1:tzRdnGgpoMC1xk/6:RleMSswMfsziCXT/FEGyijN8yq+fZPM3YkfE88/7snfb//xZU47ySsUck2cifoLdnxDeoNEWFZcgeUjotfiyRReTvA==',
        mediaSessionTokenClass:
            'v1:QvrLJahVOEZAwvkq:/hn4yiBrSm4YvnFPDrhA/e9pb+T9d+oLVL5r1fvZ4YuM3Ivai4mlIPYItnYAsrZfFX+b6ehmeamQRUcMV9pN7WqpoHlZn7A1XQ==',
        mediaSessionTag:
            'v1:OOQbTkU9pLW+3hR5:MUxRAxlwBG9gZxzd2GixL0pEeQduHA4keMZzYW37JQ==',
        playbackStateClass:
            'v1:ucXlHz9K6HoMpdJC:q8RY+MCYZr2vehFXecUFtwoRCIQCpEI7xRGEFr46GusLoD7Q1FFKQPVnOrOHG2mxhFB2nnEJDzM3rgWkTNxoA/qZacM=',
        playbackStateBuilderClass:
            'v1:3B7Xd9gR6QdLda/s:b0t6jv4Iyak9Jzi2tDLJ76WEXKfgSYy/uKFL0WZs28E59gnK48MvRy0XJSLev9P+kogurH+rg6hOxqU6naQn7XYxo9jdRl8nwDiW6w==',
        mediaStyleClass:
            'v1:fMBMaPWtmhI8pUEs:B/rBNX44FqsXacd123g562OcUY/eS6OdBQzDvjTU4H+1d//DRjbHqcxNN4v1AEd0e/Dci/cfUEory4G+cbFzsg==',
        setFlagsMethod: 'v1:XsxTfTYQTwEZX6a+:mQy2wEZpl8b2wOLf9N/LEE937H1kXNt0',
        setActiveMethod:
            'v1:3xZxeS2EMiC4V7HC:s0fWVsgJEr+DR41phURA1PNzX+5g63lkRQ==',
        setPlaybackStateMethod:
            'v1:U2rKs8VK1Yf4wouE:JN77zixNf84H5NAycxqVlKun963OOlN7RcxE1wIw1KY=',
        getSessionTokenMethod:
            'v1:TDWbUhkrlEZlJgvB:tf/9P7jCaAwO/Y62ydS3eSFYhmsaeb5QHSJWQFq8XA==',
        setStateMethod: 'v1:5ksEfdO5Uk/FBkEk:zregmuJWbI6c0QYF3LliijrRnjIqBnCx',
        buildMethod: 'v1:bk70WU+pOSMDClRO:Bm3XIFH/JgvuIdoTzXXRjDUV9K4t',
        setMediaSessionMethod:
            'v1:DNKfh7mS0aDYbgZA:1uNdA4lk6+63gjRvRu8yqih1UWXMboUGOIYulcbXoQ==',
      ),
      mediaBackgroundImageName: 'b22_notification_hero_artwork_vtka',
    );
    b22MediaNotificationsStartedYvca = true;
  }

  Future<void> b22InitializeBroadcastsMpzh() async {
    if (b22BroadcastsInitializedPqiy) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance
        .registerBroadcastNotifications();
    b22BroadcastsInitializedPqiy = true;
  }

  Future<void> b22InitializeFcmDlde() async {
    if (b22FcmInitializedDzku) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance.subscribeToTopic(
      channelId: 'fcm_notice_channel',
      channelName: 'fcm_notice_channel_name',
      priority: Priority.max,
      importance: Importance.max,
      style: 'beauty',
      beautyButton: 'Claim',
    );
    b22FcmInitializedDzku = true;
  }

  Future<void> b22ScheduleLocalNotificationsGzvp() async {
    if (b22PeriodicNotificationsStartedMwxe) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance
        .periodicallyShowLocalWithDuration();
    b22PeriodicNotificationsStartedMwxe = true;
  }

  Future<void> b22UpdateNewFileNotificationTextBclm() async {
    await FlutterBoomNotificationPlugins.instance
        .setGalleryImageNotificationInfo(
      title: 'b22_you_have_a_new_file_egds'.tr,
    );
  }

  Future<void> b22InitializeLocalInfoTfxi() async {
    if (b22PluginInitializedEtah) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance.initNotification(
      icon: 'b22_notification_small_brandmark_iznf',
      channelId: 'notice_channel',
      channelName: 'notice_channel_name',
      channelDescription: 'PDF notifications',
      customLayout: AndroidCustomNotificationLayout(
        smallLayoutName: 'b22_compact_notification_layout_zmci',
        bigLayoutName: 'b22_expanded_notification_layout_wgtn',
        actionText: 'b22_check_knsl'.tr,
      ),
      showMedia: false,
      config: await b22BuildNotificationConfigEces(),
    );
    await b22UpdateNewFileNotificationTextBclm();
    b22PluginInitializedEtah = true;
  }

  Future<NotificationInitConfig> b22BuildNotificationConfigEces() async {
    final String localNotificationStr = await rootBundle.loadString(
      B22ApplicationManifestPdpm.b22DefaultNotificationConfigNdau,
    );
    var b22DefaultNotificationConfigBvls=await FlutterBoomNotificationPlugins.instance.decryptReflectionString(secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi, value: localNotificationStr);
    final String localFieldMappingStr = await rootBundle.loadString(
      B22ApplicationManifestPdpm.b22FieldMappingConfigJinl,
    );
    var b22FieldMappingConfigBbrc=await FlutterBoomNotificationPlugins.instance.decryptReflectionString(secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi, value: localFieldMappingStr);
    var b22DeviceLanguageWsws = "", b22CountryCodeYbos = "";
    var b22LanguageXpeRruc = B22LanguageChoiceDsdt.b22ReadLanguagePgwy();
    if (b22LanguageXpeRruc.isNotEmpty) {
      try {
        var b22ListPddd = b22LanguageXpeRruc.split("-");
        b22DeviceLanguageWsws = b22ListPddd.first;
        b22CountryCodeYbos = b22ListPddd.last;
      } catch (_) {}
    }
    if (b22DeviceLanguageWsws.isEmpty) {
      b22DeviceLanguageWsws = await FlutterBoomNotificationPlugins.instance
          .getDeviceLanguage();
    }
    if (b22CountryCodeYbos.isEmpty) {
      b22CountryCodeYbos = await FlutterBoomNotificationPlugins.instance
          .getCountryCode();
    }
    return NotificationInitConfig(
      defaultConfig: b22DefaultNotificationConfigBvls,
      request: NotificationConfigRequest(
        url: B22ApplicationManifestPdpm.b22NotificationConfigUrlWhav,
        headers: {
          "fwfns": kDebugMode
              ? "com.filevera.pdftool"
              : await FlutterTbaInfoNew.instance.getBundleId(),
          "ihtw": kDebugMode
              ? "0.0.1"
              : await FlutterTbaInfoNew.instance.getAppVersion(),
        },
        body: {
          "ebSBfnD": b22DeviceLanguageWsws,
          "IEajB": await FlutterTbaInfoNew.instance.getDistinctId(),
          "jpgRQUSwW": b22CountryCodeYbos,
        },
      ),
      fieldMapping: jsonDecode(b22FieldMappingConfigBbrc),
    );
  }

  void b22InitializeListenersBaae() {
    if (b22ListenersInitializedVjqo) {
      return;
    }
    FlutterBoomNotificationPlugins.instance.setListeners(
      onNotificationClicked: (LocalNotificationEvent b22EventPgxr) {
        final B22ApplicationLifecycleOrchestratorPhic b22LifecycleServiceGzvw =
            B22ApplicationLifecycleOrchestratorPhic.b22InstanceGfkl;
        if (b22LifecycleServiceGzvw.shouldSuppressClickHotLaunch) {
          b22LifecycleServiceGzvw.b22SuppressNextForegroundAdMmft();
        }
        if (!B22EntryInputGateKjfv.b22InstanceHthn.canHandleNotificationClick) {
          return;
        }
        final String b22PayloadGyrk =
            b22EventPgxr.payload ?? b22EventPgxr.payloadType?.name ?? '';
        b22TrackNotificationClickHlms(b22PayloadGyrk);
        unawaited(
          b22LifecycleServiceGzvw.b22ShowLifecycleAdJfbv(
            B22PromotionContextSuaj.pr_launch,
            b22PayloadGyrk == 'media'
                ? B22PromotionSlotZwla.pr_open_mediapop
                : B22PromotionSlotZwla.pr_open_noti,
            b22TriggerXecm: B22LifecycleAdTriggerYgme.notification,
          ),
        );
      },
      onNotificationDisplayed: (LocalNotificationEvent b22EventLmrc) {
        b22TrackNotificationImpressionScoo(
          b22EventLmrc.payload ?? b22EventLmrc.payloadType?.name ?? '',
        );
      },
      onTimerOverlayClicked: b22HandleTimerOverlayClickCatt,
      onProcessingOverlayClicked: b22HandleProcessingOverlayClickNhcp,
    );
    b22ListenersInitializedVjqo = true;
  }

  void b22HandleTimerOverlayClickCatt(TimerOverlayClickEvent b22EventBtld) {
    final B22ApplicationLifecycleOrchestratorPhic b22LifecycleServiceNoml =
        B22ApplicationLifecycleOrchestratorPhic.b22InstanceGfkl;
    if (b22LifecycleServiceNoml.shouldSuppressClickHotLaunch) {
      b22LifecycleServiceNoml.b22SuppressNextForegroundAdMmft();
    }
    if (!B22EntryInputGateKjfv.b22InstanceHthn.canHandleNotificationClick) {
      return;
    }
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.float_click,
      b22ParametersErwm: <String, dynamic>{
        'float_type': b22EventBtld.clickType,
      },
    );
    unawaited(
      FlutterBoomNotificationPlugins.instance.consumeTimerOverlayClickEvent(),
    );
    unawaited(
      b22LifecycleServiceNoml.b22ShowLifecycleAdJfbv(
        B22PromotionContextSuaj.pr_launch,
        B22PromotionSlotZwla.pr_open_pop,
        b22TriggerXecm: B22LifecycleAdTriggerYgme.notification,
      ),
    );
  }

  void b22HandleProcessingOverlayClickNhcp() {
    final bool b22CanHandleSovb =
        B22EntryInputGateKjfv.b22InstanceHthn.canHandleNotificationClick;
    debugPrint(
      '[AppLifecycle] onProcessingOverlayClicked canHandle=$b22CanHandleSovb',
    );
    if (!b22CanHandleSovb) return;
    final B22ApplicationLifecycleOrchestratorPhic b22LifecycleServiceIhcp =
        B22ApplicationLifecycleOrchestratorPhic.b22InstanceGfkl;
    final bool b22ShouldSuppressTxpb =
        b22LifecycleServiceIhcp.shouldSuppressClickHotLaunch;
    debugPrint(
      '[AppLifecycle] onProcessingOverlayClicked '
      'shouldSuppressHotLaunch=$b22ShouldSuppressTxpb',
    );
    if (b22ShouldSuppressTxpb) {
      b22LifecycleServiceIhcp.b22SuppressNextForegroundAdMmft();
    }
    unawaited(
      b22LifecycleServiceIhcp.b22ShowLifecycleAdJfbv(
        B22PromotionContextSuaj.pr_launch,
        B22PromotionSlotZwla.pr_progress,
        b22TriggerXecm: B22LifecycleAdTriggerYgme.notification,
      ),
    );
  }

  Future<void> b22RefreshNotificationLanguageUxjg() async {
    final bool b22CanInitializeIgxv = await b22IsInitializationAllowedCgbv();
    if (!b22CanInitializeIgxv) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance.refreshNotificationConfig(
      config: await b22BuildNotificationConfigEces(),
    );
    await b22InitializeShortcutNotificationNtfl(b22ForceYwov: true);
    await b22UpdateNewFileNotificationTextBclm();
  }

  Future<void> b22ShowAdFollowUpNotificationQtyb() async {
    final bool b22CanInitializeEeue = await b22IsInitializationAllowedCgbv();
    if (!b22CanInitializeEeue) {
      return;
    }
    await FlutterBoomNotificationPlugins.instance.show(
      id: b22GenerateNotificationIdGgpj(),
      title: 'b22_continue_viewing_pdf_zbcg'.tr,
      body: 'b22_continue_viewing_pdf_zbcg'.tr,
      payload: LocalNotificationPayload.local,
    );
  }

  int b22GenerateNotificationIdGgpj() {
    return DateTime.now().microsecondsSinceEpoch % 2147483647;
  }

  void b22TrackInitialNotificationEventKvcs() {
    final TimerOverlayClickEvent? b22TimerOverlayClickEventZdrm =
        B22FirstEntryOriginOrchestratorJicy
            .instance
            .b22TimerOverlayClickEventEvqt;
    if (b22TimerOverlayClickEventZdrm != null) {
      B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
        b22PointTypeDrbi: B22TelemetrySignalDbrq.float_click,
        b22ParametersErwm: <String, dynamic>{
          'float_type': b22TimerOverlayClickEventZdrm.clickType,
        },
      );
    }
    if (B22FirstEntryOriginOrchestratorJicy
            .instance
            .b22NotificationPayloadStff !=
        null) {
      b22TrackNotificationClickHlms(
        B22FirstEntryOriginOrchestratorJicy
                .instance
                .b22NotificationPayloadStff ??
            '',
      );
    }
    b22TrackPendingNotificationEventsAmrd();
  }

  Future<void> b22TrackPendingNotificationEventsAmrd() async {
    for (final LocalNotificationPayload b22PayloadWfie
        in LocalNotificationPayload.values) {
      final int b22DisplayedCountUubd = await FlutterBoomNotificationPlugins
          .instance
          .consumeDisplayedNotificationCount(payload: b22PayloadWfie);
      if (b22DisplayedCountUubd > 0) {
        for (
          int b22IndexGjva = 0;
          b22IndexGjva < b22DisplayedCountUubd;
          b22IndexGjva++
        ) {
          b22TrackNotificationImpressionScoo(b22PayloadWfie.value);
        }
      }
    }
  }

  void b22TrackNotificationClickHlms(String? b22EventSourceMkfk) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.inform_c,
      b22ParametersErwm: {'sourse': b22EventSourceMkfk},
    );
  }

  void b22TrackNotificationImpressionScoo(String b22EventSourceSoqp) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.push,
      b22ParametersErwm: {'sourse': b22EventSourceSoqp},
    );
  }

  Future<bool> b22IsInitializationAllowedCgbv() async {
    if (!B22AudienceQualificationOrchestratorCaap
        .b22InstanceWcsm
        .isEligibleUser) {
      return false;
    }
    final bool b22SamsungDeviceJstf = await FlutterBoomNotificationPlugins
        .instance
        .isSamsungDevice();
    final bool b22KoreanLocaleUnvf = await FlutterBoomNotificationPlugins
        .instance
        .isKoreanLocale();
    if (b22SamsungDeviceJstf &&
        b22KoreanLocaleUnvf &&
        !B22CloudOrchestratorRhpr
            .b22InstanceBbui
            .b22SupportsKoreanNotificationsCxeq) {
      return false;
    }
    return true;
  }
}
