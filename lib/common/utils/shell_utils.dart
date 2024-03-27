// import 'package:dcli/dcli.dart';

import 'package:easy_init_cli/interfaces/logging.dart';
import 'package:process_run/shell.dart';

class ShellUtils with Logging {
  void flutterCreate({required String projectName, required String org}) async {
    blueLog("Project creating.....");
    await run('flutter create $projectName --no-pub --org $org');
    greenLog("🚀🚀 Successfully created project");
    print("Open terminal from project's root folder and run the command ");
    blueLog("   \$ easy init");
  }
}
