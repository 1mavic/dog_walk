import 'package:doggie_walker/bloc/user_bloc/user_bloc.dart';
import 'package:doggie_walker/config/flavor/flavor_banner.dart';
import 'package:doggie_walker/config/flavor/flavor_enum.dart';
import 'package:doggie_walker/config/theme/app_theme_data.dart';
import 'package:doggie_walker/entity/repositories/login_repository/login_repository.dart';
import 'package:doggie_walker/entity/repositories/user_repository/user_repository.dart';
import 'package:doggie_walker/environment.dart';
import 'package:doggie_walker/generated/l10n.dart';
import 'package:doggie_walker/map_screen/map_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  env = await loadEnvironment();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/// scaffold messange key
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

/// my app widget
class MyApp extends StatefulWidget {
  /// my app widget
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LoginRepository loginRepositry;

  @override
  void initState() {
    loginRepositry = FirebaseLoginRepository();
    super.initState();
  }

  @override
  void dispose() {
    loginRepositry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => UserBloc(
        loginRepositry,
        UserRepositoryImpl(),
      ),
      child: RepositoryProvider.value(
        value: loginRepositry,
        child: MaterialApp(
          scaffoldMessengerKey: scaffoldKey,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Flutter Demo',
          theme: AppThemeData.lightTheme,
          home: const FlavorBanner(
            flavor: Flavor.dev,
            child: MapScreen(),
          ),
        ),
      ),
    );
  }
}
