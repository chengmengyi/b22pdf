import 'dart:async';
import 'dart:io';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_language_choice_zfoo.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_document_sort_mhfz/b22_file_ordering_lower_drawer_oxgu.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_document_sort_mhfz/b22_file_ordering_coordinator_dggv.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_orchestrator_ngkh.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_context_fgxs.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_advertising_porl/b22_promotion_slot_ngdi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_identity_fjwe/b22_audience_qualification_orchestrator_tcus.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_qdxm.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_kind_lqge.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_messaging_htgr/b22_application_signal_hub_deqw.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_documents_knao/b22_repository_rzrf/b22_sample_file_catalog_xodk.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_permissions_fems/b22_access_orchestrator_hlvl.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_destinations_crke.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_file_ordering_store_rfuf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_workspace_wbvi/b22_library_uivd/b22_interface_cvrz/b22_library_tab_kczk/b22_archive_section_coordinator_xkbp.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_preview_file/flutter_preview_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:device_info_plus/device_info_plus.dart';

enum B22FileCollectionStatePblk {
  b22NoPermissionIphf,
  b22LoadingQnsm,
  b22LoadedHfay,
}

class B22FileCollectionCoordinatorFigm extends B22FoundationCoordinatorXsba {
  static const int b22NativeAdIntervalBxfl = 4;
  static const Duration b22NativeAdRefreshDurationJhwa = Duration(seconds: 10);
  static const Duration b22ScrollIdleDurationOdhx = Duration(milliseconds: 280);

  final B22FileCategoryVdhm b22TypeTtjd;
  final RefreshController b22RefreshControllerOxrn = RefreshController();
  final ScrollController b22ScrollControllerCiup = ScrollController();
  final Set<int> b22VisibleNativeAdIndexesHdvu = <int>{};
  Timer? b22ScrollIdleTimerMpyp;
  Timer? b22NativeAdRefreshTimerRshc;
  B22FileCollectionStatePblk b22ListStateTnnh =
      B22FileCollectionStatePblk.b22LoadingQnsm;
  List<FileToolsFileInfo> b22AllFilesYbzz = [];
  List<FileToolsFileInfo> b22VisibleFilesIdkf = [];
  FileToolsFileInfo? b22DemoFileInfoYgam;
  String b22SearchTextSurp = '';
  bool b22LoadingFilesVsxz = false;
  bool b22HasLoadedFilesWihb = false;
  bool b22AppInForegroundKvrl = true;
  int? b22ActiveNativeAdIndexHjac;
  int? b22LastChanceNativeAdIndexTytq;
  int b22NativeAdRefreshKeyBrtb = 0;
  int b22LatestListItemCountVdfp = 0;
  bool b22IsListScrollingHsxw = false;
  bool b22IsRefreshingNativeAdOuys = false;
  bool b22NativeAdSwitchEnabledOlne = false;
  late B22OrderingKindDybz b22SortTypeUjob;

  B22FileCollectionCoordinatorFigm({required this.b22TypeTtjd});

  Future<Permission> b22ResolveRequiredStoragePermissionFxme() async {
    if (!Platform.isAndroid) return Permission.storage;
    final b22AndroidInfoBenp = await DeviceInfoPlugin().androidInfo;
    return b22AndroidInfoBenp.version.sdkInt >= 30
        ? Permission.manageExternalStorage
        : Permission.storage;
  }

  @override
  void onInit() {
    b22SortTypeUjob = B22OrderingKindDybz.values.firstWhere(
      (b22ItemTmwi) =>
          b22ItemTmwi.name ==
          B22FileOrderingStoreAikr.b22ReadSortNameMggu(b22TypeTtjd.name),
      orElse: () => B22OrderingKindDybz.b22DateNewWyvg,
    );
    super.onInit();
    b22ScrollControllerCiup.addListener(b22HandleScrollLzpj);
    unawaited(b22InitializeNativeAdSwitchVcmv());
  }

  Future<void> b22InitializeNativeAdSwitchVcmv() async {
    b22NativeAdSwitchEnabledOlne = await B22PromotionOrchestratorAzwq.instance
        .b22IsPlacementEnabledWiqd(B22PromotionSlotZwla.pr_main_banner1);
    if (isClosed) return;
    if (!b22NativeAdSwitchEnabledOlne) {
      b22ClearActiveNativeAdRvkw();
    }
    update();
  }

  bool get canShowNativeAd =>
      b22NativeAdSwitchEnabledOlne &&
      B22AudienceQualificationOrchestratorCaap.b22InstanceWcsm.isEligibleUser &&
      b22VisibleFilesIdkf.length >= b22NativeAdIntervalBxfl;

  bool isNativeAdIndex(int b22IndexHkyc) =>
      (b22IndexHkyc + 1) % (b22NativeAdIntervalBxfl + 1) == 0;

  int fileIndexFromListIndex(int b22IndexPnxh) =>
      b22IndexPnxh - (b22IndexPnxh + 1) ~/ (b22NativeAdIntervalBxfl + 1);

  void b22SyncNativeAdListStateVevu(int b22ItemCountWphm) {
    b22LatestListItemCountVdfp = b22ItemCountWphm;
    b22VisibleNativeAdIndexesHdvu.removeWhere(
      (b22IndexUhfy) => b22IndexUhfy >= b22ItemCountWphm,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isClosed || b22IsRefreshingNativeAdOuys) return;
      if (!canShowNativeAd || b22ItemCountWphm <= 0) {
        b22ClearActiveNativeAdRvkw();
      } else if (b22ActiveNativeAdIndexHjac == null ||
          b22ActiveNativeAdIndexHjac! >= b22ItemCountWphm) {
        b22ActivateNativeAdScua();
      } else {
        b22StartNativeAdRefreshTimerEkkr();
      }
    });
  }

  void b22PrepareNativeAdSlotPepb(int b22ListIndexIwpp) {
    if (canShowNativeAd &&
        b22ActiveNativeAdIndexHjac == b22ListIndexIwpp &&
        b22LastChanceNativeAdIndexTytq != b22ListIndexIwpp) {
      b22LastChanceNativeAdIndexTytq = b22ListIndexIwpp;
      b22UploadNativeAdChanceIpdh();
    }
  }

  void b22UpdateNativeAdVisibilityFlyp(int b22IndexEeqd, bool b22VisibleSjix) {
    if (isClosed) return;
    final bool b22ChangedVvhj = b22VisibleSjix
        ? b22VisibleNativeAdIndexesHdvu.add(b22IndexEeqd)
        : b22VisibleNativeAdIndexesHdvu.remove(b22IndexEeqd);
    if (!b22ChangedVvhj) return;
    if (!b22VisibleSjix && b22ActiveNativeAdIndexHjac == b22IndexEeqd) {
      b22ActiveNativeAdIndexHjac = null;
      if (b22LastChanceNativeAdIndexTytq == b22IndexEeqd) {
        b22LastChanceNativeAdIndexTytq = null;
      }
      b22StopNativeAdRefreshTimerErnq();
      update();
    }
    if (b22VisibleSjix &&
        b22AppInForegroundKvrl &&
        !b22IsListScrollingHsxw &&
        !b22IsRefreshingNativeAdOuys) {
      b22ActivateNativeAdScua();
    }
  }

  void b22HandleScrollLzpj() {
    if (isClosed || !canShowNativeAd) return;
    b22IsListScrollingHsxw = true;
    b22ScrollIdleTimerMpyp?.cancel();
    b22StopNativeAdRefreshTimerErnq();
    b22ScrollIdleTimerMpyp = Timer(b22ScrollIdleDurationOdhx, () {
      if (isClosed || !canShowNativeAd) return;
      b22IsListScrollingHsxw = false;
      b22ActivateNativeAdScua();
    });
  }

  void b22ActivateNativeAdScua() {
    if (!b22AppInForegroundKvrl || b22VisibleNativeAdIndexesHdvu.isEmpty) {
      b22StopNativeAdRefreshTimerErnq();
      return;
    }
    final List<int> b22VisibleIndexesIdad =
        b22VisibleNativeAdIndexesHdvu
            .where((b22IndexTbdc) => b22IndexTbdc < b22LatestListItemCountVdfp)
            .toList()
          ..sort();
    if (b22VisibleIndexesIdad.isEmpty) return;
    final int b22IndexGkzr = b22VisibleIndexesIdad.first;
    if (b22ActiveNativeAdIndexHjac != b22IndexGkzr) {
      b22ActiveNativeAdIndexHjac = b22IndexGkzr;
      update();
    }
    b22StartNativeAdRefreshTimerEkkr();
  }

  bool b22CanRefreshNativeAdAuny() {
    final int? b22ActiveIndexSeyk = b22ActiveNativeAdIndexHjac;
    return !isClosed &&
        b22AppInForegroundKvrl &&
        !b22IsRefreshingNativeAdOuys &&
        !b22IsListScrollingHsxw &&
        b22ActiveIndexSeyk != null &&
        b22VisibleNativeAdIndexesHdvu.contains(b22ActiveIndexSeyk) &&
        canShowNativeAd;
  }

  bool b22CanContinueNativeAdRefreshLfdu(int b22IndexQydc) =>
      !isClosed &&
      b22AppInForegroundKvrl &&
      !b22IsListScrollingHsxw &&
      b22VisibleNativeAdIndexesHdvu.contains(b22IndexQydc) &&
      canShowNativeAd;

  void b22StartNativeAdRefreshTimerEkkr() {
    if (!b22CanRefreshNativeAdAuny()) return;
    b22NativeAdRefreshTimerRshc ??= Timer.periodic(
      b22NativeAdRefreshDurationJhwa,
      (_) => unawaited(b22RefreshActiveNativeAdLqum()),
    );
  }

  void b22StopNativeAdRefreshTimerErnq() {
    b22NativeAdRefreshTimerRshc?.cancel();
    b22NativeAdRefreshTimerRshc = null;
  }

  void b22ClearActiveNativeAdRvkw() {
    b22StopNativeAdRefreshTimerErnq();
    b22LastChanceNativeAdIndexTytq = null;
    if (b22ActiveNativeAdIndexHjac != null) {
      b22ActiveNativeAdIndexHjac = null;
      update();
    }
  }

  Future<void> b22RefreshActiveNativeAdLqum() async {
    if (!b22CanRefreshNativeAdAuny()) return;
    final int b22RefreshIndexMcns = b22ActiveNativeAdIndexHjac!;
    b22IsRefreshingNativeAdOuys = true;
    b22UploadNativeAdChanceIpdh();
    try {
      b22ActiveNativeAdIndexHjac = null;
      update();
      await WidgetsBinding.instance.endOfFrame;
      await Future<void>.delayed(Duration.zero);
      if (!b22CanContinueNativeAdRefreshLfdu(b22RefreshIndexMcns)) return;
      final B22PromotionOrchestratorAzwq b22AdServiceOkxy =
          B22PromotionOrchestratorAzwq.instance;
      if (!await b22AdServiceOkxy.b22HasDocumentListNativeAdGfmv()) {
        await b22AdServiceOkxy.b22LoadDocumentListNativeAdAfwu();
      }
      if (!b22CanContinueNativeAdRefreshLfdu(b22RefreshIndexMcns)) return;
      b22NativeAdRefreshKeyBrtb++;
      b22ActiveNativeAdIndexHjac = b22RefreshIndexMcns;
      update();
    } finally {
      b22IsRefreshingNativeAdOuys = false;
      if (b22AppInForegroundKvrl &&
          !b22IsListScrollingHsxw &&
          canShowNativeAd &&
          b22ActiveNativeAdIndexHjac == null) {
        b22ActivateNativeAdScua();
      }
    }
  }

  void b22UploadNativeAdChanceIpdh() {
    if (!b22NativeAdSwitchEnabledOlne) return;
    B22PromotionOrchestratorAzwq.instance.b22TrackAdOpportunityFbhf(
      b22AdSceneGiep: B22PromotionContextSuaj.pr_ban1,
      b22AdPosIdEbwa: B22PromotionSlotZwla.pr_main_banner1,
    );
  }

  @override
  void onReady() {
    super.onReady();
    b22LoadFilesFdxy();
  }

  Future<void> b22LoadFilesFdxy({
    bool b22ShowLoadingOicj = true,
    bool b22ForceReloadRrzx = false,
  }) async {
    if (b22LoadingFilesVsxz || (b22HasLoadedFilesWihb && !b22ForceReloadRrzx)) {
      b22RefreshControllerOxrn.refreshCompleted();
      return;
    }
    final b22PermissionVsor = await b22ResolveRequiredStoragePermissionFxme();
    if (!await b22PermissionVsor.isGranted) {
      await b22PrepareDemoFileVsrd();
      b22ListStateTnnh = B22FileCollectionStatePblk.b22NoPermissionIphf;
      b22RefreshControllerOxrn.refreshCompleted();
      update();
      return;
    }
    b22LoadingFilesVsxz = true;
    if (b22ShowLoadingOicj) {
      b22ListStateTnnh = B22FileCollectionStatePblk.b22LoadingQnsm;
      update();
    }
    try {
      b22AllFilesYbzz = await FlutterPreviewFile.queryFileList(
        FileToolsDocumentType.values[b22TypeTtjd.index],
      );
      b22SortFilesGbiv();
      b22ApplySearchUrcm();
      if (b22VisibleFilesIdkf.isEmpty) {
        await b22PrepareDemoFileVsrd();
      }
      b22HasLoadedFilesWihb = true;
      b22ListStateTnnh = B22FileCollectionStatePblk.b22LoadedHfay;
    } finally {
      b22LoadingFilesVsxz = false;
      b22RefreshControllerOxrn.refreshCompleted();
      update();
    }
  }

  void b22RefreshFilesWnkt() {
    b22LoadFilesFdxy(b22ShowLoadingOicj: false, b22ForceReloadRrzx: true);
  }

  void b22OnRequestPermissionPressedAvnl() {
    B22ApplicationSignalHubQzvk.instance.b22PublishQwoy(
      B22ApplicationSignalXfvp(
        b22TypeIafj:
            B22ApplicationSignalKindJiwh.b22StoragePermissionRequestLzlq,
      ),
    );
  }

  void b22SortFilesGbiv() {
    b22AllFilesYbzz.sort((b22LeftHqqs, b22RightTxdi) {
      switch (b22SortTypeUjob) {
        case B22OrderingKindDybz.b22DateNewWyvg:
          return (b22RightTxdi.updateTime ?? 0).compareTo(
            b22LeftHqqs.updateTime ?? 0,
          );
        case B22OrderingKindDybz.b22DateOldSaca:
          return (b22LeftHqqs.updateTime ?? 0).compareTo(
            b22RightTxdi.updateTime ?? 0,
          );
        case B22OrderingKindDybz.b22NameAZQwad:
          return (b22LeftHqqs.name ?? '').toLowerCase().compareTo(
            (b22RightTxdi.name ?? '').toLowerCase(),
          );
        case B22OrderingKindDybz.b22NameZAIywj:
          return (b22RightTxdi.name ?? '').toLowerCase().compareTo(
            (b22LeftHqqs.name ?? '').toLowerCase(),
          );
      }
    });
  }

  void b22ApplySearchUrcm() {
    final b22KeywordTtcq = b22SearchTextSurp.trim().toLowerCase();
    b22VisibleFilesIdkf = b22KeywordTtcq.isEmpty
        ? List<FileToolsFileInfo>.from(b22AllFilesYbzz)
        : b22AllFilesYbzz
              .where(
                (b22FileFoxq) => (b22FileFoxq.name ?? '')
                    .toLowerCase()
                    .contains(b22KeywordTtcq),
              )
              .toList();
  }

  Future<void> b22PrepareDemoFileVsrd() async {
    b22DemoFileInfoYgam = await B22SampleFileCatalogQuns.b22InstanceWkwh
        .b22LoadDemoDocumentGjsu();
  }

  Future<void> b22OnSortPressedTzpo() async {
    final b22PermissionTypeBjux =
        await b22ResolveRequiredStoragePermissionFxme();
    final b22PermissionJkmh = await B22AccessOrchestratorRwgw.b22InstanceWzjp
        .b22RequestPermissionVmnw(b22PermissionUlwh: b22PermissionTypeBjux);
    if (!b22PermissionJkmh.b22IsGrantedPfwf) return;
    final b22SelectedCthy =
        await B22ApplicationRouterJfva.b22ShowBottomSheetLzuf<
          B22OrderingKindDybz
        >(
          b22ChildBzzg: B22FileOrderingLowerDrawerFkmq(
            b22SelectedTypeHyxa: b22SortTypeUjob,
          ),
        );
    if (b22SelectedCthy == null) return;
    b22SortTypeUjob = b22SelectedCthy;
    await B22FileOrderingStoreAikr.b22WriteSortNameZayu(
      b22TabNameAimw: b22TypeTtjd.name,
      b22SortNameQzko: b22SelectedCthy.name,
    );
    b22SortFilesGbiv();
    b22ApplySearchUrcm();
    update();
  }

  Future<void> b22OnDeleteFilePressedSwig() async {
    final b22PermissionTypeMgch =
        await b22ResolveRequiredStoragePermissionFxme();
    final b22PermissionMctn = await B22AccessOrchestratorRwgw.b22InstanceWzjp
        .b22RequestPermissionVmnw(b22PermissionUlwh: b22PermissionTypeMgch);
    if (!b22PermissionMctn.b22IsGrantedPfwf) return;
    B22ApplicationRouterJfva.b22PushNamedWarf(
      b22RouteNameHlpz: B22ApplicationDestinationsMcbk.b22DeleteFileRouteBsfx,
      b22ArgumentsEnwl: {'files': b22VisibleFilesIdkf},
    );
  }

  void b22OnFileItemPressedHpbt(FileToolsFileInfo b22FileInfoMnzb) {
    final String? b22RouteNameAhaj = switch (b22FileInfoMnzb.type) {
      FileToolsDocumentType.pdf =>
        B22ApplicationDestinationsMcbk.b22PreviewPdfRouteLumo,
      FileToolsDocumentType.word =>
        B22ApplicationDestinationsMcbk.b22PreviewWordRouteDgsr,
      FileToolsDocumentType.excel =>
        B22ApplicationDestinationsMcbk.b22PreviewExcelRouteZify,
      _ => null,
    };
    if (b22RouteNameAhaj == null) return;
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22EditorEntryQbqj,
    );
    B22ApplicationRouterJfva.b22PushNamedWarf(
      b22RouteNameHlpz: b22RouteNameAhaj,
      b22ArgumentsEnwl: {'file': b22FileInfoMnzb},
    );
  }

  @override
  bool subscribesToAppEvents() => true;

  @override
  void onAppEvent(B22ApplicationSignalXfvp b22EventKxse) async {
    if (b22EventKxse.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22AppLifecycleZpzc) {
      b22AppInForegroundKvrl = b22EventKxse.b22IntValueVddo != 1;
      if (b22AppInForegroundKvrl) {
        b22ActivateNativeAdScua();
      } else {
        b22StopNativeAdRefreshTimerErnq();
      }
    } else if (b22EventKxse.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22FileSearchQefh) {
      final b22PermissionLban = await b22ResolveRequiredStoragePermissionFxme();
      if (!await b22PermissionLban.isGranted) return;
      b22SearchTextSurp = b22EventKxse.b22StringValueNvbm ?? '';
      b22ApplySearchUrcm();
      update();
    } else if (b22EventKxse.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22FileListRefreshOivp) {
      b22LoadFilesFdxy(b22ForceReloadRrzx: true);
    } else if (b22EventKxse.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22StoragePermissionGrantedUskx) {
      b22LoadFilesFdxy();
    } else if (b22EventKxse.b22TypeIafj ==
        B22ApplicationSignalKindJiwh.b22RefreshBUserStateSzod) {
      update();
    }
  }

  b22RunDebugActionsDopn() {
    if (!kDebugMode) {
      return;
    }
  }

  @override
  void onClose() {
    b22StopNativeAdRefreshTimerErnq();
    b22ScrollIdleTimerMpyp?.cancel();
    b22ScrollIdleTimerMpyp = null;
    b22ScrollControllerCiup.removeListener(b22HandleScrollLzpj);
    b22ScrollControllerCiup.dispose();
    b22RefreshControllerOxrn.dispose();
    super.onClose();
  }
}
