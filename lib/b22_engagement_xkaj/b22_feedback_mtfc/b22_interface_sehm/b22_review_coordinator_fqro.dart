import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class B22ReviewCoordinatorErib extends B22FoundationCoordinatorXsba {
  static const String b22StarBuilderIdWxss = 'comment_rating_builder';

  int b22StarCountGjde = 0;
  bool b22ClosingDialogQmrx = false;

  @override
  void onInit() {
    super.onInit();
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22RatingPopVWwpv,
    );
  }

  void b22OnStarPressedFxtt(int b22IndexOamm) {
    b22StarCountGjde = b22IndexOamm + 1;
    update(<Object>[b22StarBuilderIdWxss]);
  }

  Future<void> b22OnRateUsPressedQhjc() async {
    b22StarCountGjde = 5;
    update(<Object>[b22StarBuilderIdWxss]);
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22RatingPopCRazw,
    );
    await b22OpenGooglePlayTgek();
  }

  Future<void> b22OnClosePressedPvmt() async {
    B22ApplicationRouterJfva.b22BackCwkm<bool>(b22ResultNvsq: false);
  }

  Future<void> b22OpenGooglePlayTgek() async {
    final String b22PackageNameRmwi = await FlutterTbaInfo.instance
        .getBundleId();
    final Uri b22MarketUriSkcr = Uri.parse(
      'market://details?id=$b22PackageNameRmwi',
    );
    final Uri b22WebUriData = Uri.https(
      'play.google.com',
      '/store/apps/details',
      <String, String>{'id': b22PackageNameRmwi},
    );
    if (await canLaunchUrl(b22MarketUriSkcr)) {
      await launchUrl(b22MarketUriSkcr, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(b22WebUriData, mode: LaunchMode.externalApplication);
    }
    if (Get.isBottomSheetOpen == true) {
      B22ApplicationRouterJfva.b22BackCwkm<bool>(b22ResultNvsq: true);
    }
  }
}
