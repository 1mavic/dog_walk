import 'package:doggie_walker/localization/dart_files/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// application localization class
class AppLocalization {
  /// application localization class
  AppLocalization(this.locale);

  /// current application locale
  final Locale locale;

  static AppLocalization? of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);

  static Future<AppLocalization> load(Locale locale) async {
    final localeName = Intl.canonicalizedLocale(locale.languageCode);
// It produces an error now but it's fine; it will
// disappear as soon as we use code generation to
// create internationalization utilities
    await initializeMessages(localeName);
    // Setup intl to work with the device's locale
    Intl.defaultLocale = localeName;
    return AppLocalization(locale);
  }

  String get helloWorld => Intl.message(
        'Hello world!!',
        name: 'helloWorld',
      );
  String get hello => Intl.message(
        'Hello',
        name: 'hello',
      );
}

/// extension on context to use AppLocalization context.localize.getter
extension LocalizationExt on BuildContext {
  AppLocalization get localize {
// Getting the device's locale, which can be for example
// "en", "it", "es" or anything else
    // log(AppLocalization.of(this)?.locale.languageCode ?? '??');
    // final code = AppLocalization.of(this)?.locale.languageCode ?? 'ru';
    return AppLocalization.of(this)!;
  }
}
