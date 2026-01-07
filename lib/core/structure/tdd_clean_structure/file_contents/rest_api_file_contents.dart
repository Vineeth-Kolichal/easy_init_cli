String appContentRest = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependancy_injection/config/configure_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';
import 'features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    //Theme
    AppTheme theme = AppTheme(appTextTheme);
    return MultiBlocProvider(
      // Providing multiple blocs at the root of the widget tree
      providers: [BlocProvider(create: (context) => getIt<NumberTriviaBloc>())],
      child: MaterialApp.router(
        title: "App title",
        themeMode: ThemeMode.system,
        theme: theme.light(),
        darkTheme: theme.dark(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}


''';

String routeContentRest = '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/number_trivia/presentation/screens/number_trivia_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const NumberTriviaScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Something Error'))),
  );
}

''';

String dioModuleContent = '''
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
