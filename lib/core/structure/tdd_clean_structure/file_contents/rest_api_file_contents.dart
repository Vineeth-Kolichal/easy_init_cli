String appContentRest = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependancy_injection/config/configure_injection.dart'; // Importing dependency injection configuration
import 'core/routes/app_routes.dart'; // Importing app routes
import 'core/theme/theme.dart'; // Importing app theme
import 'features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.dart'; // Importing NumberTriviaBloc

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.appRoutes}); // Constructor with required appRoutes parameter
  final AppRoutes appRoutes; // AppRoutes object

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Providing multiple blocs at the root of the widget tree
      providers: [
        BlocProvider(
          create: (context) => getIt<NumberTriviaBloc>(), // Creating and providing NumberTriviaBloc using dependency injection
        )
      ],
      child: MaterialApp(
        title: "App title", // App title
        themeMode: ThemeMode.light, // Setting theme mode to light
        theme: AppTheme.lightTheme, // Setting light theme
        darkTheme: AppTheme.darkTheme, // Setting dark theme
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
