import 'dart:async';
import 'dart:io';

import 'package:easy_init_cli/utils/user_input.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:easy_init_cli/core/export_structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

class InitProject extends Command with Logging {
  @override
  String get commandName => "init";

  @override
  Future<void> excecute() async {
    var choice = UserInput.menu(options: [
      "TDD Clean Architecture - BLoC (feature wise)",
    ], promt: "Choose architecture");
    print("");
    blueLog("Initializing your project...");
    print("");
    // blueLog(logo);
    // print('');
    switch (choice) {
      case 1:
        await initTddClean();
        break;
      default:
        print("Choice not found");
        break;
    }
  }

  Future<void> initTddClean() async {
    List<Directory> directories =
        TddCleanStructure().directoryStructure.values.toList();
    List<Directory> homeFeatureDirectories =
        TddCleanStructure().featureStructure.values.toList();

    createListDirectories(
      [
        ...directories,
        ...homeFeatureDirectories,
      ],
    );
    createFiles(TddCleanStructure().coreFiles);
    await ShellUtils().addDependancies();
    await ShellUtils().runBuildRunner();
    greenLog("Project initialized with TDD Clean architecture");
  }
}
