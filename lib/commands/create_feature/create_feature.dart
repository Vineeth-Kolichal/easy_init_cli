import 'dart:io';

import 'package:easy_init_cli/utils/user_input.dart';
import 'package:easy_init_cli/interfaces/command.dart';

import '../../core/structure/export_structure.dart';
import '../../functions/create.dart';

class CreateFeature extends Command {
  static String featureName = "home";

  @override
  String get commandName => "feature";

  @override
  Future<void> excecute() async {
    if (name != '') {
      featureName = name;
    } else {
      featureName = UserInput.askQuestion("Feature name", "home");
    }
    var isExist = await isFeatureExist(featureName);
    if (isExist) {
      redLog(
          "Feature with name '$featureName' already exist, retry with different name");
    } else {
      blueLog("Creating $featureName feature");
      List<Directory> directories =
          TddCleanStructure().featureStructure.values.toList();
      createListDirectories(directories);
      createFiles(TddCleanStructure().featureFiles);
      greenLog("Successfully created $featureName feature");
    }
  }

  Future<bool> isFeatureExist(featureName) async {
    var path = Directory.current.path;
    return await Directory("$path/lib/features/$featureName").exists();
  }
}
