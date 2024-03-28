import 'dart:io';

import 'package:easy_init_cli/common/utils/shell_utils.dart';
import 'package:easy_init_cli/core/structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

class InitProject extends Command with Logging {
  @override
  String get commandName => "init";

  @override
  Future<void> excecute() async {
    blueLog("Project initialization started");
    List<Directory> directories =
        Structure.cleanArchitectureStructure.values.toList();
    createListDirectories(directories);
    createFiles(Structure.cleanArchFiles);
    await ShellUtils().addDependancies();
    await ShellUtils().runBuildRunner();
    greenLog("Project initialized with TDD Clean architecture");
  }
}
