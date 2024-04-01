import 'dart:io';

class Structure {
  Map<String, Directory> directoryStructure = {};
  Map<String, Directory> featureStructure = {};
  List<FileModel> coreFiles = [];
  List<FileModel> featureFiles = [];

  String replaceAsExpected({required String path, String? replaceChar}) {
    if (path.contains('\\')) {
      if (Platform.isLinux || Platform.isMacOS) {
        return path.replaceAll('\\', '/');
      } else {
        return path;
      }
    } else if (path.contains('/')) {
      if (Platform.isWindows) {
        return path.replaceAll('/', '\\\\');
      } else {
        return path;
      }
    } else {
      return path;
    }
  }
}

class FileModel {
  final String _filePath;
  final String _content;
  final String _fileName;
  FileModel(this._filePath, this._fileName, this._content);

  String get filePath => "$_filePath/$_fileName";
  String get content => _content;
}
