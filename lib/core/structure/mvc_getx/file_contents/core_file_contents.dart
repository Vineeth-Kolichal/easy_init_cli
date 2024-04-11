import 'package:recase/recase.dart';

import '../../../../commands/create_feature/create_feature.dart';

String mvcMainContent = '''
import 'dart:async';

import 'package:flutter/widgets.dart';

import 'application/app.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
''';
String mvcAppContent = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/routes/routes.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: "/",
      getPages: AppRoutes.getPages,
    );
  }
}
''';

String mvcRouteContent = '''
import 'package:get/get.dart';

import '../../controllers/number_trivia/number_trivia_controller.dart';
import '../../views/number_trivia/screens/number_trivia_screen.dart';

class AppRoutes {
  static List<GetPage> getPages = [
    GetPage(
      name: "/",
      page: (() => const NumberTriviaScreen()),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => TriviaController());
        },
      ),
    ),
  ];
}

''';
String mvcScreenContent = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/${CreateFeature.featureName.snakeCase}/${CreateFeature.featureName.snakeCase}_controller.dart';

class ${CreateFeature.featureName.pascalCase}Screen extends GetView<${CreateFeature.featureName.pascalCase}Controller> {
  const ${CreateFeature.featureName.pascalCase}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String mvcCntrlContent = '''
import 'package:get/get.dart';

import '../../services/${CreateFeature.featureName.snakeCase}/${CreateFeature.featureName.snakeCase}_service.dart';

class ${CreateFeature.featureName.pascalCase}Controller extends GetxController {
  ${CreateFeature.featureName.pascalCase}Service service = ${CreateFeature.featureName.pascalCase}Service();
}
''';

String mvcServiceContent = '''
class ${CreateFeature.featureName.pascalCase}Service{
  
}''';
