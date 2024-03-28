import 'dart:io';

import 'package:easy_init_cli/core/file_contents.dart';

class Structure {
  static Map<String, Directory> cleanArchitectureStructure = {
    CleanDirName.common: Directory(
      replaceAsExpected(
        path: "lib/common",
      ),
    ),
    CleanDirName.commonWidgets: Directory(
      replaceAsExpected(
        path: "lib/common/widgets",
      ),
    ),
    CleanDirName.core: Directory(
      replaceAsExpected(
        path: "lib/core",
      ),
    ),
    CleanDirName.apiEndpoints: Directory(
      replaceAsExpected(
        path: "lib/core/api_endpoints",
      ),
    ),
    CleanDirName.baseUsecase: Directory(
      replaceAsExpected(
        path: "lib/core/base_usecase",
      ),
    ),
    CleanDirName.dependancyInjection: Directory(
      replaceAsExpected(
        path: "lib/core/dependancy_injection",
      ),
    ),
    CleanDirName.failures: Directory(
      replaceAsExpected(
        path: "lib/core/failures",
      ),
    ),
    CleanDirName.networkExceptions: Directory(
      replaceAsExpected(
        path: "lib/core/network_exceptions",
      ),
    ),
    CleanDirName.routes: Directory(
      replaceAsExpected(
        path: "lib/core/routes",
      ),
    ),
    CleanDirName.theme: Directory(
      replaceAsExpected(
        path: "lib/core/theme",
      ),
    ),
    CleanDirName.config: Directory(
      replaceAsExpected(
        path: "lib/core/dependancy_injection/config",
      ),
    ),
    CleanDirName.modules: Directory(
      replaceAsExpected(
        path: "lib/core/dependancy_injection/modules",
      ),
    ),
    CleanDirName.features: Directory(
      replaceAsExpected(
        path: "lib/features",
      ),
    ),
  };
  static List<FileModel> cleanArchFiles = [
    FileModel(
      cleanArchitectureStructure[CleanDirName.commonWidgets]!.path,
      "space.dart",
      spaceContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.commonWidgets]!.path,
      "responsive.dart",
      spaceContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.apiEndpoints]!.path,
      "api_endpoints.dart",
      apiEndpointContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.baseUsecase]!.path,
      "base_usecase.dart",
      usecaseContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.config]!.path,
      "configure_injection.dart",
      configInjectionContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.modules]!.path,
      "dio_module.dart",
      dioModuleContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.failures]!.path,
      "failures.dart",
      failuresContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.networkExceptions]!.path,
      "network_exceptions.dart",
      networkExceptionContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.routes]!.path,
      "app_routes.dart",
      routesContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.theme]!.path,
      "theme.dart",
      themeContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.theme]!.path,
      "colors.dart",
      colorsContent,
    ),
    FileModel(
      cleanArchitectureStructure[CleanDirName.features]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      'lib',
      "main.dart",
      mainContent,
    ),
    FileModel(
      'lib',
      "app.dart",
      appContent,
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

class CleanDirName {
  static String common = "common";
  static String commonWidgets = "widgets";
  static String features = "features";
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
