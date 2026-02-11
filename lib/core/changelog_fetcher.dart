import 'package:http/http.dart' as http;
import 'package:dcli/dcli.dart';

class ChangelogFetcher {
  static const String _packageName = 'easy_init_cli';
  static const String _changelogUrl =
      'https://pub.dev/packages/$_packageName/changelog';

  static Future<void> displayChangelog(String version) async {
    try {
      final response = await http
          .get(Uri.parse(_changelogUrl))
          .timeout(Duration(seconds: 3));

      if (response.statusCode == 200) {
        final html = response.body;
        final changelog = _extractChangelogForVersion(html, version);

        if (changelog != null && changelog.isNotEmpty) {
          print('');
          print(green('What\'s new in $version:'));
          print(changelog);
          print('');
        }
      }
    } catch (e) {
      // Silently fail if we can't fetch the changelog
    }
  }

  static String? _extractChangelogForVersion(String html, String version) {
    // Escape dots in version to use in regex
    final escapedVersion = version.replaceAll('.', r'\.');

    // Find the header for this version.
    // We look for a pattern like <h2 ...>1.2.9 ...</h2>
    // The content is what follows until the next <h2> or end of logical block.

    final headerPattern = RegExp(r'<h2[^>]*>.*?' + escapedVersion + r'.*?</h2>',
        caseSensitive: false, multiLine: true);

    final match = headerPattern.firstMatch(html);
    if (match == null) return null;

    final startIndex = match.end;

    // We search for the next <h2 which marks the next version block
    final nextHeaderPattern =
        RegExp(r'<h2[^>]*>', caseSensitive: false, multiLine: true);
    final nextMatch = nextHeaderPattern.firstMatch(html.substring(startIndex));

    // If no next header is found, we might want to stop at some other tag or take the rest
    // A safe bet for pub.dev is the start of the next section or end of main content
    // But taking until the next <h2> is usually correct for the top version

    final endIndex =
        nextMatch != null ? startIndex + nextMatch.start : html.length;

    // Extract the substring
    var contentHtml = html.substring(startIndex, endIndex);

    // Pub.dev might put the content in a <div class="changelog-content"> or just raw after h2
    // Let's just parse what we got
    return _parseHtmlToText(contentHtml);
  }

  static String _parseHtmlToText(String html) {
    var text = html;

    // Remove script and style tags
    text = text.replaceAll(
        RegExp(r'<script[^>]*>([\s\S]*?)</script>', caseSensitive: false), '');
    text = text.replaceAll(
        RegExp(r'<style[^>]*>([\s\S]*?)</style>', caseSensitive: false), '');

    // Replace <br> with newlines
    text = text.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');

    // Replace <li> with a bullet point
    text = text.replaceAll(RegExp(r'<li[^>]*>', caseSensitive: false), '\n • ');

    // Replace <p> with newlines
    text = text.replaceAll(RegExp(r'<p[^>]*>', caseSensitive: false), '\n');
    text = text.replaceAll(RegExp(r'</p>', caseSensitive: false), '\n');

    // Strip remaining tags
    text = text.replaceAll(RegExp(r'<[^>]*>', caseSensitive: false), '');

    // Decode HTML entities (basic ones)
    text = text
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");

    // Clean up excessive whitespace
    final lines = text.split('\n');
    final cleanedLines = lines
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    return cleanedLines.join('\n');
  }
}
