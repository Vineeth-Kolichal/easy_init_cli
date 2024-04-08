import 'dart:io';

import 'package:easy_init_cli/core/structure/structure.dart';

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
        MvcDirNames.core: Directory(
          replaceAsExpected(
            path: 'lib/core',
          ),
        ),
        MvcDirNames.model: Directory(
          replaceAsExpected(
            path: 'lib/application/models',
          ),
        ),
        MvcDirNames.model: Directory(
          replaceAsExpected(
            path: 'lib/application/models',
          ),
        ),
        MvcDirNames.controllers: Directory(
          replaceAsExpected(
            path: 'lib/application/controllers',
          ),
        ),
      };
}

class MvcDirNames {
  static String core = "core";
  static String application = "application";
  static String model = "models";
  static String views = "views";
  static String controllers = "controllers";
}
