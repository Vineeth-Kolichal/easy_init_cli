import 'dart:io';

import 'package:recase/recase.dart';

import '../../../commands/create_feature/create_feature.dart';
import 'file_contents/file_contents.dart';
import '../structure.dart';

class TddCleanStructure extends Structure {
  @override
  String get architectureName => "TDD+Clean";
  bool? withRestAPI;
  //making singleton
  static final TddCleanStructure _tddCleanStructure =
      TddCleanStructure._internal();
  factory TddCleanStructure() {
    return _tddCleanStructure;
  }
  // common configuration file structure
  @override
  Map<String, Directory> get directoryStructure => {
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
        CleanDirName.network: Directory(
          replaceAsExpected(
            path: "lib/core/network",
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
// Clean architecture feature directory structure
  @override
  Map<String, Directory> get featureStructure => {
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
            path:
                "lib/features/${CleanDirName.featureNm}/data/repositories_impl",
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
        if (CleanDirName.featureNm == "number_trivia")
          CleanDirName.numberTriviaBloc: Directory(
            replaceAsExpected(
              path:
                  "lib/features/${CleanDirName.featureNm}/presentation/blocs/${CleanDirName.numberTriviaBloc}",
            ),
          ),
      };

  //files
  @override
  List<FileModel> get coreFiles => [
        FileModel(
          Directory.current.path,
          "easy_init_tdd_clean_brf",
          initWarning,
        ),
        FileModel(
          directoryStructure[CleanDirName.commonWidgets]!.path,
          "space.dart",
          spaceContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.commonWidgets]!.path,
          "loading.dart",
          loadingContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.commonWidgets]!.path,
          "responsive.dart",
          responsiveContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.apiEndpoints]!.path,
          "api_endpoints.dart",
          apiEndpointContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.baseUsecase]!.path,
          "base_usecase.dart",
          usecaseContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.config]!.path,
          "configure_injection.dart",
          configInjectionContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.modules]!.path,
          "dio_module.dart",
          dioModuleContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.failures]!.path,
          "failures.dart",
          failuresContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.network]!.path,
          "network_exceptions.dart",
          networkExceptionContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.network]!.path,
          "network_client.dart",
          networkClientContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.routes]!.path,
          "app_routes.dart",
          routeContentRest,
        ),
        FileModel(
          directoryStructure[CleanDirName.theme]!.path,
          "theme.dart",
          themeContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.theme]!.path,
          "colors.dart",
          colorsContent,
        ),
        FileModel(
          directoryStructure[CleanDirName.features]!.path,
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
          appContentRest,
        ),
        //
        FileModel(
          featureStructure[CleanDirName.screens]!.path,
          "${CleanDirName.featureNm}_screen.dart",
          triviaScreen,
        ),
        FileModel(
          featureStructure[CleanDirName.dataSource]!.path,
          "${CleanDirName.featureNm}_datasource.dart",
          triviaDataSourceContent,
        ),
        FileModel(
          featureStructure[CleanDirName.repoImpl]!.path,
          "${CleanDirName.featureNm}_repo_impl.dart",
          triviaRepoImplContent,
        ),
        FileModel(
          featureStructure[CleanDirName.repositories]!.path,
          "${CleanDirName.featureNm}_repository.dart",
          triviaRepoContent,
        ),
        FileModel(
          featureStructure[CleanDirName.models]!.path,
          "trivia_model.dart",
          triviaModelContent,
        ),
        FileModel(
          featureStructure[CleanDirName.entities]!.path,
          "trivia_entity.dart",
          triviaEntityContent,
        ),
        FileModel(
          featureStructure[CleanDirName.usecase]!.path,
          "get_number_trivia_usecase.dart",
          triviaUsecase,
        ),
        FileModel(
          featureStructure[CleanDirName.widgets]!.path,
          ".gitkeep",
          "",
        ),
        FileModel(
          featureStructure[CleanDirName.blocs]!.path,
          ".gitkeep",
          "",
        ),
        FileModel(
          featureStructure[CleanDirName.numberTriviaBloc]!.path,
          "number_trivia_bloc.dart",
          triviaBloc,
        ),
        FileModel(
          featureStructure[CleanDirName.numberTriviaBloc]!.path,
          "number_trivia_state.dart",
          triviaState,
        ),
        FileModel(
          featureStructure[CleanDirName.numberTriviaBloc]!.path,
          "number_trivia_event.dart",
          triviaEvent,
        ),
      ];

  //feature files
  @override
  List<FileModel> get featureFiles => [
        if (CleanDirName.featureNm != "auth" &&
            CleanDirName.featureNm != "authentication")
          FileModel(
            featureStructure[CleanDirName.screens]!.path,
            "${CleanDirName.featureNm}_screen.dart",
            screenContent,
          ),
        FileModel(
          featureStructure[CleanDirName.dataSource]!.path,
          "${CleanDirName.featureNm}_datasource.dart",
          dataSourceContent,
        ),
        FileModel(
          featureStructure[CleanDirName.repoImpl]!.path,
          "${CleanDirName.featureNm}_repo_impl.dart",
          repoImplContent,
        ),
        FileModel(
          featureStructure[CleanDirName.repositories]!.path,
          "${CleanDirName.featureNm}_repository.dart",
          repoContent,
        ),
        FileModel(
          featureStructure[CleanDirName.models]!.path,
          ".gitkeep",
          "",
        ),
        FileModel(
          featureStructure[CleanDirName.entities]!.path,
          ".gitkeep",
          "",
        ),
        FileModel(
          featureStructure[CleanDirName.usecase]!.path,
          ".gitkeep",
          "",
        ),
        FileModel(
          featureStructure[CleanDirName.widgets]!.path,
          ".gitkeep",
          "",
        ),
        FileModel(
          featureStructure[CleanDirName.blocs]!.path,
          ".gitkeep",
          "",
        ),
        if (CleanDirName.featureNm == "auth" ||
            CleanDirName.featureNm == "authentication")
          FileModel(
            featureStructure[CleanDirName.screens]!.path,
            "login_screen.dart",
            loginScreenContent,
          ),
        if (CleanDirName.featureNm == "auth" ||
            CleanDirName.featureNm == "authentication")
          FileModel(
            featureStructure[CleanDirName.screens]!.path,
            "signup_screen.dart",
            signupScreenContent,
          ),
        if (CleanDirName.featureNm == "auth" ||
            CleanDirName.featureNm == "authentication")
          FileModel(
            featureStructure[CleanDirName.screens]!.path,
            "forgot_password_screen.dart",
            forgotPasswordScreenContent,
          ),
        if (CleanDirName.featureNm == "auth" ||
            CleanDirName.featureNm == "authentication")
          FileModel(
            featureStructure[CleanDirName.screens]!.path,
            "otp_screen.dart",
            otpScreenContent,
          ),
      ];
  TddCleanStructure._internal();
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
  static String network = "network";
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
  static String numberTriviaBloc = "number_trivia_bloc";
}
