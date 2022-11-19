import 'package:flutter_dotenv/flutter_dotenv.dart';

/// application environment file
late Environment env;

/// load env file
Future<Environment> loadEnvironment() async {
  await dotenv.load();
  return Environment(
    appNamePostfix: dotenv.env['appNamePostfix'] ?? 'prod',
  );
}

/// app env class
class Environment {
  /// app env class
  Environment({
    required this.appNamePostfix,
  });

  /// string with flavor value
  final String appNamePostfix;
}
