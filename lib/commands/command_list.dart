import 'package:easy_init_cli/commands/create_feature/create_feature.dart';
import 'package:easy_init_cli/commands/create_project/create_project.dart';
import 'package:easy_init_cli/commands/init/init.dart';
import 'package:easy_init_cli/commands/update/update.dart';
import 'package:easy_init_cli/interfaces/command.dart';

List<Command> commands = [
  CommandParent(
    "create",
    [
      CreateProject(),
      CreateFeature(),
    ],
  ),
  InitProject(),
  Update()
];

class CommandParent extends Command {
  final List<Command> _children;
  final String _name;
  CommandParent(this._name, this._children);

  @override
  List<Command> get children => _children;

  @override
  String get commandName => _name;

  @override
  Future<void> excecute() async {}
}
