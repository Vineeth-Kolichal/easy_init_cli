import 'package:args/args.dart';
import 'package:dcli/dcli.dart';
import 'package:easy_init_cli/easy_init_logo.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:easy_init_cli/core/generator.dart';
import 'package:easy_init_cli/core/version.dart';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addFlag(
      'update',
      negatable: false,
      help: 'update easy init cli',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: easy <command> [arguments]');
  print('');
  print('Available commands:');
  print('  create project      Create a new Flutter project');
  print('  init                Initialize project with architecture');
  print('  create feature      Create a new feature');
  print(
      '  create services     Add services (FCM, Token Manager, Shared Prefs)');
  print('  build               Run build_runner');
  print('  update              Update easy_init_cli');
  print('');
  print('Global flags:');
  print(argParser.usage);
}

void main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    if (arguments.isEmpty) {
      print(yellow(logo));
      //printUsage(argParser);
      return;
    }
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('easy_init_cli version: $packageVersion');
      return;
    }
    if (results.wasParsed('update')) {
      await ShellUtils().update();
      return;
    }
    final command = EasyInitCli(arguments).findCommand();
    await command.execute();
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  } catch (e) {
    print(red("[ERROR] An unexpected error occurred: $e"));
  }
}
