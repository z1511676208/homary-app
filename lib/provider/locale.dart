// import 'package:localization_demo/i18n/app_localization_delegate.dart';
// import 'package:localization_demo/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

class Lang with ChangeNotifier {
  Locale _locale = Locale('zh', '');

  get curLocale => _locale;

  changeCurLang() {
    _locale = Locale('en', '');
    notifyListeners();
  }
}
