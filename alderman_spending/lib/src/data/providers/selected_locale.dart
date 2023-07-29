import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en', 'US');

  Locale get currentLocale => _currentLocale;

  void updateLocale(Locale locale) {
    if (locale != _currentLocale) {
      _currentLocale = locale;
      notifyListeners();
    }
  }
}
