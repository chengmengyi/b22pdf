import 'dart:convert';
import 'dart:ui';

import 'package:b22_document_workspace_kmzm/b22_access_brqc/b22_notifications_iopd/b22_operations_ancs/b22_alert_orchestrator_qrqj.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_configuration_pson/b22_application_manifest_pfbi.dart';
import 'package:b22_document_workspace_kmzm/b22_foundation_hwhi/b22_storage_zgwn/b22_records_aogw/b22_language_choice_zfoo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boom_notification_plugins/flutter_boom_notification_plugins.dart';
import 'package:get/get.dart';

final class B22LanguageOptionYcrn {
  const B22LanguageOptionYcrn({
    required this.b22LocaleFamv,
    required this.b22NativeNameGnfl,
  });

  final Locale b22LocaleFamv;
  final String b22NativeNameGnfl;
}

final class B22ApplicationLexiconNofd extends Translations {
  B22ApplicationLexiconNofd();

  static const Locale b22FallbackLocaleGbqu = Locale('en');

  static const List<B22LanguageOptionYcrn> b22LanguageOptionsQxlf = [
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('en'),
      b22NativeNameGnfl: 'English',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('fr'),
      b22NativeNameGnfl: 'Français',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('ja'),
      b22NativeNameGnfl: '日本語',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('ko'),
      b22NativeNameGnfl: '한국어',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('de'),
      b22NativeNameGnfl: 'Deutsch',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('es'),
      b22NativeNameGnfl: 'Español',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('it'),
      b22NativeNameGnfl: 'Italiano',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('pt'),
      b22NativeNameGnfl: 'Português',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('ru'),
      b22NativeNameGnfl: 'Русский',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('zh', 'TW'),
      b22NativeNameGnfl: '繁體中文',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('zh', 'CN'),
      b22NativeNameGnfl: '简体中文',
    ),
    B22LanguageOptionYcrn(
      b22LocaleFamv: Locale('ar'),
      b22NativeNameGnfl: 'العربية',
    ),
  ];

  static Map<String, Map<String, String>> b22LoadedKeysQqpa =
      <String, Map<String, String>>{};

  static List<Locale> get supportedLocales => b22LanguageOptionsQxlf
      .map((B22LanguageOptionYcrn b22OptionCkrh) {
        return b22OptionCkrh.b22LocaleFamv;
      })
      .toList(growable: false);

  static Future<void> b22InitializeEncryptedLexiconRxye() async {
    final String b22EncryptedPayloadYynh = await rootBundle.loadString(
      B22ApplicationManifestPdpm.b22EncryptedLexiconAssetZqsa,
    );
    final String b22PlainJsonZxow = await FlutterBoomNotificationPlugins
        .instance
        .decryptReflectionString(
          secret: B22ApplicationManifestPdpm.b22SecretKeyCkpi,
          value: b22EncryptedPayloadYynh.trim(),
        );
    final Object? b22DecodedObjectCwpt = jsonDecode(b22PlainJsonZxow);
    final Map<String, Map<String, String>> b22ParsedKeysHvgg =
        b22ParseAndValidateLexiconAgxh(b22DecodedObjectCwpt);
    b22LoadedKeysQqpa = b22ParsedKeysHvgg;
    Get.addTranslations(b22LoadedKeysQqpa);
    Get.fallbackLocale = b22FallbackLocaleGbqu;
  }

  static Map<String, Map<String, String>> b22ParseAndValidateLexiconAgxh(
    Object? b22DecodedObjectIxxm,
  ) {
    if (b22DecodedObjectIxxm is! Map) {
      throw const FormatException('Invalid encrypted localization payload.');
    }

    final Map<String, Map<String, String>> b22ParsedKeysQvut =
        <String, Map<String, String>>{};
    for (final MapEntry<Object?, Object?> b22LocaleEntryRcvc
        in b22DecodedObjectIxxm.entries) {
      final Object? b22LocaleNameAwhv = b22LocaleEntryRcvc.key;
      final Object? b22TranslationObjectJfmp = b22LocaleEntryRcvc.value;
      if (b22LocaleNameAwhv is! String || b22TranslationObjectJfmp is! Map) {
        throw const FormatException('Invalid localization locale entry.');
      }
      final Map<String, String> b22LocaleTranslationsUihe = <String, String>{};
      for (final MapEntry<Object?, Object?> b22TranslationEntryJkqo
          in b22TranslationObjectJfmp.entries) {
        final Object? b22TranslationKeyNbhz = b22TranslationEntryJkqo.key;
        final Object? b22TranslationValueIwtw = b22TranslationEntryJkqo.value;
        if (b22TranslationKeyNbhz is! String ||
            b22TranslationValueIwtw is! String) {
          throw const FormatException('Invalid localization text entry.');
        }
        b22LocaleTranslationsUihe[b22TranslationKeyNbhz] =
            b22TranslationValueIwtw;
      }
      b22ParsedKeysQvut[b22LocaleNameAwhv] = Map<String, String>.unmodifiable(
        b22LocaleTranslationsUihe,
      );
    }

    final Set<String> b22ExpectedLocalesQbdz = b22LanguageOptionsQxlf
        .map(
          (B22LanguageOptionYcrn b22OptionFhfk) =>
              b22OptionFhfk.b22LocaleFamv.toString(),
        )
        .toSet();
    if (!b22SetEqualsQnzc(
      b22ParsedKeysQvut.keys.toSet(),
      b22ExpectedLocalesQbdz,
    )) {
      throw const FormatException('Localization locales do not match.');
    }

    final Set<String> b22EnglishKeysKlcv = b22ParsedKeysQvut['en']!.keys
        .toSet();
    if (b22EnglishKeysKlcv.isEmpty) {
      throw const FormatException('Localization payload is empty.');
    }
    for (final MapEntry<String, Map<String, String>> b22LocaleEntryTbeb
        in b22ParsedKeysQvut.entries) {
      if (!b22SetEqualsQnzc(
        b22LocaleEntryTbeb.value.keys.toSet(),
        b22EnglishKeysKlcv,
      )) {
        throw FormatException(
          'Localization keys do not match for ${b22LocaleEntryTbeb.key}.',
        );
      }
    }
    return Map<String, Map<String, String>>.unmodifiable(b22ParsedKeysQvut);
  }

  static bool b22SetEqualsQnzc(
    Set<String> b22LeftNbcw,
    Set<String> b22RightGbqh,
  ) {
    return b22LeftNbcw.length == b22RightGbqh.length &&
        b22LeftNbcw.containsAll(b22RightGbqh);
  }

  static String b22ResolveTextForLocaleJzsv({
    required Locale b22LocaleVfvb,
    required String b22KeyDwnr,
  }) {
    final String b22LocaleNameOeqk = b22LocaleVfvb.toString();
    return b22LoadedKeysQqpa[b22LocaleNameOeqk]?[b22KeyDwnr] ??
        b22LoadedKeysQqpa[b22LocaleVfvb.languageCode]?[b22KeyDwnr] ??
        b22LoadedKeysQqpa['en']?[b22KeyDwnr] ??
        b22KeyDwnr;
  }

  static Locale b22ResolveInitialLocaleYfpt() {
    final String b22StoredLanguageJikb =
        B22LanguageChoiceDsdt.b22ReadLanguagePgwy();
    if (b22StoredLanguageJikb.isNotEmpty) {
      return b22NormalizeLocaleHefm(b22StoredLanguageJikb);
    }
    return b22NormalizeLocaleHefm(
      PlatformDispatcher.instance.locale.toLanguageTag(),
    );
  }

  static Future<void> b22SelectLanguageXuyq(Locale b22LocaleHgrk) async {
    final Locale b22NormalizedLocaleKnyw = b22NormalizeLocaleHefm(
      b22LocaleHgrk.toLanguageTag(),
    );
    await B22LanguageChoiceDsdt.b22SaveLanguageZcdq(
      b22NormalizedLocaleKnyw.toLanguageTag(),
    );
    await Get.updateLocale(b22NormalizedLocaleKnyw);
    B22AlertOrchestratorNazk.b22InstanceOxzc
        .b22RefreshNotificationLanguageUxjg();
  }

  static Locale b22NormalizeLocaleHefm(String b22LanguageTagKgld) {
    final String b22NormalizedTagAgvh = b22LanguageTagKgld
        .trim()
        .replaceAll('_', '-')
        .toLowerCase();
    final List<String> b22TagPartsMoqk = b22NormalizedTagAgvh.split('-');
    final String b22LanguageCodeWkdi = b22TagPartsMoqk.first;

    if (b22LanguageCodeWkdi == 'zh') {
      final bool b22UseTraditionalYxsg = b22TagPartsMoqk.any(
        (String b22PartJwab) =>
            const {'tw', 'hk', 'mo', 'hant'}.contains(b22PartJwab),
      );
      return Locale('zh', b22UseTraditionalYxsg ? 'TW' : 'CN');
    }

    const Set<String> b22SupportedCodesDdjt = {
      'en',
      'fr',
      'ja',
      'ko',
      'de',
      'es',
      'it',
      'pt',
      'ru',
      'ar',
    };
    return b22SupportedCodesDdjt.contains(b22LanguageCodeWkdi)
        ? Locale(b22LanguageCodeWkdi)
        : b22FallbackLocaleGbqu;
  }

  @override
  Map<String, Map<String, String>> get keys => b22LoadedKeysQqpa;
}
