// import 'package:dcli/dcli.dart';

import 'dart:async';

import 'package:easy_init_cli/interfaces/logging.dart';
import 'package:process_run/shell.dart';

import '../core/structure/tdd_clean_structure/file_contents/file_contents.dart';

class ShellUtils with Logging {
  Future<void> flutterCreate(
      {required String projectName, required String org}) async {
    blueLog("Project creating.....");
    await run('flutter create $projectName --no-pub --org $org');
    greenLog("🚀🚀 Successfully created project");
    print(
        "Use the cd command in the terminal to navigate to the project's root directory.");
    blueLog("   \$ cd $projectName");
    print(
        "To initialize your project with well-structured architecture, run the following command");
    blueLog("   \$ easy init");
  }

  Future<void> addDependancies() async {
    await run(
        "flutter pub add dartz flutter_bloc injectable freezed_annotation get_it dio intl");
    await run(
        "flutter pub add --dev build_runner freezed injectable_generator mocktail");
  }

  Future<void> runBuildRunner() async {
    await run("flutter pub get");
    Timer(Duration(milliseconds: 1000), () async {
      blueLog("Running build_runner");
      await run("dart run build_runner build");
    });
  }

  Future<void> update() async {
    blueLog("Updating....");
    print("");
    blueLog(logo);
    print('');
    await run("dart pub global activate easy_init_cli");
    greenLog("Updated successfully");
  }
}
