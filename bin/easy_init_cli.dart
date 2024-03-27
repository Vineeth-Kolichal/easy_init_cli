import 'dart:io';

import 'package:args/args.dart';
import 'package:dcli/dcli.dart';
import 'package:easy_init_cli/commands/create_project/create_project.dart';
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
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart easy_init_cli.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('easy_init_cli version: $version');
      String? projectName = stdin.readLineSync();
      print(yellow("$projectName"));
      // print(yellow('$a'));
      return;
    }
    final command = EasyInitCli(arguments).findCommand();
    command.excecute();
    // print(command);
    // if (arguments[0] == "create") {
    //   CreateProject().excecute();
    //   return;
    // }
    // Act on the arguments provided.
    print('Positional arguments: ${results.rest}');
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
