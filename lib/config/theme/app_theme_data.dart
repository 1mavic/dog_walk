import 'package:flutter/material.dart';

/// application themes
class AppThemeData {
  /// light theme
  static final lightTheme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      border: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      fillColor: Colors.green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
          (_) => const EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 20,
          ),
        ),
        shape: MaterialStateProperty.resolveWith(
          (_) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              70,
            ),
          ),
        ),
      ),
    ),
  );

  /// dark theme
  static final darkTheme = ThemeData();
}
