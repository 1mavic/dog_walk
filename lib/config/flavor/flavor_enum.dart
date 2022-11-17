import 'package:flutter/material.dart';

/// Flavor enum. Defines flavors of application and config for them.
enum Flavor {
  /// develop flavor
  dev,

  /// staging flavor
  stage,

  /// production flavor
  prod;

  /// getter to indicate is flavor dev
  bool get isDev => this == dev;

  /// getter to indicate is flavor stage
  bool get isStage => this == stage;

  /// getter to indicate is flavor prod
  bool get isProd => this == prod;

  /// get color of flavor
  Color get getBannerColor {
    switch (this) {
      case dev:
        return Colors.blue;
      case stage:
        return Colors.amber;
      case prod:
        return Colors.transparent;
    }
  }

  @override
  String toString() {
    switch (this) {
      case dev:
        return 'DEV';
      case stage:
        return 'STAGE';
      case prod:
        return '';
    }
  }
}
