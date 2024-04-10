import 'dart:io';

import 'package:easy_init_cli/core/structure/structure.dart';
import 'file_contents/mvc_file_contents.dart';

class MvcGetXStructure extends Structure {
  @override
  String get architectureName => "MVC";

  @override
  Map<String, Directory> get directoryStructure => {
        MvcDirNames.application: Directory(
          replaceAsExpected(
            path: 'lib/application',
          ),
        ),
        MvcDirNames.model: Directory(
          replaceAsExpected(
            path: 'lib/application/models',
          ),
        ),
        MvcDirNames.views: Directory(
          replaceAsExpected(
            path: 'lib/application/views',
          ),
        ),
        MvcDirNames.controllers: Directory(
          replaceAsExpected(
            path: 'lib/application/controllers',
          ),
        ),
        MvcDirNames.bindings: Directory(
          replaceAsExpected(
            path: 'lib/application/bindings',
          ),
        ),
        MvcDirNames.utils: Directory(
          replaceAsExpected(
            path: 'lib/application/utils',
          ),
        ),
        MvcDirNames.services: Directory(
          replaceAsExpected(
            path: 'lib/application/services',
          ),
        ),
        MvcDirNames.theme: Directory(
          replaceAsExpected(
            path: 'lib/application/utils/theme',
          ),
        ),
        MvcDirNames.api: Directory(
          replaceAsExpected(
            path: 'lib/application/utils/api_endpoints',
          ),
        ),
        MvcDirNames.network: Directory(
          replaceAsExpected(
            path: 'lib/application/utils/network_exceptions',
          ),
        ),
        MvcDirNames.routes: Directory(
          replaceAsExpected(
            path: 'lib/application/utils/routes',
          ),
        ),
        MvcDirNames.screens: Directory(
          replaceAsExpected(
            path: 'lib/application/views/screens',
          ),
        ),
        MvcDirNames.widgets: Directory(
          replaceAsExpected(
            path: 'lib/application/views/widgets',
          ),
        ),
      };
  @override
  List<FileModel> get coreFiles => [
        FileModel(
          Directory.current.path,
          "easy_init_mvc_grl",
          initWarning,
        ),
        FileModel(
          'lib',
          "main.dart",
          mvcMainContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.application]!.path,
          "app.dart",
          mvcAppContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.controllers]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvcDirNames.model]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvcDirNames.screens]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvcDirNames.widgets]!.path,
          "space.dart",
          spaceContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.widgets]!.path,
          "responsive.dart",
          responsiveContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.theme]!.path,
          "colors.dart",
          colorsContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.theme]!.path,
          "theme.dart",
          themeContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.api]!.path,
          "api_endpoints.dart",
          apiEndpointContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.network]!.path,
          "network_exceptions.dart",
          networkExceptionContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.routes]!.path,
          ".gitkeep",
          mvcRouteContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.bindings]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvcDirNames.services]!.path,
          ".gitkeep",
          '',
        ),
      ];
}

class MvcDirNames {
  static String application = "application";
  static String model = "models";
  static String views = "views";
  static String controllers = "controllers";
  static String bindings = "bindings";
  static String services = "services";
  static String utils = "utils";
  static String network = "network";
  static String theme = "theme";
  static String api = "api_endpoints";
  static String routes = "routes";
  static String screens = "screens";
  static String widgets = "widgets";
//
}
