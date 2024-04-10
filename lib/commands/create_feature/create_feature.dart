import 'dart:io';

import 'package:easy_init_cli/core/structure/structure.dart';
import 'package:easy_init_cli/functions/find_current_architecture.dart';
import 'package:easy_init_cli/utils/user_input.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:recase/recase.dart';

import '../../core/structure/export_structure.dart';
import '../../functions/create.dart';

class CreateFeature extends Command {
  static String featureName = "number trivia";

  @override
  String get commandName => "feature";

  @override
  Future<void> excecute() async {
    final arch = findCurrentArchitecture();
    if (arch == null) {
      redLog(
          "[ERROR] project is not initialized or 'easy_init_...' file is missing from root folder");
    } else {
      if (name != '') {
        featureName = name;
      } else {
        featureName = UserInput.askQuestion("Feature name", "home");
      }
      var isExist = await isFeatureExist(featureName.snakeCase, arch);
      if (isExist == true) {
        redLog(
            "[ERROR] Feature with name '$featureName' already exist, retry with different name");
      } else if (isExist == false) {
        if (arch == 'tdd-brf') {
          _createFeature(
              structure: TddCleanStructure(), featureName: featureName);
        } else if (arch == "mvc-grl") {
          _createFeature(
              structure: MvcGetXStructure(), featureName: featureName);
        }
      } else {
        redLog("[ERROR] feature creation failed");
      }
    }
  }

  void _createFeature(
      {required Structure structure, required String featureName}) {
    blueLog("Creating $featureName feature");
    List<Directory> directories = structure.featureStructure.values.toList();
    createListDirectories(directories);
    createFiles(structure.featureFiles);
    greenLog("Successfully created $featureName feature");
  }

  Future<bool?> isFeatureExist(String featureName, String arch) async {
    var path = Directory.current.path;
    if (arch == "tdd-brf") {
      return await Directory("$path/lib/features/$featureName").exists();
    } else if (arch == "mvc-grl") {
      return (await Directory("$path/lib/application/views/$featureName")
              .exists() ||
          await Directory("$path/lib/application/controllers/$featureName")
              .exists());
    }
    return null;
  }
}
