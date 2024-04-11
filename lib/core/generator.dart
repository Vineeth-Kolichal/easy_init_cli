import 'package:easy_init_cli/commands/command_list.dart';
import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

class EasyInitCli {
  final List<String> _arguments;
  EasyInitCli(this._arguments) {
    _instance = this;
  }
  static EasyInitCli? _instance;
  static EasyInitCli? get instance => _instance;
  static List<String> get args => instance!._arguments;

  Command findCommand() => _findCommand(0, commands);
  Command _findCommand(int currentIndex, List<Command> commands) {
    final currentArgument = _arguments[currentIndex].split(":").first;

    var command = commands.firstWhere(
      (command) => command.commandName == currentArgument,
      orElse: () => ErrorCommand("[ERROR] Command not found"),
    );

    if (command.children.isNotEmpty) {
      if (command is CommandParent) {
        command = _findCommand(++currentIndex, command.children);
      }
    }
    return command;
  }
}

class ErrorCommand extends Command with Logging {
  @override
  String get commandName => 'onError';
  String error;
  ErrorCommand(this.error);

  @override
  Future<void> excecute() async {
    redLog(error);
  }
}
