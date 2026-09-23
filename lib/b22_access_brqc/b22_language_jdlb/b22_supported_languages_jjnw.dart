import 'dart:ui';

import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_language_choice_zfoo.dart';

class B22SupportedLanguageVhey {
  const B22SupportedLanguageVhey({
    required this.b22NameYzxf,
    required this.b22IconBznb,
    required this.b22LocaleGrtn,
  });

  final String b22NameYzxf;
  final String b22IconBznb;
  final Locale b22LocaleGrtn;
}

abstract final class B22LanguageUtilitiesDnum {
  static const Locale b22FallbackLocaleDanm = Locale('en');

  static const List<B22SupportedLanguageVhey> b22LanguageListFlnh = [
    B22SupportedLanguageVhey(
      b22NameYzxf: 'English',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_english_fagf',
      b22LocaleGrtn: Locale('en'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: 'Français',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_french_krgu',
      b22LocaleGrtn: Locale('fr'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: '日本語',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_japanese_juef',
      b22LocaleGrtn: Locale('ja'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: '한국어',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_korean_dnct',
      b22LocaleGrtn: Locale('ko'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: 'Deutsch',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_german_lnbm',
      b22LocaleGrtn: Locale('de'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: 'Español',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_spanish_xcjr',
      b22LocaleGrtn: Locale('es'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: 'Italiano',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_italian_ecsv',
      b22LocaleGrtn: Locale('it'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: 'Português',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_portuguese_sust',
      b22LocaleGrtn: Locale('pt'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: 'Русский',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_russian_xvwb',
      b22LocaleGrtn: Locale('ru'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: '繁體中文',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_chinese_traditional_mwvy',
      b22LocaleGrtn: Locale('zh', 'TW'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: '简体中文',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_chinese_simplified_jbnr',
      b22LocaleGrtn: Locale('zh', 'CN'),
    ),
    B22SupportedLanguageVhey(
      b22NameYzxf: 'العربية',
      b22IconBznb:
          'b22_localization_media_vmzp/b22_locale_flags_gxbm/b22_arabic_bjfq',
      b22LocaleGrtn: Locale('ar'),
    ),
  ];

  static Locale b22InitialLocaleJyav() {
    final b22SavedTagUznz = B22LanguageChoiceDsdt.b22ReadLanguagePgwy();
    if (b22SavedTagUznz.isNotEmpty) {
      return b22MatchLocaleHqib(b22ParseLocaleHtgt(b22SavedTagUznz));
    }
    return b22MatchLocaleHqib(PlatformDispatcher.instance.locale);
  }

  static Locale b22MatchLocaleHqib(Locale b22LocaleRqle) {
    for (final b22ItemBral in b22LanguageListFlnh) {
      if (b22IsSameLocaleFopb(b22ItemBral.b22LocaleGrtn, b22LocaleRqle)) {
        return b22ItemBral.b22LocaleGrtn;
      }
    }
    if (b22LocaleRqle.languageCode == 'zh') {
      final b22UseTraditionalHwbe =
          const {'TW', 'HK', 'MO'}.contains(b22LocaleRqle.countryCode) ||
          b22LocaleRqle.scriptCode == 'Hant';
      return Locale('zh', b22UseTraditionalHwbe ? 'TW' : 'CN');
    }
    for (final b22ItemXdnk in b22LanguageListFlnh) {
      if (b22ItemXdnk.b22LocaleGrtn.languageCode ==
          b22LocaleRqle.languageCode) {
        return b22ItemXdnk.b22LocaleGrtn;
      }
    }
    return b22FallbackLocaleDanm;
  }

  static bool b22IsSameLocaleFopb(Locale? b22LeftRjzu, Locale b22RightFxsx) =>
      b22LeftRjzu?.languageCode == b22RightFxsx.languageCode &&
      b22LeftRjzu?.countryCode == b22RightFxsx.countryCode;

  static String localeTag(Locale b22LocaleMpez) =>
      b22LocaleMpez.toLanguageTag();

  static Locale b22ParseLocaleHtgt(String b22TagUkxc) {
    final b22PartsZuwq = b22TagUkxc.replaceAll('_', '-').split('-');
    return Locale(
      b22PartsZuwq.first.toLowerCase(),
      b22PartsZuwq.length > 1 ? b22PartsZuwq[1].toUpperCase() : null,
    );
  }
}
