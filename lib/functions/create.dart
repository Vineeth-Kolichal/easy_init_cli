import 'dart:io';

import '../core/structure.dart';

void createListDirectories(List<Directory> directories) {
  for (var dir in directories) {
    dir.createSync();
  }
}

void createFiles(List<FileModel> files) async {
  for (var f in files) {
    File file = File(f.filePath);
    await file.writeAsString(f.content);
  }
}
