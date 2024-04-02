import 'package:easy_init_cli/interfaces/args_mixin.dart';
import 'package:easy_init_cli/interfaces/logging.dart';

abstract class Command with Logging, ArgsMixin {
  Future<void> excecute();
  String get commandName;
  List<Command> get children => [];
}
