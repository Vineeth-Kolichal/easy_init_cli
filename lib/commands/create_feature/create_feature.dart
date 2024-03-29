import 'dart:io';

import 'package:easy_init_cli/common/utils/ask_question.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

import '../../core/structure.dart';
import '../../functions/create.dart';

class CreateFeature extends Command with Logging {
  static String featureName = "";
  @override
  String get commandName => "feature";

  @override
  Future<void> excecute() async {
    featureName = askQuestion("Feature name", "home");
    blueLog("Creating $featureName feature");

    List<Directory> directories =
        Structure.cleanArchitectureFeatureStructure.values.toList();
    createListDirectories(directories);
    //  createFiles(Structure.cleanArchFiles);
    // await ShellUtils().addDependancies();
    // await ShellUtils().runBuildRunner();
    greenLog("Successfully created $featureName feature");
  }
}
