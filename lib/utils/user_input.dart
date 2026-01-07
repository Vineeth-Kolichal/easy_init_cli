import 'package:dcli/dcli.dart' as dcli;

class UserInput {
  static String askQuestion(String question, String example) {
    return dcli.ask(
      "${dcli.yellow(question)} ${dcli.grey("($example)")}",
      validator: dcli.Ask.required,
    );
  }

  static int menu({required String prompt, required List<String> options}) {
    final selection = dcli.menu(
      dcli.blue(prompt),
      options: options,
      defaultOption: options.first,
    );
    return options.indexOf(selection) + 1;
  }
}
