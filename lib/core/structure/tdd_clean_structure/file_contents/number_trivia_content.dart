const triviaDataSourceContent = '''
import 'package:dio/dio.dart'; // Importing Dio for making HTTP requests
import 'package:injectable/injectable.dart'; // Importing injectable for dependency injection

import '../../../../core/network_exceptions/network_exceptions.dart'; // Importing custom network exceptions
import '../../domain/usecases/get_number_trivia_usecase.dart'; // Importing domain use case
import '../models/trivia_model.dart'; // Importing trivia model

// Abstract class representing a data source for fetching number trivia
abstract class NumberTriviaDataSource {
  Future<TriviaModel> getConcreteTrivia(
      NumberParam params); // Method for getting concrete trivia
}
// Registering NumberTriviaDataSource as a lazy singleton for dependency injection
@LazySingleton(as: NumberTriviaDataSource) 
@injectable
class NumberTriviaDataSourceImpl implements NumberTriviaDataSource {
  final Dio dio; // Dio instance for making HTTP requests

  NumberTriviaDataSourceImpl(this.dio); // Constructor injecting Dio dependency

  @override
  Future<TriviaModel> getConcreteTrivia(NumberParam params) async {
    try {
      // Making GET request to fetch trivia
      final response = await dio.get("/\${params.number}/trivia?json");
      // Parsing response data into TriviaModel
      return TriviaModel.fromJson(response.data);
    } on DioException catch (e) {
      // Handling Dio errors
      // Throwing custom exception based on DioError
      throw CustomException.fromDioError(e);
    }
  }
}


''';

const triviaModelContent = '''
import '../../domain/entities/trivia_entity.dart';

class TriviaModel extends TriviaEntity {
  TriviaModel({
    required super.text,
    required super.number,
    required super.found,
    required super.type,
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

const triviaRepoImplContent = '''
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network_exceptions/network_exceptions.dart';
import '../../domain/entities/trivia_entity.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../../domain/usecases/get_number_trivia_usecase.dart';
import '../data_sources/number_trivia_datasource.dart';

@LazySingleton(as: NumberTriviaRepository)
@injectable
class NumberTriviaRepoImpl implements NumberTriviaRepository {
  NumberTriviaDataSource numberTriviaDataSource;
  NumberTriviaRepoImpl(this.numberTriviaDataSource);

  @override
  Future<Either<Failure, TriviaEntity>> getNumberTrivia(
      NumberParam params) async {
    try {
      final trivia = await numberTriviaDataSource.getConcreteTrivia(params);
      return Right(trivia);
    } on CustomException catch (e) {
      return Left(Failure.apiRequestFailure(e.message));
    }
  }
}


''';

const triviaEntityContent = '''
class TriviaEntity {
  final String text;
  final int number;
  final bool found;
  final String type;

  TriviaEntity({
    required this.text,
    required this.number,
    required this.found,
    required this.type,
  });
}
''';

const triviaRepoContent = '''
import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/trivia_entity.dart';
import '../usecases/get_number_trivia_usecase.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, TriviaEntity>> getNumberTrivia(NumberParam params);
}
''';

const triviaUsecase = '''
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/failures/failures.dart';
import '../entities/trivia_entity.dart';
import '../repositories/number_trivia_repository.dart';

@lazySingleton
@injectable
class GetNumberTriviaUseCase implements UseCase<TriviaEntity, NumberParam> {
  NumberTriviaRepository numberTriviaRepository;
  GetNumberTriviaUseCase(this.numberTriviaRepository);
  @override
  Future<Either<Failure, TriviaEntity>> call(NumberParam params) async {
    return numberTriviaRepository.getNumberTrivia(params);
  }
}

class NumberParam {
  final int number;

  NumberParam(this.number);
}
''';

const triviaBloc = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/trivia_entity.dart'; // Importing domain entity
import '../../../domain/usecases/get_number_trivia_usecase.dart'; // Importing domain use case

part 'number_trivia_event.dart'; // Importing related event class
part 'number_trivia_state.dart'; // Importing related state class
part 'number_trivia_bloc.freezed.dart'; // Importing generated freezed file

@injectable
class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  TextEditingController numberController =
      TextEditingController(); // Controller for handling text input
  GetNumberTriviaUseCase useCase; // Instance of the use case
  NumberTriviaBloc(this.useCase) : super(NumberTriviaState.initial()) {
    on<GetTrivia>((event, emit) async {
      // Event handler for GetTrivia event
      emit(state.copyWith(
          isLoading: true,
          error: null,
          tirvia: null)); // Emitting loading state
      final result = await useCase(
        NumberParam(
          int.parse(
            numberController.text.trim(), // Parsing the input to int
          ),
        ),
      );
      final newState = result.fold((fail) {
        // Handling failure result
        numberController.clear(); // Clearing text input
        return state.copyWith(
            isLoading: false,
            tirvia: null,
            error: fail.error); // Emitting failure state
      }, (trivia) {
        // Handling success result
        numberController.clear(); // Clearing text input
        return state.copyWith(
            isLoading: false,
            error: null,
            tirvia: trivia); // Emitting success state
      });
      emit(newState); // Emitting the new state
    });
  }

  @override
  Future<void> close() {
    numberController.dispose(); // Disposing the controller
    return super.close(); // Closing the bloc
  }
}
''';

const triviaEvent = '''
part of 'number_trivia_bloc.dart';

@freezed
class NumberTriviaEvent with _\$NumberTriviaEvent {
  const factory NumberTriviaEvent.getTrivia() = GetTrivia;
}
''';

const triviaState = '''
part of 'number_trivia_bloc.dart';

@freezed
class NumberTriviaState with _\$NumberTriviaState {
  const factory NumberTriviaState({
    required bool isLoading,
    String? error,
    TriviaEntity? tirvia,
  }) = _Initial;
  factory NumberTriviaState.initial() =>const NumberTriviaState(isLoading: false);
}

''';

const triviaScreen = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/space.dart'; // Importing custom widget for spacing
import '../../../../core/theme/colors.dart'; // Importing custom theme colors
import '../blocs/number_trivia_bloc/number_trivia_bloc.dart'; // Importing the NumberTriviaBloc

/// to validate form [_formKey] is used
final _formKey = GlobalKey<FormState>(); // GlobalKey to manage the form state

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// The [theme] variable holds the current theme information.
    /// This allows you to implement a UI that adapts to light and dark themes.
    ThemeData theme = Theme.of(context); // Getting current theme data
    Size size = MediaQuery.of(context).size; // Getting screen size
    NumberTriviaBloc triviaBloc = context.read<
        NumberTriviaBloc>(); // Getting instance of NumberTriviaBloc using context

    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia by Easy Init"), // AppBar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0), // Padding for the body
        child: Form(
          key: _formKey, // Assigning the GlobalKey to the Form widget
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centering widgets vertically
            children: [
              TextFormField(
                controller: triviaBloc
                    .numberController, // Binding the TextEditingController from bloc
                keyboardType:
                    TextInputType.number, // Allowing only number input
                decoration: InputDecoration(
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
              Space.y(10), // Adding vertical space
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.blackColor, // Setting button background color
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      triviaBloc.add(
                          const GetTrivia()); // Triggering event to get trivia
                    }
                  },
                  child: Text(
                    "Get Trivia", // Button text
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.whiteColor, // Setting button text color
                    ),
                  ),
                ),
              ),
              Space.y(10), // Adding vertical space
              Container(
                width: size.width,
                constraints: const BoxConstraints(minHeight: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(
                      255, 244, 244, 244), // Setting container background color
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const CircularProgressIndicator(
                          strokeWidth:
                              2, // Configuring the circular progress indicator
                        );
                      }
                      if (state.error != null) {
                        return Text(
                          "\${state.error}", // Displaying error message if any
                          textAlign: TextAlign.center,
                        );
                      }
                      return Text(
                        state.tirvia == null
                            ? "Enter a number and click Get Triva button" // Placeholder message
                            : "\${state.tirvia?.text}", // Displaying trivia text
                        textAlign: TextAlign.center,
                      );
                    },
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

''';
