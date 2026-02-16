const String mainContent = '''import 'app_runner.dart';
import 'core/config/flavor_config.dart';

Future<void> main(List<String> args) async {
  await runApplication(Flavor.dev);
}
''';

const String appContent = '''import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/dependency_injection/config/configure_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_service.dart';
import 'features/sample/view_model/sample_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    //Theme
    AppTheme theme = AppTheme(appTextTheme);
    return MultiProvider(
      // Providing multiple providers at the root of the widget tree
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<SampleViewModel>()),
        ChangeNotifierProvider(create: (context) => getIt<ThemeService>()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp.router(
            title: "App title",
            themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: theme.light(),
            darkTheme: theme.dark(),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
''';

const String appRunnerContent = '''import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/config/flavor_config.dart';
import 'core/dependency_injection/config/configure_injection.dart';

Future<void> runApplication(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.initialize(flavor);
  await configureInjection();
  runApp(const MyApp());
}
''';

const String dioModuleContent = '''
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../config/flavor_config.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dioInstance => Dio(
    BaseOptions(
      baseUrl: FlavorConfig.instance.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
}
''';

const String appRouterContent = '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/sample/view/screens/sample_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SampleScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Something Error'))),
  );
}
''';

const String flavorConfigContent = '''
enum Flavor {
  dev,
  prod;

  @override
  String toString() => name;
}

class FlavorConfig {
  final String baseUrl;

  final Flavor flavor;

  FlavorConfig({required this.baseUrl, required this.flavor});

  static FlavorConfig? _instance;

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        _instance = FlavorConfig(
          baseUrl: "https://easy-init-demo-api.vercel.app",
          flavor: Flavor.dev,
        );
        break;

      case Flavor.prod:
        _instance = FlavorConfig(
          baseUrl: "https://easy-init-demo-api.vercel.app",
          flavor: Flavor.prod,
        );
        break;
    }
  }

  static FlavorConfig get instance {
    _instance ??= FlavorConfig(
      baseUrl: "https://easy-init-demo-api.vercel.app",
      flavor: Flavor.dev,
    );
    return _instance!;
  }
}
''';

const String configInjectionContent = '''
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'configure_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  getIt.init(environment: Environment.prod);
}
''';

const String failuresContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
sealed class Failure with _\$Failure {
  const factory Failure.apiRequestFailure(String error) = ApiRequestFailure;
  const factory Failure.unexpectedFailure(String error) = UnexpectedFailure;
}
''';
