import 'package:easy_init_cli/interfaces/command.dart';
import 'package:easy_init_cli/utils/shell_utils.dart';

class Update extends Command {
  @override
  String get commandName => "update";

  @override
  Future<void> excecute() async {
    await ShellUtils().update();
  }
}
