import 'package:doggie_walker/localization/localization.dart';
import 'package:flutter/material.dart';

/// application AppLocalization delegate
class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  /// application AppLocalization delegate
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => [
        'ru',
        'en',
      ].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
