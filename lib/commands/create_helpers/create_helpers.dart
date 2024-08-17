import 'dart:io';

import 'package:easy_init_cli/core/structure/structure.dart';
import 'package:easy_init_cli/core/structure/tdd_clean_structure/file_contents/file_contents.dart';
import 'package:easy_init_cli/core/structure/tdd_clean_structure/tdd_clean_structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/functions/find_current_architecture.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:easy_init_cli/utils/user_input.dart';

class CreateHelpers extends Command {
  @override
  String get commandName => "helper";

  @override
  Future<void> excecute() async {
    final lib = Directory('lib');
    if (lib.existsSync()) {
      final arch = findCurrentArchitecture();
      if (arch != null) {
        var choice = UserInput.menu(
            options: ["FCM helper", "Shared Preferences helper"],
            promt: "Choose any available helpers (example:1)");
        print("");
        blueLog("creating helper file in lib/common/helpers/ directory...");
        print("");
        switch (choice) {
          case 1:
            await createFcmHelper();
            break;
          case 2:
            await createSharedPrefsHelper();
            break;
          default:
            print("Choice not found");
            break;
        }
      }
    } else {
      redLog("[ERROR] lib folder not found");
    }
  }

  Future<void> createFcmHelper() async {
    if (Directory(TddCleanStructure()
            .directoryStructure[CleanDirName.commonHelpers]!
            .path)
        .existsSync()) {
      await ShellUtils().addDependencies(
        dependencies:
            "firebase_core firebase_messaging flutter_local_notifications",
      );
      createFiles([
        FileModel(
          TddCleanStructure()
              .directoryStructure[CleanDirName.commonHelpers]!
              .path,
          "fcm_helper.dart",
          fcmHelperContent,
        ),
      ]);
      greenLog("Successfully created FCM helper ");
    } else {
      redLog("[ERROR] lib/common/helpers directory not found");
    }
  }

  Future<void> createSharedPrefsHelper() async {
    if (Directory(TddCleanStructure()
            .directoryStructure[CleanDirName.commonHelpers]!
            .path)
        .existsSync()) {
      await ShellUtils().addDependencies(
        dependencies: "shared_preferences",
      );
      createFiles([
        FileModel(
          TddCleanStructure()
              .directoryStructure[CleanDirName.commonHelpers]!
              .path,
          "sharedprefs_helper.dart",
          sharedPrefsHelper,
        ),
      ]);
      greenLog("Successfully created SharedPrefshelper ");
    } else {
      redLog("[ERROR] lib/common/helpers directory not found");
    }
  }
}
