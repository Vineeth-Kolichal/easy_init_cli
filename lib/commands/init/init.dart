import 'dart:async';
import 'dart:io';

import 'package:easy_init_cli/core/structure/structure.dart';
import 'package:easy_init_cli/utils/user_input.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:easy_init_cli/core/structure/export_structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/interfaces/command.dart';

class InitProject extends Command {
  @override
  String get commandName => "init";

  @override
  Future<void> excecute() async {
    var choice = UserInput.menu(options: [
      "TDD+Clean Architecture - BLoC - REST API - Feature wise",
      "MVC - GetX - REST API - Layer wise"
    ], promt: "Choose architecture");
    print("");
    blueLog("Initializing your project...");
    print("");
    // blueLog(logo);
    // print('');
    switch (choice) {
      case 1:
        await _initTddClean();
        break;
      case 2:
        await _initArchitecture(
          structure: MvcGetXStructure(),
          dependancies: "dartz get dio intl",
          devDependancies: "build_runner mocktail",
          archName: "MVC",
        );
        break;
      default:
        print("Choice not found");
        break;
    }
  }

  Future<void> _initTddClean() async {
    List<Directory> directories =
        TddCleanStructure().directoryStructure.values.toList();
    List<Directory> tmpFeatureDirectories =
        TddCleanStructure().featureStructure.values.toList();
    // Creating folder structure
    createListDirectories(
      [
        ...directories,
        ...tmpFeatureDirectories,
      ],
    );
    //Creating files
    createFiles(TddCleanStructure().coreFiles);
    // adding required dependancies
    await ShellUtils().addDependancies(
      dependancies:
          "dartz flutter_bloc injectable freezed_annotation get_it dio intl",
      devDependancies: "build_runner freezed injectable_generator mocktail",
    );
    //Running build runner to generate files
    await ShellUtils().runBuildRunner();
    greenLog("Project initialized with TDD+Clean architecture");
  }

  Future<void> _initArchitecture({
    required Structure structure,
    required String dependancies,
    required String devDependancies,
    required String archName,
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
    createFiles(MvcGetXStructure().coreFiles);
    //Adding dependancies and dev dependancies
    await ShellUtils().addDependancies(
      dependancies: dependancies,
      devDependancies: devDependancies,
    );
    //Running build runner to generate files
    await ShellUtils().runBuildRunner();
    greenLog("Project initialized with $archName architecture");
  }
}
