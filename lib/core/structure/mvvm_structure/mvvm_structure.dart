import 'dart:io';

import 'file_contents/mvvm_ai_docs_content.dart';
import '../common_file_contents/common_file_contents_export.dart';
import '../models/structure.dart';
import 'file_contents/mvvm_file_contents.dart';

class MvvmStructure extends Structure {
  @override
  String get architectureName => "MVVM";

  static final MvvmStructure _mvvmStructure = MvvmStructure._internal();

  factory MvvmStructure() {
    return _mvvmStructure;
  }

  MvvmStructure._internal();

  @override
  Map<String, Directory> get directoryStructure => {
        MvvmDirName.common: Directory(
          replaceAsExpected(path: "lib/common"),
        ),
        MvvmDirName.commonWidgets: Directory(
          replaceAsExpected(path: "lib/common/widgets"),
        ),
        MvvmDirName.core: Directory(
          replaceAsExpected(path: "lib/core"),
        ),
        MvvmDirName.services: Directory(
          replaceAsExpected(path: "lib/core/services"),
        ),
        MvvmDirName.apiEndpoints: Directory(
          replaceAsExpected(path: "lib/core/api_endpoints"),
        ),
        MvvmDirName.config: Directory(
          replaceAsExpected(path: "lib/core/config"),
        ),
        MvvmDirName.dependencyInjection: Directory(
          replaceAsExpected(path: "lib/core/dependency_injection"),
        ),
        MvvmDirName.diConfig: Directory(
          replaceAsExpected(path: "lib/core/dependency_injection/config"),
        ),
        MvvmDirName.modules: Directory(
          replaceAsExpected(path: "lib/core/dependency_injection/modules"),
        ),
        MvvmDirName.extensions: Directory(
          replaceAsExpected(path: "lib/core/extensions"),
        ),
        MvvmDirName.failures: Directory(
          replaceAsExpected(path: "lib/core/failures"),
        ),
        MvvmDirName.network: Directory(
          replaceAsExpected(path: "lib/core/network"),
        ),
        MvvmDirName.routes: Directory(
          replaceAsExpected(path: "lib/core/routes"),
        ),
        MvvmDirName.theme: Directory(
          replaceAsExpected(path: "lib/core/theme"),
        ),
        MvvmDirName.typography: Directory(
          replaceAsExpected(path: "lib/core/theme/typography"),
        ),
        MvvmDirName.features: Directory(
          replaceAsExpected(path: "lib/features"),
        ),
        MvvmDirName.aiDocs: Directory(
          replaceAsExpected(path: "ai_docs"),
        ),
      };

  @override
  Map<String, Directory> get featureStructure => {
        MvvmDirName.featureNm: Directory(
          replaceAsExpected(path: "lib/features/${MvvmDirName.featureNm}"),
        ),
        MvvmDirName.data: Directory(
          replaceAsExpected(path: "lib/features/${MvvmDirName.featureNm}/data"),
        ),
        MvvmDirName.dataSource: Directory(
          replaceAsExpected(
              path: "lib/features/${MvvmDirName.featureNm}/data/data_sources"),
        ),
        MvvmDirName.repositories: Directory(
          replaceAsExpected(
              path: "lib/features/${MvvmDirName.featureNm}/data/repositories"),
        ),
        MvvmDirName.models: Directory(
          replaceAsExpected(
              path: "lib/features/${MvvmDirName.featureNm}/models"),
        ),
        MvvmDirName.viewModel: Directory(
          replaceAsExpected(
              path: "lib/features/${MvvmDirName.featureNm}/view_model"),
        ),
        MvvmDirName.view: Directory(
          replaceAsExpected(path: "lib/features/${MvvmDirName.featureNm}/view"),
        ),
        MvvmDirName.screens: Directory(
          replaceAsExpected(
              path: "lib/features/${MvvmDirName.featureNm}/view/screens"),
        ),
        MvvmDirName.widgets: Directory(
          replaceAsExpected(
              path: "lib/features/${MvvmDirName.featureNm}/view/widgets"),
        ),
      };

  @override
  List<FileModel> get coreFiles => [
        FileModel(
          directoryStructure[MvvmDirName.commonWidgets]!.path,
          "loading.dart",
          loadingContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.commonWidgets]!.path,
          "responsive.dart",
          responsiveContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.aiDocs]!.path,
          "styling_guide.md",
          stylingGuideArgs,
        ),
        FileModel(
          directoryStructure[MvvmDirName.aiDocs]!.path,
          "api_flow_guide.md",
          mvvmApiFlowGuideArgs,
        ),
        FileModel(
          Directory.current.path,
          "README.md",
          readmeContentArgs,
        ),
        FileModel(
          directoryStructure[MvvmDirName.services]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvvmDirName.config]!.path,
          "flavor_config.dart",
          flavorConfigContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.apiEndpoints]!.path,
          "api_endpoints.dart",
          apiEndpointContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.diConfig]!.path,
          "configure_injection.dart",
          configInjectionContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.modules]!.path,
          "dio_module.dart",
          dioModuleContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.extensions]!.path,
          "app_navigation_ext.dart",
          navigationExtContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.extensions]!.path,
          "date_ext.dart",
          dateExtContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.extensions]!.path,
          "string_ext.dart",
          stringExtContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.extensions]!.path,
          "theme_ext.dart",
          themeExtContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.extensions]!.path,
          "number_ext.dart",
          numberExtContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.extensions]!.path,
          "extensions.dart",
          extensionsContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.failures]!.path,
          "failures.dart",
          failuresContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.network]!.path,
          "network_exceptions.dart",
          networkExceptionContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.network]!.path,
          "network_client.dart",
          networkClientContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.routes]!.path,
          "app_router.dart",
          appRouterContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.theme]!.path,
          "theme.dart",
          theme,
        ),
        FileModel(
          directoryStructure[MvvmDirName.theme]!.path,
          "app_colors.dart",
          colorsContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.theme]!.path,
          "app_theme.dart",
          themeContent,
        ),
        FileModel(
          directoryStructure[MvvmDirName.typography]!.path,
          "typography.dart",
          typography,
        ),
        FileModel(
          directoryStructure[MvvmDirName.typography]!.path,
          "app_font_weight.dart",
          appFontWeight,
        ),
        FileModel(
          directoryStructure[MvvmDirName.typography]!.path,
          "app_text_styles.dart",
          textStyles,
        ),
        FileModel(
          "lib",
          "main.dart",
          mainContent,
        ),
        FileModel(
          "lib",
          "app_runner.dart",
          appRunnerContent,
        ),
        FileModel(
          "lib",
          "app.dart",
          appContent,
        ),
        // Number Trivia Feature (Sample)
        FileModel(
          featureStructure[MvvmDirName.screens]!.path,
          "number_trivia_screen.dart",
          numberTriviaScreenContent,
        ),
        FileModel(
          featureStructure[MvvmDirName.dataSource]!.path,
          "number_trivia_remote_data_source.dart",
          numberTriviaRemoteDataSourceContent,
        ),
        FileModel(
          featureStructure[MvvmDirName.repositories]!.path,
          "number_trivia_repository.dart",
          numberTriviaRepositoryContent,
        ),
        FileModel(
          featureStructure[MvvmDirName.models]!.path,
          "trivia_model.dart",
          triviaModelContent,
        ),
        FileModel(
          featureStructure[MvvmDirName.viewModel]!.path,
          "number_trivia_view_model.dart",
          numberTriviaViewModelContent,
        ),
        FileModel(
          featureStructure[MvvmDirName.widgets]!.path,
          ".gitkeep",
          "",
        ),
      ];

  @override
  List<FileModel> get featureFiles =>
      []; // TODO: Implement feature generation if needed later
}

class MvvmDirName {
  static String common = "common";
  static String commonWidgets = "widgets";
  static String services = "services";
  static String features = "features";
  static String core = "core";
  static String apiEndpoints = "apiEndpoints";
  static String config = "config";
  static String dependencyInjection = "dependency_injection";
  static String diConfig = "config";
  static String modules = "modules";
  static String extensions = "extensions";
  static String failures = "failures";
  static String network = "network";
  static String routes = "routes";
  static String theme = "theme";
  static String typography = "typography";
  static String aiDocs = "ai_docs";

  // Feature specific
  static String featureNm = "number_trivia"; // Default for init
  static String data = "data";
  static String dataSource = "data_sources";
  static String repositories = "repositories";
  static String models = "models";
  static String viewModel = "view_model";
  static String view = "view";
  static String screens = "screens";
  static String widgets = "widgets";
}
