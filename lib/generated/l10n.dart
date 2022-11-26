// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hello`
  String get hello {
    return Intl.message(
      'hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {name}`
  String pageHomeWelcomeFullName(Object name) {
    return Intl.message(
      'Welcome $name',
      name: 'pageHomeWelcomeFullName',
      desc: '',
      args: [name],
    );
  }

  /// `LogIn`
  String get login {
    return Intl.message(
      'LogIn',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `SignIn`
  String get signIn {
    return Intl.message(
      'SignIn',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get passwordRestore {
    return Intl.message(
      'Forget password?',
      name: 'passwordRestore',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `field must not be empty`
  String get emptyField {
    return Intl.message(
      'field must not be empty',
      name: 'emptyField',
      desc: '',
      args: [],
    );
  }

  /// `invalid email format`
  String get invalidEmail {
    return Intl.message(
      'invalid email format',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `password must be at least 6 characters long`
  String get shortPassword {
    return Intl.message(
      'password must be at least 6 characters long',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }

  /// `A password reset email has been sent to your email`
  String get resetMessageSend {
    return Intl.message(
      'A password reset email has been sent to your email',
      name: 'resetMessageSend',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
