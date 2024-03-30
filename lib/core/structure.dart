import 'dart:io';

import 'package:easy_init_cli/commands/create_feature/create_feature.dart';
import 'package:easy_init_cli/core/file_contents.dart';
import 'package:recase/recase.dart';

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
  static Map<String, Directory> cleanArchitectureFeatureStructure = {
    CleanDirName.featureNm: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}",
      ),
    ),
    CleanDirName.data: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/data",
      ),
    ),
    CleanDirName.dataSource: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/data/data_sources",
      ),
    ),
    CleanDirName.models: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/data/models",
      ),
    ),
    CleanDirName.repoImpl: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/data/repositories_impl",
      ),
    ),
    CleanDirName.domain: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/domain",
      ),
    ),
    CleanDirName.usecase: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/domain/usecases",
      ),
    ),
    CleanDirName.entities: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/domain/entities",
      ),
    ),
    CleanDirName.repositories: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/domain/repositories",
      ),
    ),
    CleanDirName.presentation: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/presentation",
      ),
    ),
    CleanDirName.blocs: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/presentation/blocs",
      ),
    ),
    CleanDirName.screens: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/presentation/screens",
      ),
    ),
    CleanDirName.widgets: Directory(
      replaceAsExpected(
        path: "lib/features/${CleanDirName.featureNm}/presentation/widgets",
      ),
    ),
    CleanDirName.homeBloc: Directory(
      replaceAsExpected(
        path:
            "lib/features/${CleanDirName.featureNm}/presentation/blocs/${CleanDirName.homeBloc}",
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
      responsiveContent,
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
    //
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.screens]!.path,
      "home_screen.dart",
      homeScreenContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.dataSource]!.path,
      "${CleanDirName.featureNm}_datasource.dart",
      dataSourceContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.repoImpl]!.path,
      "${CleanDirName.featureNm}_repo_impl.dart",
      repoImplContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.repositories]!.path,
      "${CleanDirName.featureNm}_repository.dart",
      repoContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.models]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.entities]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.usecase]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.widgets]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.blocs]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.homeBloc]!.path,
      "home_bloc.dart",
      homeBlocContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.homeBloc]!.path,
      "home_state.dart",
      homeStateContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.homeBloc]!.path,
      "home_event.dart",
      homeEventContent,
    ),
  ];

  static List<FileModel> cleanArchFeatureFiles = [
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.screens]!.path,
      "${CleanDirName.featureNm}_screen.dart",
      screenContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.dataSource]!.path,
      "${CleanDirName.featureNm}_datasource.dart",
      dataSourceContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.repoImpl]!.path,
      "${CleanDirName.featureNm}_repo_impl.dart",
      repoImplContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.repositories]!.path,
      "${CleanDirName.featureNm}_repository.dart",
      repoContent,
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.models]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.entities]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.usecase]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.widgets]!.path,
      ".gitkeep",
      "",
    ),
    FileModel(
      cleanArchitectureFeatureStructure[CleanDirName.blocs]!.path,
      ".gitkeep",
      "",
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
  //configurations
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
  //features
  static String featureNm = CreateFeature.featureName.snakeCase;
  static String data = "data";
  static String dataSource = "data_sources";
  static String models = "models";
  static String repoImpl = "repositories_impl";
  static String domain = "domain";
  static String usecase = "usecases";
  static String entities = "entities";
  static String repositories = "repositories";
  static String presentation = "presentation";
  static String blocs = "blocs";
  static String screens = "screens";
  static String widgets = "widgets";
  static String homeBloc = "home_bloc";
}
