import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  LanguageProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    // await CashHelper.getLanguage().then((value) {
    //   if (value != null) {
    _locale = const Locale('ar');
    //   } else {
    //     print('none');
    //   }
    // }).catchError((e) async {
    //   final ui.Locale deviceLocale = ui.window.locale;
    //   _locale = Locale(deviceLocale.languageCode);
    //   await CashHelper.putLanguage(deviceLocale.languageCode);
    // });

    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    //CashHelper.putLanguage(locale.languageCode);
    notifyListeners();
  }

  Future<void> clearLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('languageCode');
    _locale = Locale.fromSubtags(
        languageCode: WidgetsBinding.instance.window.locale.languageCode);
    notifyListeners();
  }
}
