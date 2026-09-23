import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_language_choice_zfoo.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_interface_brpn/b22_locale_chooser_coordinator_yrhs.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_interface_ozan/b22_permission_uawu/b22_alert_access_coordinator_ypyk.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class B22FirstRunDirectorYxjn {
  static final B22FirstRunDirectorYxjn b22InstanceCygx =
      B22FirstRunDirectorYxjn();
  static B22FirstRunDirectorYxjn get instance => b22InstanceCygx;

  //语言选择页没有点确定----启动app：悬浮窗->语言选择页->通知->首页
  //语言选择页点确定----启动app：悬浮窗->通知->首页
  b22OpenOverlaySelectionRoen() async {
    var b22CheckOverlayPermissionHswh = await FlutterBoomNotificationPlugins
        .instance
        .checkOverlayPermission();
    if (!b22CheckOverlayPermissionHswh) {
      B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
        b22RouteNameSrbn:
            B22ApplicationDestinationsMcbk.b22OverlayPermissionRouteGvjt,
      );
      return;
    }
    b22OpenLanguageSelectionClql();
  }

  //语言选择页没有点确定----启动app：语言选择页->通知->首页
  //语言选择页点确定----启动app：通知->首页
  b22OpenLanguageSelectionClql() {
    if (B22LanguageChoiceDsdt.b22ReadLanguagePgwy().isEmpty) {
      if (Get.isRegistered<B22LocaleChooserCoordinatorAegb>()) {
        B22ApplicationRouterJfva.b22PopUntilRouteUmkj(
          B22ApplicationDestinationsMcbk.b22ChooseLanguageRouteDfsy,
        );
      } else {
        B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
          b22RouteNameSrbn:
              B22ApplicationDestinationsMcbk.b22ChooseLanguageRouteDfsy,
        );
      }
      return;
    }
    b22ToPageOpenNotificationPermissionVhup();
  }

  b22ToPageOpenNotificationPermissionVhup() async {
    var b22ResultIgyt = await B22AlertOrchestratorNazk.b22InstanceOxzc
        .b22HasNotificationPermissionAqao();
    if (!b22ResultIgyt) {
      if (Get.isRegistered<B22AlertAccessCoordinatorVaez>()) {
        B22ApplicationRouterJfva.b22PopUntilRouteUmkj(
          B22ApplicationDestinationsMcbk.b22NotificationRouteOwvv,
        );
      } else {
        B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
          b22RouteNameSrbn:
              B22ApplicationDestinationsMcbk.b22NotificationRouteOwvv,
        );
      }
      return;
    }
    b22OpenHomeSzxy();
  }

  b22OpenHomeSzxy() {
    B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
      b22RouteNameSrbn: B22ApplicationDestinationsMcbk.b22HomeRouteEdoo,
    );
  }
}
