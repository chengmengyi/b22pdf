import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_application_lexicon_evae.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_supported_languages_jjnw.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_language_choice_zfoo.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class B22LocaleChooserCoordinatorAboc extends B22FoundationCoordinatorXsba {
  final ScrollController b22LanguageScrollControllerVjrn = ScrollController();
  late B22SupportedLanguageVhey b22SelectedLanguageBeru;
  bool b22HasScrolledOavt = false;

  List<B22SupportedLanguageVhey> get languageList =>
      B22LanguageUtilitiesDnum.b22LanguageListFlnh;

  @override
  void onInit() {
    super.onInit();
    final b22StoredLanguageFwqf = B22LanguageChoiceDsdt.b22ReadLanguagePgwy();
    final b22InitialLocaleVbqr = b22StoredLanguageFwqf.isEmpty
        ? B22LanguageUtilitiesDnum.b22InitialLocaleJyav()
        : B22LanguageUtilitiesDnum.b22MatchLocaleHqib(
            b22ParseLocaleEyza(b22StoredLanguageFwqf),
          );
    b22SelectedLanguageBeru = languageList.firstWhere(
      (b22ItemIkps) => B22LanguageUtilitiesDnum.b22IsSameLocaleFopb(
        b22ItemIkps.b22LocaleGrtn,
        b22InitialLocaleVbqr,
      ),
      orElse: () => languageList.first,
    );
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => b22ScrollToSelectedLanguageOoft(),
    );
  }

  bool b22IsSelectedUynn(B22SupportedLanguageVhey b22ItemMezs) =>
      B22LanguageUtilitiesDnum.b22IsSameLocaleFopb(
        b22SelectedLanguageBeru.b22LocaleGrtn,
        b22ItemMezs.b22LocaleGrtn,
      );

  void b22ScrollToSelectedLanguageOoft() {
    if (b22HasScrolledOavt || !b22LanguageScrollControllerVjrn.hasClients) {
      return;
    }
    b22HasScrolledOavt = true;
    final b22IndexEowg = languageList.indexWhere(b22IsSelectedUynn);
    if (b22IndexEowg <= 0) return;
    b22LanguageScrollControllerVjrn.animateTo(
      (b22IndexEowg * 56.h).clamp(
        0.0,
        b22LanguageScrollControllerVjrn.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> b22OnLanguagePressedBtys(
    B22SupportedLanguageVhey b22ItemUpvh,
  ) async {
    b22SelectedLanguageBeru = b22ItemUpvh;
    update();
    await B22ApplicationLexiconNofd.b22SelectLanguageXuyq(
      b22ItemUpvh.b22LocaleGrtn,
    );
    B22ApplicationRouterJfva.b22BackCwkm();
  }

  Locale b22ParseLocaleEyza(String b22TagAxsv) {
    final b22PartsOeel = b22TagAxsv.replaceAll('_', '-').split('-');
    return Locale(
      b22PartsOeel.first.toLowerCase(),
      b22PartsOeel.length > 1 ? b22PartsOeel[1].toUpperCase() : null,
    );
  }

  @override
  void onClose() {
    b22LanguageScrollControllerVjrn.dispose();
    super.onClose();
  }
}
