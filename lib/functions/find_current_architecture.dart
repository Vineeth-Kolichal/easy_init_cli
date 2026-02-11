import 'package:easy_init_cli/functions/config_manager.dart';
import 'dart:io';

String? findCurrentArchitecture() {
  ///suffix details
  ///-------------
  ///b-bloc
  ///g-getx
  ///n- no rest api
  ///rv- riverpod
  ///p-provider
  ///r-rest api
  ///l-layer wise
  ///f-feature wise
  ///---------------
  ///suffix order -> state management + data source type(rest api or not)+ architecture type
  ///example:  'brf' means bloc+rest api+feature wise architecture

  // Use ConfigManager to get the current architecture
  if (ConfigManager.isInitialized) {
    final config = ConfigManager.getConfig();
    if (config != null) {
      if (config.architecture == 'tdd_clean' && config.pattern == 'brf') {
        return "tdd-brf";
      } else if (config.architecture == 'mvc' && config.pattern == 'grl') {
        return "mvc-grl";
      } else if (config.architecture == 'mvvm' && config.pattern == 'feature') {
        return "mvvm-feature";
      }
    }
  }

  // Fallback for older projects that might still use marker files
  if (File('easy_init_tdd_clean_brf').existsSync()) {
    return "tdd-brf";
  } else if (File('easy_init_mvc_grl').existsSync()) {
    return "mvc-grl";
  } else {
    return null;
  }
}
