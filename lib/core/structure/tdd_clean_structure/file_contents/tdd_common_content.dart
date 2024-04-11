import 'package:easy_init_cli/commands/create_feature/create_feature.dart';
import 'package:recase/recase.dart';

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

String failuresContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
class Failure with _\$Failure {
  factory Failure.apiRequestFailure(String error) = ApiRequestFailure;
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

String dataSourceContent = '''
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


abstract class ${CreateFeature.featureName.pascalCase}DataSource{}

@LazySingleton(as:${CreateFeature.featureName.pascalCase}DataSource)
@injectable
class ${CreateFeature.featureName.pascalCase}DataSourceImpl implements ${CreateFeature.featureName.pascalCase}DataSource{
  final Dio dio;
  ${CreateFeature.featureName.pascalCase}DataSourceImpl(this.dio);
} 
''';

String repoImplContent = '''
import 'package:injectable/injectable.dart';
import '../../domain/repositories/${CreateFeature.featureName.snakeCase}_repository.dart';
import '../data_sources/${CreateFeature.featureName.snakeCase}_datasource.dart';

@LazySingleton(as: ${CreateFeature.featureName.pascalCase}Repository)
@injectable
class ${CreateFeature.featureName.pascalCase}RepoImpl implements ${CreateFeature.featureName.pascalCase}Repository{
  ${CreateFeature.featureName.pascalCase}DataSource ${CreateFeature.featureName.camelCase}DataSource;
  ${CreateFeature.featureName.pascalCase}RepoImpl(this.${CreateFeature.featureName.camelCase}DataSource);
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
