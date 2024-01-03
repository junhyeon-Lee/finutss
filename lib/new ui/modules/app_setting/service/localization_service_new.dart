import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:finutss/main.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationServiceNew extends Translations {
  Locale locale = Constants.defaultLocale;
  AppSettingController controller = Get.put(AppSettingController(
      locale: Get.locale ?? LocalizationServiceNew.locales[0]));

  static const String LANGUAGE_CODE = "language_code";
  static const String COUNTRY_CODE = "country_code";
  static const String Selected_Language_CODE = "selected_language_code";
  static const String Selected_Language = "selected_language";

  static final fallbackLocale = Constants.defaultLocale;

  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    bool isPhoneLanguage= prefs.getBool('PhoneLanguage') ?? true;

    if(isPhoneLanguage){
     // String phoneLanguageCode=Get.deviceLocale?.languageCode ?? 'en';
      String phoneLanguageCode=Platform.localeName;

      List<String> dateParts = phoneLanguageCode.split("_");
      if(dateParts.length>1){
        phoneLanguageCode=dateParts[0].toString();
      }

      if(phoneLanguageCode=='zh'){
        phoneLanguageCode='zh-cn';
      }

      final index = controller.CountryList.indexWhere((note) => note.languageCode.toUpperCase()==phoneLanguageCode.toUpperCase());
      if(index!=-1){
        controller.setLanguage(languageCode: controller.CountryList[index].languageCode,languageName: controller.CountryList[index].nationalLanguageName);
        locale = getLocaleFromLanguage(controller.CountryList[index].languageCode);
      }else{
        locale = getLocaleFromLanguage(Constants.defaultLocale.languageCode.toUpperCase());
        controller.setLanguage(languageCode: Constants.defaultLocale.languageCode,languageName: Constants.defaultLangName);
      }
    }else {
      if (!prefs.containsKey(LANGUAGE_CODE) && !prefs.containsKey(COUNTRY_CODE)) {
        return Constants.defaultLocale;
      }
      String languageCode = prefs.getString(LANGUAGE_CODE) ?? "";
      String countryCode = prefs.getString(COUNTRY_CODE) ?? "";
      locale = Locale(languageCode, countryCode);
    }
    return locale;
  }

  static final langs = [
    'EN',
    'DE',
    'ES',
    'FR',
    'IT',
    'JA',
    'KO',
    'PL',
    'PT',
    'RU',
    'TH',
    'TR',
    'ZH-CN',
    'ZH-TW',
  ];

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

  Future<Map<String, String>> loadLangNew(String lang) async {
    String dataString =
        await rootBundle.loadString('new_assets/langs/$lang.json');
    Map langDynamic = jsonDecode(dataString);
    Map<String, String> langString =
        langDynamic.map((key, value) => MapEntry(key, value.toString()));
    return langString;
  }

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

  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale ?? locales[0];
  }

  void changeLocale(String lang) async {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_CODE, locale.languageCode);
    await prefs.setString(COUNTRY_CODE, locale.countryCode ?? "");
  }

  static String getLanguageFromLocale(Locale locale) {
    for (int i = 0; i < langs.length; i++) {
      if (locale == locales[i]) return langs[i];
    }
    return langs[0];
  }
}
