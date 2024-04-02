import 'package:easy_init_cli/commands/create_feature/create_feature.dart';
import 'package:recase/recase.dart';

String logo = '''


     ##########      #######      ########    ##     ## 
    ##            ##       ##   ##             ##  ##
   #######       ###########    #########       ###
  ##            ##       ##            ##      ##
 ##########    ##       ##    #########      ##

          ####  ##      ##  ####  ##########   
          ##   ####    ##   ##       ##
         ##   ##  ##  ##   ##       ##
        ##   ##    ####   ##       ##
      ####  ##      ##  ####      ##

         Made with 🩵  by Vineeth
              Version :1.0.3

''';

String apiEndpointContent = '''
class ApiEndpoints {
  static String baseUrl = "";
}
''';

String usecaseContent = '''
import 'package:dartz/dartz.dart';
import '../failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
''';

String configInjectionContent = '''
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'configure_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  getIt.init(environment: Environment.prod);
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

String failuresContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
class Failure with _\$Failure {
  factory Failure.apiRequestFailure(String error) = ApiRequestFailure;
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

String routesContent = '''
import 'package:flutter/material.dart';
import '../../features/home/presentation/screens/home_screen.dart';


class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => const HomeScreen());
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

String themeContent = '''
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: getTextTheme(isDark: false),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: getTextTheme(isDark: true),
  );
}

TextTheme getTextTheme({required bool isDark}) {
  TextTheme lightTextTheme = const TextTheme();
  TextTheme darkTextTheme = const TextTheme();

  if (isDark) {
    return darkTextTheme;
  } else {
    return lightTextTheme;
  }
}

''';
String colorsContent = '''
import 'package:flutter/material.dart';

class AppColors {
  static const blackColor = Colors.black;
  static const whiteColor = Colors.white;
}

''';

String mainContent = '''
import 'dart:async';

import 'package:flutter/material.dart';
import 'app.dart';
import 'core/dependancy_injection/config/configure_injection.dart';
import 'core/routes/app_routes.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(
    MyApp(
      appRoutes: AppRoutes(),
    ),
  );
}

''';

String appContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/theme.dart';
import 'features/home/presentation/blocs/home_bloc/home_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoutes});
  final AppRoutes appRoutes;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        )
      ],
      child: MaterialApp(
        title: "App title",
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        onGenerateRoute: appRoutes.onGenerateRoute,
      ),
    );
  }
}


''';

String spaceContent = '''
import 'package:flutter/material.dart';

class Space {
  static SizedBox x(double width) => SizedBox(
        width: width,
      );
  static SizedBox y(double height) => SizedBox(
        height: height,
      );
}
''';

String responsiveContent = '''
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key, required this.desktop, this.tablet, required this.mobile});
  final Widget desktop;
  final Widget? tablet;
  final Widget mobile;

  static bool isMobile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < 500;
  }

  static bool isTabltet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 500 && width < 1024;
  }

  static bool isDestop(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return desktop;
        } else if (constraints.maxWidth > 500 && constraints.maxWidth < 1024) {
          return tablet == null ? mobile : tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
''';

String dataSourceContent = '''
abstract class ${CreateFeature.featureName.pascalCase}DataSource{}
class ${CreateFeature.featureName.pascalCase}DataSourceImpl implements ${CreateFeature.featureName.pascalCase}DataSource{} 
''';

String repoImplContent = '''
import '../../domain/repositories/${CreateFeature.featureName.snakeCase}_repository.dart';

class ${CreateFeature.featureName.pascalCase}RepoImpl implements ${CreateFeature.featureName.pascalCase}Repository{

}

''';

String repoContent = '''
abstract class ${CreateFeature.featureName.pascalCase}Repository{

}

''';

String screenContent = '''
import 'package:flutter/material.dart';

class ${CreateFeature.featureName.pascalCase}Screen extends StatelessWidget {
  const ${CreateFeature.featureName.pascalCase}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

''';

String homeScreenContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home_bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App- Easy Init CLI"),
      ),
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Text(
              "\${state.count}",
              style: theme.textTheme.headlineLarge,
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<HomeBloc>().add(const Increment());
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              context.read<HomeBloc>().add(const Decrement());
            },
          ),
        ],
      ),
    );
  }
}




''';

const String homeBlocContent = '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<Increment>((event, emit) {
      emit(state.copyWith(count: state.count + 1));
    });
    on<Decrement>((event, emit) {
      emit(state.copyWith(count: state.count - 1));
    });
  }
}


''';
const String homeEventContent = '''
part of 'home_bloc.dart';

@freezed
class HomeEvent with _\$HomeEvent {
  const factory HomeEvent.increment() = Increment;
  const factory HomeEvent.decrement() = Decrement;
}

''';
const String homeStateContent = '''
part of 'home_bloc.dart';

@freezed
class HomeState with _\$HomeState {
  const factory HomeState({required int count}) = _Initial;
  factory HomeState.initial() => const HomeState(count: 0);
}

''';

String loginScreenContent = '''
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String signupScreenContent = '''
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String forgotPasswordScreenContent = '''
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String otpScreenContent = '''
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';
