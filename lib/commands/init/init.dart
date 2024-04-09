import 'dart:async';
import 'dart:io';

import 'package:easy_init_cli/core/structure/structure.dart';
import 'package:easy_init_cli/utils/user_input.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:easy_init_cli/core/structure/export_structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:recase/recase.dart';

class InitProject extends Command {
  @override
  String get commandName => "init";

  @override
  Future<void> excecute() async {
    final lib = Directory('lib');
    if (lib.existsSync()) {
      final tdd = File('easy_init_tdd_clean');
      final mvc = File('easy_init_mvc');
      final tddExist = tdd.existsSync();
      final mvcExist = mvc.existsSync();

      if (tddExist) {
        showWarning("tdd clean");
        return;
      } else if (mvcExist) {
        showWarning("mvc");
        return;
      }

      var choice = UserInput.menu(options: [
        "TDD+Clean Architecture - BLoC - REST API - Feature wise",
        "MVC - GetX - REST API - Layer wise"
      ], promt: "Choose architecture pattern");
      print("");
      blueLog("Initializing your project...");
      print("");
      switch (choice) {
        case 1:
          await _initArchitecture(
            structure: TddCleanStructure(),
            dependencies:
                "dartz flutter_bloc injectable freezed_annotation get_it dio intl",
            devDependencies:
                "build_runner freezed injectable_generator mocktail",
          );
          break;
        case 2:
          await _initArchitecture(
            structure: MvcGetXStructure(),
            dependencies: "dartz get dio intl",
            devDependencies: "build_runner mocktail",
            runBuildRunner: false,
          );
          break;
        default:
          print("Choice not found");
          break;
      }
    } else {
      redLog("[ERROR] lib folder not found");
    }
  }

  Future<void> _initArchitecture({
    required Structure structure,
    required String dependencies,
    required String devDependencies,
    bool runBuildRunner = true,
  }) async {
    List<Directory> directories = structure.directoryStructure.values.toList();
    List<Directory> sampleFeatureDirectories =
        structure.featureStructure.values.toList();
    // Creating folder structure
    createListDirectories(
      [
        ...directories,
        ...sampleFeatureDirectories,
      ],
    );
    //Creating files
    createFiles(structure.coreFiles);
    //Adding dependancies and dev dependancies
    await ShellUtils().addDependencies(
      dependencies: dependencies,
      devDependencies: devDependencies,
    );
    //Running build runner to generate files,
    if (runBuildRunner) {
      await ShellUtils().pubGet();
      await ShellUtils().runBuildRunner();
    }

    greenLog(
      "Project initialized with ${structure.architectureName} architecture",
    );
  }

  void showWarning(String archName) {
    yellowLog(
        "[WARNING] Project is already initialized with ${archName.toUpperCase()} architecture pattern");
    print('''If you wanted to change architecture pattern;
 > Remove all folders and files from lib folder.
 > Remove 'easy_init_${archName.snakeCase}' file form root folder. 
 > Run 'easy init' command again''');
  }
}
