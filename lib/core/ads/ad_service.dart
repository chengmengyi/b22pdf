import 'dart:convert';
import 'package:b21pdf/core/ads/ad_scene.dart';
import 'package:b21pdf/core/ads/ad_placement.dart';
import 'package:b21pdf/core/storage/preferences/ad_switch_cache.dart';
import 'package:b21pdf/core/storage/preferences/firebase_ad_config_cache.dart';
import 'package:b21pdf/core/storage/preferences/last_ad_show_time_cache.dart';
import 'package:b21pdf/core/storage/preferences/last_open_ad_close_time.dart';
import 'package:b21pdf/core/storage/preferences/load_new_launch_ad_cache.dart';
import 'package:b21pdf/core/analytics/analytics_event.dart';
import 'package:b21pdf/core/analytics/analytics_service.dart';
import 'package:b21pdf/core/user/user_eligibility_service.dart';
import 'package:b21pdf/core/firebase/firebase_service.dart';
import 'package:b21pdf/core/config/app_config.dart';
import 'package:b21pdf/features/startup/services/startup_interaction_gate.dart';
import 'package:b21pdf/features/notifications/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_check_af_new/flutter_check_af_new.dart';
import 'package:flutter_pdf_ad_plugins/flutter_pdf_ad_plugins.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:appsflyer_sdk_plus/appsflyer_sdk.dart';

class AdService implements FlutterPdfAdListener {
  static final AdService _adUtilsInstance = AdService._();

  AdService._();

  bool loadNewLaunchAd = false;
  int _lastShowCachedSceneAdTime = 0;

  static AdService get instance => _adUtilsInstance;

  final List<AdScene> _startupPreloadAdScenes = <AdScene>[];
  final Set<AdScene> _noReloadAfterCloseAdScenes = <AdScene>{
    AdScene.pr_new_launch,
  };

  Future<void> initialize() async {
    _configureStartupPreloadScenes();
    FlutterPdfAdPlugins.instance.setListener(this);
    FlutterPdfAdPlugins.instance.initializeAdmob();
    final UmpConsentResult umpConsentResult = await FlutterPdfAdPlugins.instance
        .handleUmpConsent();
    if (!umpConsentResult.canRequestAds) {
      return;
    }
    // FlutterPdfAdPlugins.instance.updateDebugPaidRevenueRange(
    //   minRevenue: 100,
    //   maxRevenue: 200,
    // );
    FlutterPdfAdPlugins.instance.updateInterstitialLikeNativePlacements(
      const <AdScene>[AdScene.pr_user_use],
    );
    FlutterPdfAdPlugins.instance.updateSmallTemplateNativePlacements(
      const <AdScene>[AdScene.pr_ban1, AdScene.pr_ban2, AdScene.pr_ban3],
    );
    FlutterPdfAdPlugins.instance.updateSkipReloadAfterClosePlacements(
      _noReloadAfterCloseAdScenes,
    );
    await refreshRemoteAdConfig();
    await FlutterPdfAdPlugins.instance.initPlugins(
      distinctId: await FlutterTbaInfo.instance.getDistinctId(),
      fengKongLogic: () {
        return false;
      },
      smallNativeAdLayoutName: 'native_ad_layout',
    );
    await _preloadStartupAdScenes();
  }

  Future<void> _preloadStartupAdScenes() async {
    final List<Future<void>> startupPreloadTasks = _startupPreloadAdScenes
        .map(_preloadAdScenePlacement)
        .toList(growable: false);
    await Future.wait(startupPreloadTasks);
  }

  Future<void> _preloadAdScenePlacement(
    AdScene adScene, {
    AdPlacement? adPosId,
  }) async {
    try {
      await _loadStartupSceneWithoutShield(adScene);
    } catch (_) {
      return;
    }
  }

  Future<void> preloadScene(AdScene adScene) async {
    await Future.wait(<Future<void>>[_preloadAdScenePlacement(adScene)]);
  }

  Future<void> forceLoadScene({
    required AdScene adScene,
    required AdPlacement adPosId,
  }) async {
    try {
      await FlutterPdfAdPlugins.instance.loadPlacement<AdScene>(
        adScene,
        force: true,
        placementLabelBuilder: (AdScene scene) => scene.name,
      );
    } catch (_) {}
  }

  Future<Widget?> takeDocumentListNativeAd({
    bool loadIfNeeded = true,
    bool reloadAfterTake = false,
    Duration disposeDelay = const Duration(seconds: 2),
  }) async {
    return FlutterPdfAdPlugins.instance.takeCachedAdWidget<AdScene>(
      AdScene.pr_ban1,
      adPosId: AdPlacement.pr_main_banner1,
      loadIfNeeded: loadIfNeeded,
      reloadAfterTake: reloadAfterTake,
      disposeDelay: disposeDelay,
    );
  }

  Future<Widget?> buildCachedNativeAd({
    required AdScene adScene,
    required AdPlacement adPosId,
  }) async {
    return FlutterPdfAdPlugins.instance.buildCachedAdWidget<AdScene>(
      adScene,
      adPosId: adPosId,
    );
  }

  Future<bool> hasDocumentListNativeAd() {
    return hasCachedAd(
      adScene: AdScene.pr_ban1,
      adPosId: AdPlacement.pr_main_banner1,
    );
  }

  Future<void> loadDocumentListNativeAd() async {
    await FlutterPdfAdPlugins.instance.loadPlacement<AdScene>(
      AdScene.pr_ban1,
      force: true,
      placementLabelBuilder: (AdScene adScene) => adScene.name,
    );
  }

  Future<void> _loadStartupSceneWithoutShield(AdScene adScene) async {
    await FlutterPdfAdPlugins.instance.loadPlacement<AdScene>(
      adScene,
      placementLabelBuilder: (AdScene adPlacement) => adPlacement.name,
    );
  }

  void _configureStartupPreloadScenes() {
    _startupPreloadAdScenes.clear();
    _startupPreloadAdScenes.add(AdScene.pr_launch);
    _startupPreloadAdScenes.add(AdScene.pr_ban1);
    if (UserEligibilityService.instance.isEligibleUser) {
      _startupPreloadAdScenes.add(AdScene.pr_ban2);
      _startupPreloadAdScenes.add(AdScene.pr_exit);
    }
    loadNewLaunchAd = LoadNewLaunchAdCache.readEnabled();
    if (loadNewLaunchAd) {
      LoadNewLaunchAdCache.saveEnabled(false);
      _startupPreloadAdScenes.add(AdScene.pr_new_launch);
    }
  }

  Future<void> refreshRemoteAdConfig() async {
    final dynamic adConfigMap = await _loadAdConfiguration();
    final Map<AdScene, List<AdInfoBean>> parsedAdConfig =
        <AdScene, List<AdInfoBean>>{};
    if (adConfigMap is Map) {
      adConfigMap.forEach((dynamic configSceneKey, dynamic configListValue) {
        final AdScene? configAdScene = _findSceneByConfigKey('$configSceneKey');
        if (configAdScene == null || configListValue is! List) {
          return;
        }
        final List<AdInfoBean> sceneAdConfigs = parsedAdConfig.putIfAbsent(
          configAdScene,
          () => <AdInfoBean>[],
        );
        for (final dynamic configItem in configListValue) {
          if (configItem is! Map) {
            continue;
          }
          sceneAdConfigs.add(
            AdInfoBean.fromPlacementJson(Map<String, dynamic>.from(configItem)),
          );
        }
      });
    }
    FlutterPdfAdPlugins.instance.updateConfigs<AdScene>(
      parsedAdConfig,
      placementLabelBuilder: (AdScene adScene) => adScene.name,
    );
  }

  void updateFacebookPlacementConfig(String pdfAdfb) {
    try {
      final dynamic adConfigMap = jsonDecode(pdfAdfb);
      final Map<AdScene, List<AdInfoBean>> parsedAdConfig =
          <AdScene, List<AdInfoBean>>{};
      if (adConfigMap is Map) {
        adConfigMap.forEach((dynamic configSceneKey, dynamic configListValue) {
          final AdScene? configAdScene = _findSceneByConfigKey(
            '$configSceneKey',
          );
          if (configAdScene == null || configListValue is! List) {
            return;
          }
          final List<AdInfoBean> sceneAdConfigs = parsedAdConfig.putIfAbsent(
            configAdScene,
            () => <AdInfoBean>[],
          );
          for (final dynamic configItem in configListValue) {
            if (configItem is! Map) {
              continue;
            }
            sceneAdConfigs.add(
              AdInfoBean.fromPlacementJson(
                Map<String, dynamic>.from(configItem),
              ),
            );
          }
        });
      }
      FlutterPdfAdPlugins.instance.updateFacebookConfigs<AdScene>(
        parsedAdConfig,
        placementLabelBuilder: (AdScene adScene) => adScene.name,
      );
    } catch (_) {}
  }

  AdScene? _findSceneByConfigKey(String configKey) {
    try {
      return AdScene.values.byName(configKey);
    } catch (error) {
      return null;
    }
  }

  Future<dynamic> _loadAdConfiguration() async {
    try {
      final String storedAdConfig = FirebaseAdConfigCache.readConfig();
      if (storedAdConfig.isNotEmpty) {
        return jsonDecode(storedAdConfig);
      }
      return jsonDecode(await _loadBundledAdConfiguration());
    } catch (error) {
      return jsonDecode(await _loadBundledAdConfiguration());
    }
  }

  Future<String> _loadBundledAdConfiguration() async {
    final String encryptedLocalAdConfig = await rootBundle.loadString(
      AppConfig.localAdConfig,
    );
    return encryptedLocalAdConfig;
  }

  Future<bool?> showCachedAd({
    required AdScene adScene,
    required AdPlacement adPosId,
    BuildContext? adHostContext,
    bool uploadChance = true,
    bool ignoreCooldown = false,
  }) async {
    if (FlutterPdfAdPlugins.instance.isShowingAd()) {
      return false;
    }
    if (!await isPlacementEnabled(adPosId)) {
      return false;
    }
    if (!ignoreCooldown &&
        !_shouldIgnoreCooldown(adScene: adScene, adPosId: adPosId)) {
      return false;
    }
    final int currentShowCachedSceneAdTime =
        DateTime.now().millisecondsSinceEpoch;
    final int lastShowCachedSceneAdInterval = _lastShowCachedSceneAdTime <= 0
        ? -1
        : currentShowCachedSceneAdTime - _lastShowCachedSceneAdTime;
    _lastShowCachedSceneAdTime = currentShowCachedSceneAdTime;
    if (uploadChance) {
      trackAdOpportunity(adScene: adScene, adPosId: adPosId);
    }
    try {
      final bool hasCachedAd = await _hasCachedAdForSceneAndPlacement(
        adScene: adScene,
        adPosId: adPosId,
      );
      if (!hasCachedAd) {
        AnalyticsService.instance.trackEvent(
          pointType: AnalyticsEvent.show_ad_no_cache,
          parameters: {
            "ad_context": adScene.name,
            "ad_pos_id": adPosId.name,
            "last_time": lastShowCachedSceneAdInterval,
          },
        );
        if (_noReloadAfterCloseAdScenes.contains(adScene)) {
          return false;
        }
        _preloadAdScenePlacement(adScene, adPosId: adPosId);
        return false;
      }
      final BuildContext? validAdHostContext = adHostContext;
      if (validAdHostContext != null && !validAdHostContext.mounted) {
        return false;
      }
      final bool? didShowCachedAd = await FlutterPdfAdPlugins.instance
          .showCachedAd<AdScene>(
            adScene,
            adPosId: adPosId,
            context: validAdHostContext,
          );
      return didShowCachedAd;
    } catch (error, stackTrace) {
      debugPrint('show cached placement error: scene=$adScene, error=$error');
      debugPrint(stackTrace.toString());
      return false;
    }
  }

  Future<bool> isPlacementEnabled(AdPlacement adPosId) async {
    try {
      String switchConfig = AdSwitchCache.readConfig();
      if (switchConfig.isEmpty) {
        switchConfig = await rootBundle.loadString(AppConfig.localAdSwitch);
      }
      final dynamic switchJson = jsonDecode(switchConfig);
      if (switchJson is! Map<String, dynamic>) {
        return true;
      }
      final dynamic switchValue = switchJson[adPosId.name];
      return switchValue != 0;
    } catch (_) {
      return true;
    }
  }

  void trackAdOpportunity({
    required AdScene adScene,
    required AdPlacement adPosId,
  }) {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_chance,
      parameters: {"ad_context": adScene.name, "ad_pos_id": adPosId.name},
    );
  }

  Future<bool> hasCachedAd({
    required AdScene adScene,
    required AdPlacement adPosId,
  }) {
    return _hasCachedAdForSceneAndPlacement(adScene: adScene, adPosId: adPosId);
  }

  Future<void> preloadEligibleUserAds() async {
    if (!UserEligibilityService.instance.isEligibleUser) {
      return;
    }
    preloadScene(AdScene.pr_exit);
    preloadScene(AdScene.pr_ban2);
  }

  bool _shouldIgnoreCooldown({
    required AdScene adScene,
    required AdPlacement adPosId,
  }) {
    final bool isBPackage = UserEligibilityService.instance.isEligibleUser;
    final bool shouldCheckCooldown =
        !isBPackage ||
        <AdPlacement>{
          AdPlacement.pr_up_int,
          AdPlacement.pr_down_int,
          AdPlacement.pr_readback,
          AdPlacement.pr_exit_app,
        }.contains(adPosId);
    if (!shouldCheckCooldown) {
      debugPrint(
        'showLifecycleAd cooldown scene=${adScene.name}, '
        'posid=${adPosId.name}, canShow=true, '
        'cooldownMs=0, intervalMs=-1, reason=no-cooldown',
      );
      return true;
    }
    final int lastShowTimeMs = LastAdShowTimeCache.readTime();
    final int cooldownSeconds = isBPackage
        ? FirebaseService.instance.adCooldownSeconds
        : FirebaseService.instance.secondaryAdCooldownSeconds;
    final int cooldownMs = cooldownSeconds * 1000;
    if (lastShowTimeMs <= 0) {
      debugPrint(
        'showLifecycleAd cooldown scene=${adScene.name}, '
        'posid=${adPosId.name}, canShow=true, '
        'cooldownMs=$cooldownMs, intervalMs=-1, '
        'reason=no-last-show',
      );
      return true;
    }
    final int nowMs = DateTime.now().millisecondsSinceEpoch;
    final int showIntervalMs = nowMs - lastShowTimeMs;
    final bool canShow = showIntervalMs >= cooldownMs;
    debugPrint(
      'showLifecycleAd cooldown scene=${adScene.name}, '
      'posid=${adPosId.name}, canShow=$canShow, '
      'cooldownMs=$cooldownMs, '
      'intervalMs=$showIntervalMs',
    );
    return canShow;
  }

  Future<bool> _hasCachedAdForSceneAndPlacement({
    required AdScene adScene,
    required AdPlacement adPosId,
  }) async {
    try {
      final AdInfoBean? cachedAdInfo = await FlutterPdfAdPlugins.instance
          .getAvailableCachedAdInfo<AdScene>(adScene);
      return cachedAdInfo != null;
    } catch (error, stackTrace) {
      debugPrint('HasAvailableCachedAd catch scene=$adScene, error=$error');
      debugPrint(stackTrace.toString());
      return false;
    }
  }

  @override
  void onAdClicked(
    Object adPlacement,
    AdInfoBean adInfo,
    Object adPosId,
    String adNetwork,
    String adSourceName,
  ) {
    NotificationService.instance.showAdFollowUpNotification();
    if (adPlacement is! AdScene) {
      return;
    }
    if (adPosId is! AdPlacement) {
      return;
    }
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_click,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "ad_pos_id": adPosId.name,
        "ad_network": adNetwork,
        "ad_source_client": adInfo.adPlat,
      },
    );
  }

  @override
  void onAdClosed(
    Object adPlacement,
    AdInfoBean adInfo,
    Object adPosId,
    String adNetwork,
    String adSourceName,
  ) {
    if (adInfo.parsedAdType?.isFullScreen == true) {
      LastAdShowTimeCache.saveTime(
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }
    if (adPlacement is! AdScene) {
      return;
    }
    _saveLastOpenAdCloseTime(adPlacement);
    if (adPosId is! AdPlacement) {
      return;
    }
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_close,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "ad_pos_id": adPosId.name,
        "ad_network": adNetwork,
        "ad_source_client": adInfo.adPlat,
      },
    );
  }

  void _saveLastOpenAdCloseTime(AdScene adPlacement) {
    if (adPlacement != AdScene.pr_new_launch &&
        adPlacement != AdScene.pr_launch) {
      return;
    }
    LastOpenAdCloseTime.saveTime(DateTime.now().millisecondsSinceEpoch);
  }

  @override
  void onAdPaidEvent(
    Object adPlacement,
    Object adPosId,
    double revenue,
    String currencyCode,
    String adNetwork,
    String precisionType,
    AdInfoBean adInfo,
  ) {
    if (adPlacement is! AdScene) {
      return;
    }
    if (adPosId is! AdPlacement) {
      return;
    }
    if (revenue >= 0.01) {
      FirebaseService.instance.logAnalyticsEvent(
        name: AnalyticsEvent.pr_total_001_revenue.name,
        parameters: {"currency": currencyCode, "value": revenue},
      );
      AnalyticsService.instance.trackEvent(
        pointType: AnalyticsEvent.pr_total_001_revenue,
        parameters: {
          "ad_context": adPlacement.name,
          "ad_pos_id": adPosId.name,
          "ad_format": adInfo.adType,
          "ad_code_id": adInfo.adId,
          "currency": currencyCode,
          "value": revenue,
          "ad_network": adNetwork,
          "ad_source_client": adInfo.adPlat,
        },
      );
    }

    FlutterCheckAf.instance.uploadAdRevenue(
      adNetwork,
      revenue,
      adInfo.adId ?? "",
      adPlacement.name,
      AFMediationNetwork.googleAdMob,
      currencyCode,
    );

    FirebaseService.instance.logFacebookPurchase(revenue, currencyCode);

    FirebaseService.instance.logAnalyticsEvent(
      name: AnalyticsEvent.ad_impression_revenue.name,
      parameters: {"currency": currencyCode, "value": revenue},
    );
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_impression_revenue,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_pos_id": adPosId.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "currency": currencyCode,
        "value": revenue,
        "ad_network": adNetwork,
        "ad_source_client": adInfo.adPlat,
      },
    );

    AnalyticsService.instance.trackAdRevenue(
      adInfo: adInfo,
      adScene: adPlacement,
      positionId: adPosId,
      revenue: revenue,
      currency: currencyCode,
      adNetwork: adNetwork,
      precision: precisionType,
    );
  }

  @override
  void onAdRequestFailure(
    Object adPlacement,
    AdInfoBean adInfo,
    String failReason,
    String adNetwork,
    String adSourceName,
    double loadDurationSeconds,
  ) {
    if (adPlacement is! AdScene) {
      return;
    }
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_load_fail,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "error_message": failReason,
        "ad_source_client": adInfo.adPlat,
        "ad_network": adNetwork,
        "load_time": loadDurationSeconds,
      },
    );
  }

  @override
  void onAdRequestStart(Object adPlacement, AdInfoBean adInfo) {
    if (adPlacement is! AdScene) {
      return;
    }
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_request,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "ad_source_client": adInfo.adPlat,
      },
    );
  }

  @override
  void onAdRequestSuccess(
    Object adPlacement,
    AdInfoBean adInfo,
    String adNetwork,
    String adSourceName,
    double loadDurationSeconds,
  ) {
    if (adPlacement is! AdScene) {
      return;
    }
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_load_success,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "ad_source_client": adInfo.adPlat,
        "ad_network": adNetwork,
        "load_time": loadDurationSeconds,
      },
    );
  }

  @override
  void onAdShowFailure(
    Object adPlacement,
    AdInfoBean adInfo,
    Object adPosId,
    String adNetwork,
    String adSourceName,
    String errorMessage,
  ) {
    if (adPlacement is! AdScene) {
      return;
    }
    if (adPosId is! AdPlacement) {
      return;
    }
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_show_fail,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "ad_pos_id": adPosId.name,
        "ad_network": adNetwork,
        "ad_source_client": adInfo.adPlat,
        "error_message": errorMessage,
      },
    );
  }

  @override
  void onAdShowStart(
    Object adPlacement,
    AdInfoBean adInfo,
    Object adPosId,
    String adNetwork,
    String adSourceName,
  ) {
    if (adPlacement is! AdScene) {
      return;
    }
    if (adPosId is! AdPlacement) {
      return;
    }
    StartupInteractionGate.instance.markLauncherAdShownIfMatched(
      adScene: adPlacement,
      adPosId: adPosId,
    );
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ad_show,
      parameters: {
        "ad_context": adPlacement.name,
        "ad_format": adInfo.adType,
        "ad_code_id": adInfo.adId,
        "ad_pos_id": adPosId.name,
        "ad_network": adNetwork,
        "ad_source_client": adInfo.adPlat,
        "ad_source": FirebaseService.instance.adConfigSource,
      },
    );
  }

  @override
  void onAdShowSuccess(
    Object adPlacement,
    AdInfoBean adInfo,
    Object adPosId,
    String adNetwork,
    String adSourceName,
  ) {
    if (adPlacement is! AdScene) {
      return;
    }
    if (adPosId is! AdPlacement) {
      return;
    }
  }

  @override
  void onAdmobInitialized() {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.sdk_initialization,
    );
  }

  @override
  void onTachi25OneDayRevenueEvent(String eventName) {}

  @override
  void onTachi25TotalRevenueEvent(String eventName) {}

  @override
  void onUmpConsentCanRequestAds(bool canRequestAds) {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.can_request_ads,
      parameters: {"canRequest": canRequestAds ? 1 : 0},
    );
  }

  @override
  void onUmpConsentFlowComplete(UmpConsentResult result) {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.consent_status_update,
      parameters: {
        "countryCode": result.countryCode,
        "requiresCmpByLocale": result.requiresCmpByLocale,
        "purpose_ads": result.canRequestAds,
        "result": result.consentStatus.name,
        "privacyOptionsRequirementStatus":
            result.privacyOptionsRequirementStatus.name,
        "formError":
            "code:${result.formError?.errorCode},message:${result.formError?.message}",
      },
    );
  }

  @override
  void onUmpConsentFlowStart(String countryCode, bool requiresCmpByLocale) {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.consent_flow_trigger,
      parameters: {
        "countryCode": countryCode,
        "requiresCmp": requiresCmpByLocale,
      },
    );
  }

  @override
  void onUmpConsentFormShow() {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.consent_ui_show,
    );
  }

  @override
  void onUmpFormLoad() {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ump_form_load,
    );
  }

  @override
  void onUmpFormRequest() {
    AnalyticsService.instance.trackEvent(
      pointType: AnalyticsEvent.ump_form_request,
    );
  }

  @override
  void onUserGroupResolved(int userGroup) {
    AnalyticsService.instance.addUserGroup(userGroup);
  }
}
