import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_init_cli/core/version.dart';
import 'package:dcli/dcli.dart';

class UpdateChecker {
  static const String _packageName = 'easy_init_cli';
  static const String _pubApiUrl = 'https://pub.dev/api/packages/$_packageName';

  static Future<void> checkForUpdate() async {
    try {
      final latestVersion = await _getLatestVersion();
      if (latestVersion != null && _isUpdateAvailable(latestVersion)) {
        _showUpdateMessage(latestVersion);
      }
    } catch (e) {
      // Silently fail if update check fails to avoid interrupting workflow
    }
  }

  static Future<String?> _getLatestVersion() async {
    try {
      final response = await http
          .get(Uri.parse(_pubApiUrl))
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['latest']['version'] as String?;
      }
    } catch (_) {
      // Network error or timeout
    }
    return null;
  }

  static bool _isUpdateAvailable(String latestVersion) {
    return _compareVersions(latestVersion, packageVersion) > 0;
  }

  static void _showUpdateMessage(String latestVersion) {
    print(yellow(
        '╔════════════════════════════════════════════════════════════╗'));
    print(yellow(
        '║                                                            ║'));
    print(yellow(
        '║   Update available! ${packageVersion.padRight(19)} -> ${latestVersion.padRight(19)} ║'));
    print(yellow('║   Run ${"easy update".padRight(53)}║'));
    print(yellow(
        '║                                                            ║'));
    print(yellow(
        '╚════════════════════════════════════════════════════════════╝'));
    print('');
  }

  static int _compareVersions(String v1, String v2) {
    var v1Parts = v1.split('.').map(int.parse).toList();
    var v2Parts = v2.split('.').map(int.parse).toList();

    for (var i = 0; i < 3; i++) {
      if (v1Parts[i] > v2Parts[i]) return 1;
      if (v1Parts[i] < v2Parts[i]) return -1;
    }
    return 0;
  }
}
