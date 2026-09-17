import 'dart:async';

import 'package:b21pdf/core/ads/ad_placement.dart';
import 'package:b21pdf/core/ads/ad_scene.dart';
import 'package:b21pdf/core/ads/ad_service.dart';
import 'package:b21pdf/core/events/app_event.dart';
import 'package:b21pdf/core/events/app_event_type.dart';
import 'package:b21pdf/core/navigation/app_navigator.dart';
import 'package:b21pdf/core/presentation/base_controller.dart';

class OpenAdLoadingController extends BaseController {
  static const String progressUpdateId = 'open_ad_loading_progress';
  static const Duration maximumWait = Duration(seconds: 15);
  static const Duration tickInterval = Duration(milliseconds: 100);
  static const Duration cacheCheckInterval = Duration(milliseconds: 500);

  AdScene? adScene;
  AdPlacement? adPosId;
  double progress = 0;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _lastCacheCheck = Duration.zero;
  bool _checkingCache = false;
  bool _finished = false;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> arguments = AppNavigator.routeArguments();
    final Object? sceneArgument = arguments['adScene'];
    final Object? posIdArgument = arguments['adPosId'];
    if (sceneArgument is AdScene && posIdArgument is AdPlacement) {
      adScene = sceneArgument;
      adPosId = posIdArgument;
    }
    if (adScene == null || adPosId == null) {
      Future<void>.delayed(Duration.zero, () => _finish(cacheReady: false));
      return;
    }
    _stopwatch.start();
    _timer = Timer.periodic(tickInterval, (_) => _onTick());
    unawaited(
      AdService.instance.forceLoadScene(adScene: adScene!, adPosId: adPosId!),
    );
    unawaited(_checkCache());
  }

  void _onTick() {
    if (_finished) {
      return;
    }
    progress = (_stopwatch.elapsedMilliseconds / maximumWait.inMilliseconds)
        .clamp(0.0, 1.0);
    update(<String>[progressUpdateId]);
    if (_stopwatch.elapsed >= maximumWait) {
      _finish(cacheReady: false);
      return;
    }
    if (_stopwatch.elapsed - _lastCacheCheck >= cacheCheckInterval) {
      unawaited(_checkCache());
    }
  }

  Future<void> _checkCache() async {
    if (_checkingCache || _finished || adScene == null || adPosId == null) {
      return;
    }
    _checkingCache = true;
    _lastCacheCheck = _stopwatch.elapsed;
    try {
      final bool hasCachedAd = await AdService.instance.hasCachedAd(
        adScene: adScene!,
        adPosId: adPosId!,
      );
      if (hasCachedAd && !_finished) {
        progress = 1;
        update(<String>[progressUpdateId]);
        _finish(cacheReady: true);
      }
    } finally {
      _checkingCache = false;
    }
  }

  void _finish({required bool cacheReady}) {
    if (_finished) {
      return;
    }
    _finished = true;
    _timer?.cancel();
    _timer = null;
    _stopwatch.stop();
    AppNavigator.back<bool>(result: cacheReady);
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  void onAppEvent(AppEvent event) {
    if (event.type == AppEventType.appLifecycle && event.intValue == 1) {
      _finish(cacheReady: false);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.stop();
    super.onClose();
  }
}
