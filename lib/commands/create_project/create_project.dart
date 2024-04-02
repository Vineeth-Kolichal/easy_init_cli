import 'dart:io';

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
    bool isExist = await isProjectExist(name.snakeCase);
    if (isExist) {
      redLog(
          "Project with name '${name.snakeCase}' is already exist, retry with different name");
    } else {
      final org =
          UserInput.askQuestion("Your organization domain", "com.example");

      await ShellUtils().flutterCreate(projectName: name.snakeCase, org: org);
    }
  }

  Future<bool> isProjectExist(String name) async {
    var path = Directory.current.path;
    return await Directory("$path/$name").exists();
  }
}
