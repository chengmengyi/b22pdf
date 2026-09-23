import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';

class B22FirstEntryOriginOrchestratorJicy {
  static final B22FirstEntryOriginOrchestratorJicy b22InstanceVyqq =
      B22FirstEntryOriginOrchestratorJicy();
  static B22FirstEntryOriginOrchestratorJicy get instance => b22InstanceVyqq;

  String? b22NotificationPayloadStff;
  String? b22QuickActionTypeMaov;
  TimerOverlayClickEvent? b22TimerOverlayClickEventEvqt;

  void b22RecordShortcutLaunchTlej(String b22ShortcutTypeKnot) {
    b22QuickActionTypeMaov = b22ShortcutTypeKnot;
  }

  Future<void> b22InitializeLwsd() async {
    await Future.wait(<Future<void>>[
      b22InitializeNotificationLaunchSourceYddk(),
      b22InitializeTimerOverlayLaunchSourceHpqg(),
    ]);
  }

  Future<void> b22InitializeNotificationLaunchSourceYddk() async {
    var b22LocalNotificationAppLaunchDetailsAvqx =
        await FlutterBoomNotificationPlugins.instance
            .getNotificationAppLaunchDetails();
    if (b22LocalNotificationAppLaunchDetailsAvqx.didNotificationLaunchApp ==
        true) {
      b22NotificationPayloadStff =
          b22LocalNotificationAppLaunchDetailsAvqx
              .notificationResponse
              ?.payload ??
          b22LocalNotificationAppLaunchDetailsAvqx
              .notificationResponse
              ?.payloadType
              ?.name;
    }
  }

  Future<void> b22InitializeTimerOverlayLaunchSourceHpqg() async {
    try {
      b22TimerOverlayClickEventEvqt = await FlutterBoomNotificationPlugins
          .instance
          .consumeTimerOverlayClickEvent();
    } catch (_) {}
  }
}
