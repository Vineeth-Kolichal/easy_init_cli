import 'package:easy_init_cli/core/generator.dart';

mixin ArgsMixin {
  List<String> args = EasyInitCli.args;

  String get name {
    if (args.length > 1) {
      if (args[0] == 'create') {
        var arg = args[1];
        var split = arg.split(":");
        var nm = split.last;
        return nm;
      }
    }
    return '';
  }
}
