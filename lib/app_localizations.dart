import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  //helper method to keep the code in the widgets concise
  //Localization are accessed using an Inherited Widget "of"syntax

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

// static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationDelegate();
  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    //load the language json file from the lang folder
    print("=======Loading Json====");
    String jsonString = await rootBundle
        .loadString('new_assets/langs/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  //this method will be called from every widget which needs a localized text
  String? translate(String key) {
    return _localizedStrings?[key];
  }
}

//LocalizationsDelegate is a factory for a set of localized resources
//in this case, the localized strings will be gotten in an AppLocalization object
class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    //include all of your supported code here
    return ['en', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    //AppLocalization class is where the json loading actually runs.
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
