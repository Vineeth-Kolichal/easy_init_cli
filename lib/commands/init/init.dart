import 'dart:async';
import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:easy_init_cli/common/utils/ask_question.dart';
import 'package:easy_init_cli/common/utils/shell_utils.dart';
import 'package:easy_init_cli/core/file_contents.dart';
import 'package:easy_init_cli/core/structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

class InitProject extends Command with Logging {
  @override
  String get commandName => "init";

  @override
  Future<void> excecute() async {
    var choice = UserInput.menu(
        options: ["TDD Clean Architecture"], promt: "Choose architecture");

    blueLog("Initializing your project...");
    print("");
    blueLog(logo);
    print('');
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
        Structure.cleanArchitectureStructure.values.toList();
    List<Directory> homeFeatureDirectories =
        Structure.cleanArchitectureFeatureStructure.values.toList();

    createListDirectories(
      [
        ...directories,
        ...homeFeatureDirectories,
      ],
    );
    createFiles(Structure.cleanArchFiles);
    await ShellUtils().addDependancies();
    await ShellUtils().runBuildRunner();
    greenLog("Project initialized with TDD Clean architecture");
  }
}
