import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_application_lexicon_evae.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_supported_languages_jjnw.dart';
import 'package:b22_document_workspace_kmzm/b22_launch_dehs/b22_onboarding_wmqk/b22_operations_xopv/b22_first_run_director_xcwj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_signal_nyqf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_telemetry_akgo/b22_telemetry_orchestrator_bvsc.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class B22LocaleChooserCoordinatorAegb extends B22FoundationCoordinatorXsba {
  final ScrollController b22LanguageScrollControllerEasc = ScrollController();
  late B22SupportedLanguageVhey b22SelectedLanguageTjxp;
  bool b22HasScrolledIlbk = false;

  List<B22SupportedLanguageVhey> get languageList =>
      B22LanguageUtilitiesDnum.b22LanguageListFlnh;

  @override
  void onInit() {
    super.onInit();
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22LangSelectViewVqcp,
    );
    final b22InitialLocaleCgpd =
        B22LanguageUtilitiesDnum.b22InitialLocaleJyav();
    b22SelectedLanguageTjxp = languageList.firstWhere(
      (b22ItemOsek) => B22LanguageUtilitiesDnum.b22IsSameLocaleFopb(
        b22ItemOsek.b22LocaleGrtn,
        b22InitialLocaleCgpd,
      ),
      orElse: () => languageList.first,
    );
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => b22ScrollToSelectedLanguageJqyk(),
    );
  }

  bool b22IsSelectedYjal(B22SupportedLanguageVhey b22ItemYlht) =>
      B22LanguageUtilitiesDnum.b22IsSameLocaleFopb(
        b22SelectedLanguageTjxp.b22LocaleGrtn,
        b22ItemYlht.b22LocaleGrtn,
      );

  void b22OnLanguagePressedEjvb(B22SupportedLanguageVhey b22ItemNayn) {
    b22SelectedLanguageTjxp = b22ItemNayn;
    update();
  }

  void b22ScrollToSelectedLanguageJqyk() {
    if (b22HasScrolledIlbk || !b22LanguageScrollControllerEasc.hasClients) {
      return;
    }
    final b22IndexAkug = languageList.indexWhere(b22IsSelectedYjal);
    b22HasScrolledIlbk = true;
    if (b22IndexAkug <= 0) return;
    final b22TargetOffsetHuim = b22IndexAkug * 56.h;
    b22LanguageScrollControllerEasc.animateTo(
      b22TargetOffsetHuim.clamp(
        0.0,
        b22LanguageScrollControllerEasc.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> b22OnOkPressedUnsz() async {
    B22TelemetryOrchestratorNqon.instance.b22TrackEventWyre(
      b22PointTypeDrbi: B22TelemetrySignalDbrq.b22LangSelectClickNcob,
    );
    await B22ApplicationLexiconNofd.b22SelectLanguageXuyq(
      b22SelectedLanguageTjxp.b22LocaleGrtn,
    );
    B22FirstRunDirectorYxjn.instance.b22ToPageOpenNotificationPermissionVhup();
  }

  @override
  void onClose() {
    b22LanguageScrollControllerEasc.dispose();
    super.onClose();
  }
}
