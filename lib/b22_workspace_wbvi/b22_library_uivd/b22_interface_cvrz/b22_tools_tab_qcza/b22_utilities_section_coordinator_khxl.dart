import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_interface_brpn/b22_locale_chooser_lower_drawer_uusf.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_navigation_mnyv/b22_application_router_cbkk.dart';
import 'package:b22_document_workspace_kmzm/b22_shared_midp/b22_interface_ruov/b22_foundation_coordinator_owyg.dart';
import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_language_jdlb/b22_supported_languages_jjnw.dart';
import 'package:get/get.dart';

class B22UtilitiesSectionCoordinatorXpza extends B22FoundationCoordinatorXsba {
  String get currentLanguageName {
    final b22LocaleWgaj = B22LanguageUtilitiesDnum.b22MatchLocaleHqib(
      Get.locale ?? B22LanguageUtilitiesDnum.b22InitialLocaleJyav(),
    );
    return B22LanguageUtilitiesDnum.b22LanguageListFlnh
        .firstWhere(
          (b22ItemUvvj) => B22LanguageUtilitiesDnum.b22IsSameLocaleFopb(
            b22ItemUvvj.b22LocaleGrtn,
            b22LocaleWgaj,
          ),
        )
        .b22NameYzxf;
  }

  Future<void> b22OnChangeLanguagePressedRwgv() async {
    await B22ApplicationRouterJfva.b22ShowBottomSheetLzuf(
      b22ChildBzzg: B22LocaleChooserLowerDrawerGtjc(),
    );
    update();
  }
}
