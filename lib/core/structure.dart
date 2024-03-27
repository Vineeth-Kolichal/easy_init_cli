import 'dart:io';

import 'package:easy_init_cli/core/file_contents.dart';

class Structure {
  static Map<String, Directory> cleanArchitectureStructure = {
    DirName.core: Directory(
      replaceAsExpected(
        path: "lib/core",
      ),
    ),
    DirName.apiEndpoints: Directory(
      replaceAsExpected(
        path: "lib/core/api_endpoints",
      ),
    ),
    DirName.baseUsecase: Directory(
      replaceAsExpected(
        path: "lib/core/base_usecase",
      ),
    ),
    DirName.dependancyInjection: Directory(
      replaceAsExpected(
        path: "lib/core/dependancy_injection",
      ),
    ),
    DirName.failures: Directory(
      replaceAsExpected(
        path: "lib/core/failures",
      ),
    ),
    DirName.networkExceptions: Directory(
      replaceAsExpected(
        path: "lib/core/network_exceptions",
      ),
    ),
    DirName.routes: Directory(
      replaceAsExpected(
        path: "lib/core/routes",
      ),
    ),
    DirName.theme: Directory(
      replaceAsExpected(
        path: "lib/core/theme",
      ),
    ),
    DirName.config: Directory(
      replaceAsExpected(
        path: "lib/core/dependancy_injection/config",
      ),
    ),
    DirName.modules: Directory(
      replaceAsExpected(
        path: "lib/core/dependancy_injection/modules",
      ),
    ),
  };
  static List<FileModel> files = [
    FileModel(
      cleanArchitectureStructure[DirName.apiEndpoints]!.path,
      "api_endpoints.dart",
      apiEndpointContent,
    ),
    FileModel(
      cleanArchitectureStructure[DirName.baseUsecase]!.path,
      "base_usecase.dart",
      usecaseContent,
    ),
  ];

  static String replaceAsExpected({required String path, String? replaceChar}) {
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

class DirName {
  static String core = "core";
  static String apiEndpoints = "apiEndpoints";
  static String baseUsecase = "base_usecase";
  static String dependancyInjection = "dependancy_injection";
  static String failures = "failures";
  static String networkExceptions = "network_exceptions";
  static String routes = "routes";
  static String theme = "theme";
  static String config = "config";
  static String modules = "modules";
}
