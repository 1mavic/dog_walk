import 'package:flutter_dotenv/flutter_dotenv.dart';

late Environment env;

Future<Environment> loadEnvironment() async {
  await dotenv.load(fileName: ".env");
  return Environment(
    appNamePostfix: dotenv.env['appNamePostfix'] ?? 'prod',
  );
}

class Environment {
  Environment({
    required this.appNamePostfix,
  });

  final String appNamePostfix;
}
