import 'dart:io';

import 'package:easy_init_cli/utils/user_input.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

import '../../core/export_structure.dart';
import '../../functions/create.dart';

class CreateFeature extends Command with Logging {
  static String featureName = "home";

  @override
  String get commandName => "feature";

  @override
  Future<void> excecute() async {
    featureName = UserInput.askQuestion("Feature name", "home");
    blueLog("Creating $featureName feature");

    List<Directory> directories =
        TddCleanStructure().featureStructure.values.toList();
    createListDirectories(directories);
    createFiles(TddCleanStructure().featureFiles);
    greenLog("Successfully created $featureName feature");
  }
}
