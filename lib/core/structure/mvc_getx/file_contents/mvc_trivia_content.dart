String triviaScreenCnt = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/space.dart';
import '../../../controllers/number_trivia/number_trivia_controller.dart';
import '../../../utils/theme/colors.dart';



/// to validate form [_formKey] is used
final _formKey = GlobalKey<FormState>(); // GlobalKey to manage the form state

class NumberTriviaScreen extends GetView<TriviaController> {
  const NumberTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// The [theme] variable holds the current theme information.
    /// This allows you to implement a UI that adapts to light and dark themes.
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia by Easy Init"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.numberController,
                keyboardType: TextInputType.number,
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
                    return "Enter a number";
                  }
                  return null;
                },
              ),
              Space.y(10),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blackColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.getTrivia();
                    }
                  },
                  child: Text(
                    "Get Trivia",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              Space.y(10),
              Container(
                width: size.width,
                constraints: const BoxConstraints(minHeight: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 244, 244, 244),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: GetBuilder<TriviaController>(
                    builder: (controller) {
                      if (controller.isLoading) {
                        return const CircularProgressIndicator(
                          strokeWidth: 2,
                        );
                      }
                      if (controller.error != null) {
                        return Text(
                          "\${controller.error}",
                          textAlign: TextAlign.center,
                        );
                      }
                      return Text(
                        controller.trivia == null
                            ? "Enter a number and click Get Triva button"
                            : "\${controller.trivia?.text}",
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
String triviaControllerCnt = '''
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/number_trivia/number_trivia_model.dart';
import '../../services/number_trivia/number_trivia_service.dart';
import '../../utils/network_exceptions/network_exceptions.dart';

class TriviaController extends GetxController {
  TextEditingController numberController = TextEditingController();
  TriviaServices services = TriviaServices(Dio());
  bool isLoading = false;
  String? error;
  TriviaModel? trivia;
  Future<void> getTrivia() async {
    isLoading = true;
    update();
    final number = int.parse(numberController.text.trim());
    try {
      trivia = await services.getTriviaFromApi(number);
      isLoading = false;
      numberController.clear();
      update();
    } on CustomException catch (e) {
      error = e.message;
      isLoading = false;
      numberController.clear();
      update();
    } catch (e) {
      error = e.toString();
      update();
    }
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }
}

''';
String triviaModelCnt = '''
class TriviaModel {
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
String triviaServicesCnt = '''
import 'package:dio/dio.dart';

import '../../models/number_trivia/number_trivia_model.dart';
import '../../utils/api_endpoints/api_endpoints.dart';
import '../../utils/network_exceptions/network_exceptions.dart';

class TriviaServices {
  final Dio dio;
  TriviaServices(this.dio);
  Future<TriviaModel> getTriviaFromApi(int number) async {
    try {
      final response =
          await dio.get('\${ApiEndpoints.baseUrl}/\$number/trivia?json');
      return TriviaModel.fromJson(response.data);
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    }
  }
}


''';
