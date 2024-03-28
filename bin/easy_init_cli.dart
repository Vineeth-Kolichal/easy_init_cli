import 'package:args/args.dart';
import 'package:dcli/dcli.dart';
import 'package:easy_init_cli/common/utils/shell_utils.dart';
import 'package:easy_init_cli/core/generator.dart';

const String version = '0.0.1';

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
      negatable: true,
      help: 'update easy init cli',
    )
    ..addFlag(
      'init',
      negatable: false,
      help: 'Initialize flutter project with TDD clean architecture',
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
      print(blue(''' Easy Init CLI version:$version
'''));
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

    //print('Positional arguments: ${results.rest}');
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
