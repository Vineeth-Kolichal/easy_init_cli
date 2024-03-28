abstract class Command {
  Future<void> excecute();
  String get commandName;
  List<Command> get children => [];
}
