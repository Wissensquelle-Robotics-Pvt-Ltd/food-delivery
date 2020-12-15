

import 'package:flutter/cupertino.dart';
import 'package:product/Language/application.dart';

class LanguageManager {
  static final LanguageManager shared = LanguageManager._internal();

  factory LanguageManager() {
    return shared;
  }
  LanguageManager._internal();

  setDefaultLanguage(int index){
       final List<String> languagesList = application.supportedLanguages;
       final List<String> languageCodesList = application.supportedLanguagesCodes;

      final Map<dynamic, dynamic> languagesMap = {
        languagesList[0]: languageCodesList[0],
        languagesList[1]: languageCodesList[1]
      };

      print(languagesList);
      application.onLocaleChanged(Locale(languagesMap[languagesList[1]]));
  }

}