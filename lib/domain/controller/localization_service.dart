import 'dart:convert';
import 'dart:ui';
import 'package:finutss/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  // Default locale
  Locale locale = Locale('en', 'US');
  //getter for locale
  // Locale get locale => _locale;
  //keys for shared prefs
  static const String LANGUAGE_CODE = "language_code";
  static const String COUNTRY_CODE = "country_code";

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('de', 'DE');

  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(LANGUAGE_CODE) && !prefs.containsKey(COUNTRY_CODE)) {
      return Locale('ko', 'KR');
    }
    String languageCode = prefs.getString(LANGUAGE_CODE) ?? "";
    String countryCode = prefs.getString(COUNTRY_CODE) ?? "";
    locale = Locale(languageCode, countryCode);
    return locale;
  }

  static final langs = [
    'EN'.tr,
    'DE'.tr,
    'ES'.tr,
    'FR'.tr,
    'IT'.tr,
    'JA'.tr,
    'KO'.tr,
    'PL'.tr,
    'PT'.tr,
    'RU'.tr,
    'TH'.tr,
    'TR'.tr,
    'ZH-CN'.tr,
    'ZH-TW'.tr,
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('de', 'DE'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('it', 'IT'),
    Locale('ja', 'JP'),
    Locale('ko', 'KR'),
    Locale('pl', 'PL'),
    Locale('pt', 'PT'),
    Locale('ru', 'RU'),
    Locale('th', 'TH'),
    Locale('tr', 'TR'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
  ];

  Future<Map<String, String>> loadLang(String lang) async {
    String dataString = await rootBundle.loadString('assets/langs/$lang.json');
    Map langDynamic = jsonDecode(dataString);
    Map<String, String> langString =
        langDynamic.map((key, value) => MapEntry(key, value.toString()));
    return langString;
  }

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'de_DE': deDE,
        'es_ES': esES,
        'fr_FR': frFR,
        'it_IT': itIT,
        'ja_JP': jaJP,
        'ko_KR': koKR,
        'pl_PL': plPL,
        'pt_PT': ptPT,
        'ru_RU': ruRU,
        'th_TH': thTH,
        'tr_TR': trTR,
        'zh_CN': zhCN,
        'zh_TW': zhTW,
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) async {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
    var prefs = await SharedPreferences.getInstance();
    bool languageCode =
        await prefs.setString(LANGUAGE_CODE, locale.languageCode);
    bool countryCode =
        await prefs.setString(COUNTRY_CODE, locale.countryCode ?? "");
    print("lc=>$languageCode : cc=>$countryCode");
  }

  // Finds language in `langs` list and returns it as Locale
  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale ?? locales[0];
  }

  static String getLanguageFromLocale(Locale locale) {
    for (int i = 0; i < langs.length; i++) {
      if (locale == locales[i]) return langs[i];
    }
    return langs[0];
  }
}
