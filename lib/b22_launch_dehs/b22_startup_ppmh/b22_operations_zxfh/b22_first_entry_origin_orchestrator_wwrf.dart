import 'package:flutter_local_notification_plugins/flutter_local_notification_plugins.dart';

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
        await FlutterLocalNotificationPlugins.instance
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
      b22TimerOverlayClickEventEvqt = await FlutterLocalNotificationPlugins
          .instance
          .consumeTimerOverlayClickEvent();
    } catch (_) {}
  }
}
