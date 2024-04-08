import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';

class RunBuildRunner extends Command {
  @override
  String get commandName => "build";

  @override
  Future<void> excecute() async {
    await ShellUtils().runBuildRunner();
  }
}
