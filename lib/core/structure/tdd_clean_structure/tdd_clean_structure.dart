import 'dart:io';

import 'package:recase/recase.dart';

import '../../../commands/create_feature/create_feature.dart';
import 'file_contents/file_contents.dart';
import '../models/structure.dart';

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
  Map<String, Directory> get directoryStructure => _directoryStructure;

  late final Map<String, Directory> _directoryStructure = {
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
    CleanDirName.uiUtils: Directory(
      replaceAsExpected(
        path: "lib/common/ui_utils",
      ),
    ),
    CleanDirName.core: Directory(
      replaceAsExpected(
        path: "lib/core",
      ),
    ),
    CleanDirName.services: Directory(
      replaceAsExpected(
        path: "lib/core/services",
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
    CleanDirName.mainConfig: Directory(
      replaceAsExpected(
        path: "lib/core/config",
      ),
    ),
    CleanDirName.dependencyInjection: Directory(
      replaceAsExpected(
        path: "lib/core/dependency_injection",
      ),
    ),
    CleanDirName.extensions: Directory(
      replaceAsExpected(
        path: "lib/core/extensions",
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
    CleanDirName.typography: Directory(
      replaceAsExpected(
        path: "lib/core/theme/typography",
      ),
    ),
    CleanDirName.config: Directory(
      replaceAsExpected(
        path: "lib/core/dependency_injection/config",
      ),
    ),
    CleanDirName.modules: Directory(
      replaceAsExpected(
        path: "lib/core/dependency_injection/modules",
      ),
    ),
    CleanDirName.features: Directory(
      replaceAsExpected(
        path: "lib/features",
      ),
    ),
    CleanDirName.aiDocs: Directory(
      replaceAsExpected(
        path: "ai_docs",
      ),
    ),
  };

  Directory _getDir(String key) {
    if (!directoryStructure.containsKey(key)) {
      throw Exception("Directory structure key '$key' is missing");
    }
    return directoryStructure[key]!;
  }

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
        if (CleanDirName.featureNm == "sample")
          CleanDirName.sampleBloc: Directory(
            replaceAsExpected(
              path:
                  "lib/features/${CleanDirName.featureNm}/presentation/blocs/${CleanDirName.sampleBloc}",
            ),
          ),
      };

  //files
  @override
  List<FileModel> get coreFiles => [
        FileModel(
          _getDir(CleanDirName.commonWidgets).path,
          "loading.dart",
          cleanLoadingContent,
        ),
        FileModel(
          _getDir(CleanDirName.commonWidgets).path,
          "custom_text_field.dart",
          cleanCustomTextFieldContent,
        ),
        FileModel(
          _getDir(CleanDirName.commonWidgets).path,
          "generic_button.dart",
          cleanGenericButtonContent,
        ),
        FileModel(
          _getDir(CleanDirName.uiUtils).path,
          "snack_bar.dart",
          cleanSnackBarContent,
        ),
        FileModel(
          _getDir(CleanDirName.aiDocs).path,
          "styling_guide.md",
          stylingGuideArgs,
        ),
        FileModel(
          _getDir(CleanDirName.aiDocs).path,
          "api_flow_guide.md",
          apiFlowGuideArgs,
        ),
        FileModel(
          Directory.current.path,
          "README.md",
          readmeContentArgs,
        ),
        FileModel(
          _getDir(CleanDirName.commonWidgets).path,
          "responsive.dart",
          cleanResponsiveContent,
        ),
        FileModel(
          _getDir(CleanDirName.services).path,
          ".gitkeep",
          '',
        ),
        FileModel(
          _getDir(CleanDirName.mainConfig).path,
          "flavor_config.dart",
          cleanFlavorConfigContent,
        ),
        FileModel(
          _getDir(CleanDirName.apiEndpoints).path,
          "api_endpoints.dart",
          cleanApiEndpointContent,
        ),
        FileModel(
          _getDir(CleanDirName.baseUsecase).path,
          "base_usecase.dart",
          usecaseContent,
        ),
        FileModel(
          _getDir(CleanDirName.config).path,
          "configure_injection.dart",
          configInjectionContent,
        ),
        FileModel(
          _getDir(CleanDirName.modules).path,
          "dio_module.dart",
          dioModuleContent,
        ),
        FileModel(
          _getDir(CleanDirName.extensions).path,
          "app_navigation_ext.dart",
          navigationExtContent,
        ),
        FileModel(
          _getDir(CleanDirName.extensions).path,
          "date_ext.dart",
          dateExtContent,
        ),
        FileModel(
          _getDir(CleanDirName.extensions).path,
          "string_ext.dart",
          stringExtContent,
        ),
        FileModel(
          _getDir(CleanDirName.extensions).path,
          "theme_ext.dart",
          themeExtContent,
        ),
        FileModel(
          _getDir(CleanDirName.extensions).path,
          "number_ext.dart",
          numberExtContent,
        ),
        FileModel(
          _getDir(CleanDirName.extensions).path,
          "extensions.dart",
          extensionsContent,
        ),
        FileModel(
          _getDir(CleanDirName.failures).path,
          "failures.dart",
          failuresContent,
        ),
        FileModel(
          _getDir(CleanDirName.network).path,
          "network_exceptions.dart",
          networkExceptionContent,
        ),
        FileModel(
          _getDir(CleanDirName.network).path,
          "network_client.dart",
          networkClientContent,
        ),
        FileModel(
          _getDir(CleanDirName.routes).path,
          "app_router.dart",
          cleanAppRouterContent,
        ),
        FileModel(
          _getDir(CleanDirName.theme).path,
          "theme.dart",
          theme,
        ),
        FileModel(
          _getDir(CleanDirName.theme).path,
          "theme_service.dart",
          cleanThemeServiceContent,
        ),
        FileModel(
          _getDir(CleanDirName.theme).path,
          "app_colors.dart",
          cleanColorsContent,
        ),
        FileModel(
          _getDir(CleanDirName.theme).path,
          "app_theme.dart",
          cleanThemeContent,
        ),
        FileModel(
          _getDir(CleanDirName.typography).path,
          "typography.dart",
          typography,
        ),
        FileModel(
          _getDir(CleanDirName.typography).path,
          "app_font_weight.dart",
          appFontWeight,
        ),
        FileModel(
          _getDir(CleanDirName.typography).path,
          "app_text_styles.dart",
          textStyles,
        ),
        FileModel(
          _getDir(CleanDirName.features).path,
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
          "app_runner.dart",
          appRunnerContent,
        ),
        FileModel(
          'lib',
          "app.dart",
          cleanAppContent,
        ),
        // Sample Feature Files
        FileModel(
          replaceAsExpected(path: "lib/features/sample/view/screens"),
          "sample_screen.dart",
          cleanSampleScreenContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/presentation/screens"),
          "sample_screen.dart",
          cleanSampleScreenContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/presentation/widgets"),
          "header_section.dart",
          cleanHeaderSectionContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/data/data_sources"),
          "sample_datasource.dart",
          cleanSampleDataSourceContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/data/repositories_impl"),
          "sample_repository_impl.dart",
          cleanSampleRepositoryImplContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/domain/repositories"),
          "sample_repository.dart",
          cleanSampleRepositoryContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/data/models"),
          "user_model.dart",
          cleanUserModelContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/data/models"),
          "cli_details_model.dart",
          cleanCliDetailsModelContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/domain/entities"),
          "user_entity.dart",
          cleanUserEntityContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/domain/entities"),
          "cli_details_entity.dart",
          cleanCliDetailsEntityContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/domain/usecases"),
          "get_cli_details_usecase.dart",
          cleanGetCliDetailsUseCaseContent,
        ),
        FileModel(
          replaceAsExpected(path: "lib/features/sample/domain/usecases"),
          "get_user_usecase.dart",
          cleanGetUserUseCaseContent,
        ),
        // Blocks
        FileModel(
          replaceAsExpected(
              path: "lib/features/sample/presentation/blocs/sample_bloc"),
          "sample_bloc.dart",
          cleanSampleBlocContent,
        ),
        FileModel(
          replaceAsExpected(
              path: "lib/features/sample/presentation/blocs/sample_bloc"),
          "sample_event.dart",
          cleanSampleEventContent,
        ),
        FileModel(
          replaceAsExpected(
              path: "lib/features/sample/presentation/blocs/sample_bloc"),
          "sample_state.dart",
          cleanSampleStateContent,
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
  static String uiUtils = "ui_utils";
  static String services = "services";
  static String features = "features";
  static String core = "core";
  static String apiEndpoints = "apiEndpoints";
  static String baseUsecase = "base_usecase";
  static String dependencyInjection = "dependency_injection";
  static String extensions = "extensions";
  static String failures = "failures";
  static String network = "network";
  static String routes = "routes";
  static String theme = "theme";
  static String typography = "typography";
  static String config = "config";
  static String modules = "modules";
  static String mainConfig = "main_config";
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
  static String sampleBloc = "sample_bloc";
  static String aiDocs = "ai_docs";
}
