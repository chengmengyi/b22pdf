import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_permissions_fems/b22_access_orchestrator_hlvl.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_install_module_store_tsjc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:permission_handler/permission_handler.dart';

enum B22FileCategoryVdhm {
  all("All"),
  pdf("PDF"),
  word("Word"),
  excel("Excel");

  final String b22LabelOamr;

  const B22FileCategoryVdhm(this.b22LabelOamr);
}

class B22ArchiveSectionCoordinatorMvvw extends B22FoundationCoordinatorXsba {
  final TextEditingController b22TextEditingControllerCekd =
      TextEditingController();
  final FocusNode b22SearchFocusNodeEkvn = FocusNode();
  final PageController b22PageControllerMpft = PageController();
  int b22SelectedTabIndexZhwn = 0;
  bool b22IsSearchingLhcy = false;
  bool b22ShowAddWidgetEfxk = !B22InstallModuleStoreLldu.b22ReadAddedHbyd();
  bool b22RequestingStoragePermissionIwib = false;

  @override
  void onReady() {
    super.onReady();
    b22RequestDocumentStoragePermissionYlbo();
  }

  void b22SelectCategoryGtlv(B22FileCategoryVdhm b22CategoryMwsa) {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22FileFilterClickOgtp,
    );
    b22PageControllerMpft.animateToPage(
      b22CategoryMwsa.index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void b22OnPageChangedZjnw(int b22IndexNwsy, BuildContext b22ContextRnjg) {
    if (b22SelectedTabIndexZhwn == b22IndexNwsy) return;
    b22SelectedTabIndexZhwn = b22IndexNwsy;
    update();
    B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
      b22AdSceneHfhk: B22PromotionContextSuaj.pr_user_use,
      b22AdPosIdEjxk: B22PromotionSlotZwla.pr_up_int,
      b22AdHostContextQqxr: b22ContextRnjg,
    );
  }

  void b22ShowSearchInputRita() {
    b22IsSearchingLhcy = true;
    update();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      b22SearchFocusNodeEkvn.requestFocus();
    });
  }

  void b22UpdateFileSearchQueryImpe(String b22KeywordWckr) {
    B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
      B22ApplicationSignalXfvp(
        b22TypeIafj: B22ApplicationSignalKindJiwh.b22FileSearchQefh,
        b22StringValueNvbm: b22KeywordWckr,
      ),
    );
    if (b22KeywordWckr.isEmpty) {
      b22IsSearchingLhcy = false;
      b22SearchFocusNodeEkvn.unfocus();
      update();
    }
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  void onAppEvent(B22ApplicationSignalXfvp b22EventWarn) {
    if (b22EventWarn.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22WidgetAddedHjvu) {
      b22ShowAddWidgetEfxk = false;
      update();
    } else if (b22EventWarn.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22StoragePermissionRequestLzlq) {
      b22RequestDocumentStoragePermissionYlbo();
    }
  }

  Future<void> b22RequestDocumentStoragePermissionYlbo() async {
    if (b22RequestingStoragePermissionIwib) return;
    b22RequestingStoragePermissionIwib = true;
    try {
      final Permission b22PermissionChof =
          await b22ResolveRequiredStoragePermissionZuyg();
      final B22AccessOutcomeGgzz b22ResultRyur = await B22AccessOrchestratorRwgw
          .b22InstanceWzjp
          .b22RequestPermissionVmnw(b22PermissionUlwh: b22PermissionChof);
      if (b22ResultRyur.b22IsShowPermissionAdTkie) {
        B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
          b22PointTypeDrbi: B22TelemetrySignalDbrq.b22StorageAuthClickIhnh,
        );
        if (B22AudienceQualificationOrchestratorCaap
            .b22InstanceWcsm
            .isEligibleUser) {
          B22PromotionOrchestratorAzwq.instance.b22ShowCachedAdZzrb(
            b22AdSceneHfhk: B22PromotionContextSuaj.pr_launch,
            b22AdPosIdEjxk: B22PromotionSlotZwla.pr_permission_open,
          );
        }
      }
      if (!b22ResultRyur.b22IsGrantedPfwf) return;
      B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
        B22ApplicationSignalXfvp(
          b22TypeIafj:
              B22ApplicationSignalKindJiwh.b22StoragePermissionGrantedUskx,
        ),
      );
    } finally {
      b22RequestingStoragePermissionIwib = false;
    }
  }

  Future<Permission> b22ResolveRequiredStoragePermissionZuyg() async {
    if (!Platform.isAndroid) return Permission.storage;
    final b22AndroidInfoLjuf = await DeviceInfoPlugin().androidInfo;
    return b22AndroidInfoLjuf.version.sdkInt >= 30
        ? Permission.manageExternalStorage
        : Permission.storage;
  }

  void b22RunDebugActionsXknl() async {
    if (!kDebugMode) {
      return;
    }
    FirebaseCrashlytics.instance.crash();
  }

  @override
  void onClose() {
    b22TextEditingControllerCekd.dispose();
    b22SearchFocusNodeEkvn.dispose();
    b22PageControllerMpft.dispose();
    super.onClose();
  }
}
