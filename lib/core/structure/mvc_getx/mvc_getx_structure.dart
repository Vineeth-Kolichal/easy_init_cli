import 'dart:io';

import 'package:easy_init_cli/core/structure/mvc_getx/file_contents/mvc_trivia_content.dart';
import 'package:easy_init_cli/core/structure/structure.dart';
import 'package:recase/recase.dart';
import '../../../commands/create_feature/create_feature.dart';
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
        MvcDirNames.common: Directory(
          replaceAsExpected(
            path: 'lib/application/common',
          ),
        ),
        MvcDirNames.commonW: Directory(
          replaceAsExpected(
            path: 'lib/application/common/widgets',
          ),
        ),
        MvcDirNames.commonC: Directory(
          replaceAsExpected(
            path: 'lib/application/common/controllers',
          ),
        ),
        MvcDirNames.commonM: Directory(
          replaceAsExpected(
            path: 'lib/application/common/models',
          ),
        ),
      };
  @override
  Map<String, Directory> get featureStructure => {
        MvcDirNames.views: Directory(
          replaceAsExpected(
            path: 'lib/application/views/${MvcDirNames.featureNm}',
          ),
        ),
        MvcDirNames.screens: Directory(
          replaceAsExpected(
            path: 'lib/application/views/${MvcDirNames.featureNm}/screens',
          ),
        ),
        MvcDirNames.widgets: Directory(
          replaceAsExpected(
            path: 'lib/application/views/${MvcDirNames.featureNm}/widgets',
          ),
        ),
        MvcDirNames.controllers: Directory(
          replaceAsExpected(
            path: 'lib/application/controllers/${MvcDirNames.featureNm}',
          ),
        ),
        MvcDirNames.model: Directory(
          replaceAsExpected(
            path: 'lib/application/models/${MvcDirNames.featureNm}',
          ),
        ),
        MvcDirNames.services: Directory(
          replaceAsExpected(
            path: 'lib/application/services/${MvcDirNames.featureNm}',
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
          directoryStructure[MvcDirNames.commonW]!.path,
          "space.dart",
          spaceContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.commonW]!.path,
          "loading.dart",
          loadingContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.commonW]!.path,
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
          "routes.dart",
          mvcRouteContent,
        ),
        FileModel(
          directoryStructure[MvcDirNames.services]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvcDirNames.commonC]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvcDirNames.commonW]!.path,
          ".gitkeep",
          '',
        ),
        FileModel(
          directoryStructure[MvcDirNames.commonM]!.path,
          ".gitkeep",
          '',
        ),

        //Trivia feature files
        FileModel(
          featureStructure[MvcDirNames.controllers]!.path,
          "${MvcDirNames.featureNm}_controller.dart",
          triviaControllerCnt,
        ),
        FileModel(
          featureStructure[MvcDirNames.model]!.path,
          "${MvcDirNames.featureNm}_model.dart",
          triviaModelCnt,
        ),
        FileModel(
          featureStructure[MvcDirNames.services]!.path,
          "${MvcDirNames.featureNm}_service.dart",
          triviaServicesCnt,
        ),
        FileModel(
          featureStructure[MvcDirNames.screens]!.path,
          "${MvcDirNames.featureNm}_screen.dart",
          triviaScreenCnt,
        ),
        FileModel(
          featureStructure[MvcDirNames.widgets]!.path,
          ".gitkeep",
          triviaScreenCnt,
        ),
      ];
  @override
  List<FileModel> get featureFiles => [
        FileModel(
          featureStructure[MvcDirNames.controllers]!.path,
          "${MvcDirNames.featureNm}_controller.dart",
          mvcCntrlContent,
        ),
        FileModel(
          featureStructure[MvcDirNames.model]!.path,
          ".gitkeep",
          "",
        ),
        FileModel(
          featureStructure[MvcDirNames.services]!.path,
          "${MvcDirNames.featureNm}_service.dart",
          mvcServiceContent,
        ),
        FileModel(
          featureStructure[MvcDirNames.screens]!.path,
          "${MvcDirNames.featureNm}_screen.dart",
          mvcScreenContent,
        ),
        FileModel(
          featureStructure[MvcDirNames.widgets]!.path,
          ".gitkeep",
          "",
        ),
        if (MvcDirNames.featureNm == "auth" ||
            MvcDirNames.featureNm == "authentication")
          FileModel(
            featureStructure[MvcDirNames.screens]!.path,
            "login_screen.dart",
            loginScreenContent,
          ),
        if (MvcDirNames.featureNm == "auth" ||
            MvcDirNames.featureNm == "authentication")
          FileModel(
            featureStructure[MvcDirNames.screens]!.path,
            "signup_screen.dart",
            signupScreenContent,
          ),
        if (MvcDirNames.featureNm == "auth" ||
            MvcDirNames.featureNm == "authentication")
          FileModel(
            featureStructure[MvcDirNames.screens]!.path,
            "forgot_password_screen.dart",
            forgotPasswordScreenContent,
          ),
        if (MvcDirNames.featureNm == "auth" ||
            MvcDirNames.featureNm == "authentication")
          FileModel(
            featureStructure[MvcDirNames.screens]!.path,
            "otp_screen.dart",
            otpScreenContent,
          ),
      ];
}

class MvcDirNames {
  static String application = "application";
  static String model = "models";
  static String views = "views";
  static String controllers = "controllers";
  static String services = "services";
  static String utils = "utils";
  static String network = "network";
  static String theme = "theme";
  static String api = "api_endpoints";
  static String routes = "routes";
  static String screens = "screens";
  static String widgets = "widgets";
  static String common = "common";
  static String commonW = "commonW";
  static String commonM = "commonM";
  static String commonC = "commonC";
  static String featureNm = CreateFeature.featureName.snakeCase;
//
}
