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

import '../../controllers/trivia_controllers/trivia_controller.dart';
import '../../views/screens/number_trivia_screen.dart';

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
// String mvcMainContent = '''''';
// String mvcMainContent = '''''';
// String mvcMainContent = '''''';
