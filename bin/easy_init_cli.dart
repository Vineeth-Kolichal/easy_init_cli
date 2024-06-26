import 'package:args/args.dart';
import 'package:dcli/dcli.dart';
import 'package:easy_init_cli/easy_init_logo.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';
import 'package:easy_init_cli/core/generator.dart';

const String version = '1.1.2';

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
  print('Usage: dart easy_init_cli.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    if (arguments.isEmpty) {
      print(blue(logo));
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
      print('easy_init_cli version: $version');
      return;
    }
    if (results.wasParsed('update')) {
      await ShellUtils().update();
      return;
    }
    final command = EasyInitCli(arguments).findCommand();
    command.excecute();
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
