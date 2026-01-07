import 'dart:convert';
import 'dart:io';

import 'package:easy_init_cli/core/config/config.dart';

class ConfigManager {
  static final File _configFile = File('easy_init.json');

  static Future<void> createConfig(Config config) async {
    await _configFile.writeAsString(jsonEncode(config.toJson()));
  }

  static Config? getConfig() {
    if (_configFile.existsSync()) {
      try {
        final data = jsonDecode(_configFile.readAsStringSync());
        return Config.fromJson(data);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static bool get isInitialized => _configFile.existsSync();
}
