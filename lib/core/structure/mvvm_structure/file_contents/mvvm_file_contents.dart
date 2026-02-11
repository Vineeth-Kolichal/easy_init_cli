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
import 'features/number_trivia/view_model/number_trivia_view_model.dart';

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
        ChangeNotifierProvider(
          create: (context) => getIt<NumberTriviaViewModel>(),
        ),
      ],
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

const String numberTriviaViewModelContent =
    '''import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../data/repositories/number_trivia_repository.dart';
import '../models/trivia_model.dart';
import '../../../../core/failures/failures.dart';

@injectable
class NumberTriviaViewModel extends ChangeNotifier {
  final NumberTriviaRepository repository;

  NumberTriviaViewModel(this.repository);

  TriviaModel? _trivia;
  TriviaModel? get trivia => _trivia;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> getConcreteNumberTrivia(int number) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _trivia = await repository.getNumberTrivia(NumberParam(number));
    } on Failure catch (e) {
      _error = e.maybeMap(
        apiRequestFailure: (f) => f.error,
        orElse: () => 'Unexpected Error',
      );
    } catch (e) {
      _error = 'Unexpected Error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
''';

const String numberTriviaScreenContent =
    '''import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../common/widgets/loading.dart';
import '../../view_model/number_trivia_view_model.dart';

/// to validate form [_formKey] is used
final _formKey = GlobalKey<FormState>(); // GlobalKey to manage the form state

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Getting instance of NumberTriviaViewModel using context
    // final triviaViewModel = context.read<NumberTriviaViewModel>();
    final numberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia by Easy Init"), // AppBar title
      ),
      body: Consumer<NumberTriviaViewModel>(
        builder: (context, provider, child) {
          /// This Loading widget is used here solely to demonstrate its usage in your project.
          /// You can utilize other loading types as the situation dictates.
          /// If you need to display a loading indicator across the entire screen,
          /// this Loading widget can be employed.
          return Loading(
            isLoading: provider.isLoading,
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Padding for the body
              child: Form(
                key: _formKey, // Assigning the GlobalKey to the Form widget
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centering widgets vertically
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: context.screenWidth,
                          constraints: const BoxConstraints(minHeight: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.setThemeBasedColor(
                              darkThemeColor: const Color.fromARGB(
                                255,
                                22,
                                22,
                                22,
                                22,
                              ),
                              lightThemeColor: const Color.fromARGB(
                                255,
                                244,
                                244,
                                244,
                                59,
                              ),
                            ), // Setting container background color
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Builder(
                                builder: (context) {
                                  if (provider.error != null) {
                                    return Text(
                                      "\${provider.error}", // Displaying error message if any
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                  return Text(
                                    provider.trivia == null
                                        ? provider.isLoading
                                              ? ""
                                              : "Enter a number and click Get Triva button" // Placeholder message
                                        : "\${provider.trivia?.text}", // Displaying trivia text
                                    textAlign: TextAlign.center,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    TextFormField(
                      controller:
                          numberController, // Binding the TextEditingController
                      keyboardType:
                          TextInputType.number, // Allowing only number input
                      decoration: InputDecoration(
                        hintText: "Enter a number",
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a number"; // Validation message if the field is empty
                        }
                        return null;
                      },
                    ),
                    // Adding vertical space
                    10.verticalSpace,

                    SizedBox(
                      height: 44,
                      width: context.screenWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // Setting button background color
                          backgroundColor: context.appColors?.onSurface,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            provider.getConcreteNumberTrivia(
                              int.parse(numberController.text),
                            );
                          }
                        },
                        child: Text(
                          "Get Trivia", // Button text
                          style: context.labelLarge(
                            color: context.appColors?.surfaceColor,
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace, // Adding vertical space
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
''';

const String numberTriviaRepositoryContent =
    '''import 'package:injectable/injectable.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/network/network_exceptions.dart';
import '../../models/trivia_model.dart';
import '../data_sources/number_trivia_remote_data_source.dart';

abstract class NumberTriviaRepository {
  Future<TriviaModel> getNumberTrivia(NumberParam params);
}

@LazySingleton(as: NumberTriviaRepository)
@injectable
class NumberTriviaRepoImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource numberTriviaDataSource;
  NumberTriviaRepoImpl(this.numberTriviaDataSource);

  @override
  Future<TriviaModel> getNumberTrivia(NumberParam params) async {
    try {
      final trivia = await numberTriviaDataSource.getConcreteTrivia(params);
      return trivia;
    } on CustomException catch (e) {
      throw Failure.apiRequestFailure(e.message);
    } catch (e) {
      throw Failure.unexpectedFailure("Something went wrong");
    }
  }
}

class NumberParam {
  final int number;

  NumberParam(this.number);
}
''';

const String numberTriviaRemoteDataSourceContent =
    '''import 'package:injectable/injectable.dart';

import '../../../../../core/network/network_client.dart';
import '../../models/trivia_model.dart';
import '../repositories/number_trivia_repository.dart';

// Abstract class representing a data source for fetching number trivia
abstract class NumberTriviaRemoteDataSource {
  Future<TriviaModel> getConcreteTrivia(
    NumberParam params,
  ); // Method for getting concrete trivia
}

// Registering NumberTriviaRemoteDataSource as a lazy singleton for dependency injection
@LazySingleton(as: NumberTriviaRemoteDataSource)
@injectable
class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final NetworkClient client;

  NumberTriviaRemoteDataSourceImpl(
    this.client,
  ); // Constructor injecting NetworClient dependency

  @override
  Future<TriviaModel> getConcreteTrivia(NumberParam params) async {
    try {
      // Making GET request to fetch trivia
      final response = await client.get(
        path: "/\${params.number}/trivia?json",
        requiresAuth: false,
      );
      // Parsing response data into TriviaModel
      return TriviaModel.fromJson(response.data);
    } catch (e) {
      //throwing exception
      rethrow;
    }
  }
}
''';

const String triviaModelContent = '''class TriviaModel {
  final String text;
  final int number;
  final bool found;
  final String type;

  TriviaModel({
    required this.text,
    required this.number,
    required this.found,
    required this.type,
  });

  factory TriviaModel.fromJson(Map<String, dynamic> json) => TriviaModel(
    text: json["text"],
    number: json["number"],
    found: json["found"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "number": number,
    "found": found,
    "type": type,
  };
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
import '../../features/number_trivia/view/screens/number_trivia_screen.dart';

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
          baseUrl: "http://numbersapi.com",
          flavor: Flavor.dev,
        );
        break;

      case Flavor.prod:
        _instance = FlavorConfig(
          baseUrl: "http://numbersapi.com",
          flavor: Flavor.prod,
        );
        break;
    }
  }

  static FlavorConfig get instance {
    _instance ??= FlavorConfig(
      baseUrl: "http://numbersapi.com",
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
