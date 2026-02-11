import 'dart:async';

import 'package:easy_init_cli/easy_init_logo.dart';
import 'package:easy_init_cli/interfaces/logging.dart';
import 'package:process_run/shell.dart';
import 'package:easy_init_cli/core/changelog_fetcher.dart';

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

  Future<void> addDependencies(
      {required String dependencies, String? devDependencies}) async {
    await run("flutter pub add $dependencies");
    if (devDependencies != null) {
      await run("flutter pub add --dev $devDependencies");
    }
  }

  Future<void> pubGet() async {
    await run("flutter pub get");
  }

  Future<void> runBuildRunner() async {
    Timer(Duration(milliseconds: 500), () async {
      blueLog("Running build_runner");
      await run("dart run build_runner build --delete-conflicting-outputs");
    });
  }

  Future<void> update() async {
    blueLog("Updating....");
    print("");
    blueLog(logo);
    print('');

    try {
      // run() from dcli returns List<String> of lines or similar if capture is used,
      // but here we are using it as a void or generic execution.
      // Wait, dcli 'run' command usually returns void or throws.
      // Let's check      final result = await run("dart pub global activate easy_init_cli", verbose: false);

      // result is List<ProcessResult>
      final result =
          await run("dart pub global activate easy_init_cli", verbose: false);
      final output = result.map((e) => e.stdout.toString()).join('\n');

      final versionPattern =
          RegExp(r'Activated easy_init_cli (\d+\.\d+\.\d+)\.');
      final match = versionPattern.firstMatch(output);

      greenLog("Updated successfully");

      if (match != null) {
        final newVersion = match.group(1);
        if (newVersion != null) {
          await ChangelogFetcher.displayChangelog(newVersion);
        }
      }
    } catch (e) {
      greenLog("Updated successfully");
    }
  }
}
