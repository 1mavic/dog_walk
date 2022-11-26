import 'package:flutter/material.dart';

/// application custom snackbar
class SnackMy extends SnackBar {
  /// application custom snackbar
  SnackMy({
    super.key,
    required String text,
  }) : super(
          content: Text(text),
          // behavior: SnackBarBehavior.floating,
          elevation: 10,
          // margin: const EdgeInsets.symmetric(
          //   horizontal: 20,
          // ),
        );
}
