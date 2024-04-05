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

String apiEndpointContent = '''
class ApiEndpoints {
  /// change the [baseUrl] value as per your api
  static String baseUrl = "http://numbersapi.com/";
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

String networkExceptionContent = '''
import 'package:dio/dio.dart';

class CustomException implements Exception {
  CustomException.otherException(String msg) {
    message = msg;
  }
  CustomException.fromDioError(DioException dioError) {
    if (message == null) {
      switch (dioError.type) {
        case DioException.requestCancelled:
          message = "Request to API server was cancelled";
          break;
        case DioException.connectionTimeout:
          message = "Connection timeout with API server";
          break;
        case DioException.connectionError:
          message =
              "Connection to API server failed due to internet connection";
          break;
        case DioException.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioException.badResponse:
          message = _handleError(dioError.response!.statusCode);
          break;
        case DioException.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        default:
          message = _handleDefaultError(dioError);
          break;
      }
    }
  }

  dynamic message;

  String? _handleDefaultError(DioException error) {
    try {
      final response = error.response?.data as Map?;
      if (response != null) {
        return "\${response["message"]}";
      }
      return error.message;
    } catch (_) {
      return error.message;
    }
  }

  Object _handleError(statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized request';
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong';
    }
  }

  @override
  String toString() => message.toString();
}

''';
