import 'package:easy_init_cli/utils/user_input.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:recase/recase.dart';

import '../../interfaces/command.dart';

class CreateProject extends Command {
  @override
  String get commandName => "project";

  @override
  Future<void> excecute() async {
    final name = UserInput.askQuestion("Your project name", "todo app");
    final org = UserInput.askQuestion("Your organization name", "com.example");
    await ShellUtils().flutterCreate(projectName: name.snakeCase, org: org);
  }
}
