import 'dart:io';

import 'package:easy_init_cli/core/structure/structure.dart';
import 'package:easy_init_cli/core/structure/tdd_clean_structure/file_contents/file_contents.dart';
import 'package:easy_init_cli/core/structure/tdd_clean_structure/tdd_clean_structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/functions/find_current_architecture.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:easy_init_cli/utils/user_input.dart';

class CreateServices extends Command {
  @override
  String get commandName => "services";

  @override
  Future<void> excecute() async {
    final lib = Directory('lib');
    if (lib.existsSync()) {
      final arch = findCurrentArchitecture();
      if (arch != null) {
        var choice = UserInput.menu(options: [
          "FCM Services",
          "Token Manager",
          "Shared Preferences Services"
        ], promt: "Choose any available services (example:1)");
        print("");
        blueLog("creating services file in lib/core/services/ directory...");
        print("");
        switch (choice) {
          case 1:
            await createFcmHelper();
            break;
          case 2:
            await createTokenManager();
            break;
          case 3:
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
    if (Directory(
            TddCleanStructure().directoryStructure[CleanDirName.services]!.path)
        .existsSync()) {
      await ShellUtils().addDependencies(
        dependencies:
            "firebase_core firebase_messaging flutter_local_notifications",
      );
      createFiles([
        FileModel(
          TddCleanStructure().directoryStructure[CleanDirName.services]!.path,
          "fcm_services.dart",
          fcmServicesContent,
        ),
      ]);
      greenLog("Successfully created FCM helper ");
    } else {
      redLog(
          "[ERROR] lib/core/services directory not found\n [ERROR] please create lib/core/services folder and try again");
    }
  }

  Future<void> createSharedPrefsHelper() async {
    if (Directory(
            TddCleanStructure().directoryStructure[CleanDirName.services]!.path)
        .existsSync()) {
      await ShellUtils().addDependencies(
        dependencies: "shared_preferences",
      );
      createFiles([
        FileModel(
          TddCleanStructure().directoryStructure[CleanDirName.services]!.path,
          "sharedprefs_services.dart",
          sharedPrefsServices,
        ),
      ]);
      greenLog("Successfully created SharedPrefServices ");
    } else {
      redLog(
          "[ERROR] lib/core/services directory not found\n [ERROR] please create lib/core/services folder and try again");
    }
  }

  Future<void> createTokenManager() async {
    if (Directory(
            TddCleanStructure().directoryStructure[CleanDirName.services]!.path)
        .existsSync()) {
      await ShellUtils().addDependencies(
        dependencies: "flutter_secure_storage",
      );
      createFiles([
        FileModel(
          TddCleanStructure().directoryStructure[CleanDirName.services]!.path,
          "token_manager.dart",
          tokenHandler,
        ),
      ]);
      greenLog("Successfully created Token manager ");
    } else {
      redLog(
          "[ERROR] lib/core/services directory not found\n [ERROR] please create lib/core/services folder and try again");
    }
  }
}
