String appContentRest = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependancy_injection/config/configure_injection.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/theme.dart';
import 'features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRoutes,
  });
  final AppRoutes appRoutes; 

  @override
  Widget build(BuildContext context) {
    //Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    //Theme
    AppTheme theme = AppTheme(appTextTheme);
    return MultiBlocProvider(
      // Providing multiple blocs at the root of the widget tree
      providers: [
        BlocProvider(
          create: (context) => getIt<
              NumberTriviaBloc>(), // Creating and providing NumberTriviaBloc using dependency injection
        )
      ],
      child: MaterialApp(
        title: "App title", // App title
        themeMode: ThemeMode.system, // theme is based on system setting
        theme: theme.light(), // Setting light theme
        darkTheme: theme.dark(), // Setting dark theme
        onGenerateRoute: appRoutes.onGenerateRoute, // Handling route generation
      ),
    );
  }
}

''';

String routeContentRest = '''
import 'package:flutter/material.dart';

import '../../features/number_trivia/presentation/screens/number_trivia_screen.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => const NumberTriviaScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return const Scaffold(
        body: Center(
          child: Text('Something Error'),
        ),
      );
    });
  }
}
''';

String dioModuleContent = '''
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../api_endpoints/api_endpoints.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dioInstance => Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
}
''';
