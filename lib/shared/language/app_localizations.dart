import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, dynamic> _localizedStrings = {};

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    _localizedStrings = json.decode(jsonString);
    return true;
  }

  /// This method supports nested keys, such as `profile.title`
  String translate(String key) {
    final keys = key.split('.');
    dynamic value = _localizedStrings;

    for (var subKey in keys) {
      if (value is Map<String, dynamic> && value.containsKey(subKey)) {
        value = value[subKey];
      } else {
        throw FlutterError(
            'Translation key "$key" not found in ${locale.languageCode}.json');
        //return key; // Return the key itself if translation is not found
      }
    }

    // Ensure the final value is a String
    if (value is String) {
      return value;
    } else {
      throw FlutterError(
          'Translation key "$key" leads to a non-string value in ${locale.languageCode}.json');
      //return key; // Return the key if the final value is not a String
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
