import 'package:flutter/material.dart';
import 'app_localizations.dart'; // Import your localization file

extension LocalizationExtension on BuildContext {
  String translate(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}
