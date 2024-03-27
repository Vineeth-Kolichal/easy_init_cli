import 'dart:io';

import 'package:easy_init_cli/common/utils/ask_question.dart';
import 'package:easy_init_cli/common/utils/shell_utils.dart';
//import 'package:dcli/dcli.dart';
import 'package:recase/recase.dart';

import '../../interfaces/command.dart';

class CreateProject extends Command {
  @override
  String get commandName => "project";

  @override
  Future<void> excecute() async {
    final currentPath = Directory.current;

    final name = askQuestion("Your project name", "todo app");
    final org = askQuestion("Your organization name", "com.example");
    ShellUtils().flutterCreate(projectName: name.snakeCase, org: org);
  }
}
