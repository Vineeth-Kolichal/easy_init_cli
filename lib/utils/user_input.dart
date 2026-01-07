import 'dart:io';

import 'package:dcli/dcli.dart';

class UserInput {
  static String askQuestion(String question, String example) {
    print("${yellow("$question?")} ${grey("example: $example")}");
    final ans = stdin.readLineSync();
    if (ans != null && ans.isNotEmpty) {
      return ans;
    } else {
      return askQuestion(question, example);
    }
  }

  static int menu({required String prompt, required List<String> options}) {
    print('');
    for (var i = 0; i < options.length; i++) {
      print(yellow("  ${i + 1}. ${options[i]}"));
    }
    print('');
    print(blue(prompt));
    var ans = stdin.readLineSync();
    if (ans == null) {
      return menu(prompt: prompt, options: options);
    } else {
      var s = int.parse(ans);
      if (s == 0 || s > options.length) {
        print(red("[ERROR] Invalid selection!"));
        return menu(prompt: prompt, options: options);
      } else {
        return s;
      }
    }
  }
}
