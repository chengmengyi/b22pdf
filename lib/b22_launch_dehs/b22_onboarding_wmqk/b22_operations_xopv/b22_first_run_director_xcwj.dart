import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_language_choice_zfoo.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_overlay_permission_prompt_date_store_akye.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_guide_completion_store_xqve.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_interface_brpn/b22_locale_chooser_coordinator_yrhs.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_interface_ozan/b22_permission_uawu/b22_alert_access_coordinator_ypyk.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:get/get.dart';

class B22FirstRunDirectorYxjn {
  static final B22FirstRunDirectorYxjn b22InstanceCygx =
      B22FirstRunDirectorYxjn();
  static B22FirstRunDirectorYxjn get instance => b22InstanceCygx;

  //语言选择页没有点确定----启动app：悬浮窗->语言选择页->引导页->通知->首页
  //语言选择页点确定----启动app：悬浮窗->引导页->通知->首页
  Future<void> b22OpenOverlaySelectionRoen() async {
    var b22CheckOverlayPermissionHswh = await FlutterBoomNotificationPlugins
        .instance
        .checkOverlayPermission();
    final DateTime b22NowOqfx = DateTime.now();
    final String b22TodayRrmq =
        '${b22NowOqfx.year.toString().padLeft(4, '0')}-'
        '${b22NowOqfx.month.toString().padLeft(2, '0')}-'
        '${b22NowOqfx.day.toString().padLeft(2, '0')}';
    final bool b22ShownOverlayPermissionTodayEhrk =
        B22OverlayPermissionPromptDateStoreHqaz.b22ReadDateHmwc() ==
        b22TodayRrmq;
    if (!b22CheckOverlayPermissionHswh && !b22ShownOverlayPermissionTodayEhrk) {
      await B22OverlayPermissionPromptDateStoreHqaz.b22SaveDateJrko(
        b22TodayRrmq,
      );
      B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
        b22RouteNameSrbn:
            B22ApplicationDestinationsMcbk.b22OverlayPermissionRouteGvjt,
      );
      return;
    }
    b22OpenLanguageSelectionClql();
  }

  void b22OpenLanguageSelectionClql() {
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
    b22OpenGuideJqva();
  }

  void b22OpenGuideJqva() {
    if (!B22GuideCompletionStorePqaz.b22ReadCompletedLwmc()) {
      B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
        b22RouteNameSrbn: B22ApplicationDestinationsMcbk.b22GuideRouteVqme,
      );
      return;
    }
    b22ToPageOpenNotificationPermissionVhup();
  }

  Future<void> b22ToPageOpenNotificationPermissionVhup() async {
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

  void b22OpenHomeSzxy() {
    B22ApplicationRouterJfva.b22ReplaceNamedGvtg<void>(
      b22RouteNameSrbn: B22ApplicationDestinationsMcbk.b22HomeRouteEdoo,
    );
  }
}
