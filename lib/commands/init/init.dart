import 'dart:io';

import 'package:easy_init_cli/core/structure.dart';
import 'package:easy_init_cli/functions/create.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

class InitProject extends Command with Logging {
  @override
  String get commandName => "init";

  @override
  Future<void> excecute() async {
    List<Directory> directories =
        Structure.cleanArchitectureStructure.values.toList();
    createListDirectories(directories);
    createFiles(Structure.files);

//     File file = File(filePath);
//     String content = '''
// // This is the content of the generated file

// void main() {
//   print('Hello from generated file!');
// }
// ''';
//     await file.writeAsString(content);
//     greenLog("is it working, :$currentPath");
  }
}
