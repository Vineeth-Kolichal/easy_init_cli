import 'dart:io';

import 'package:dcli/dcli.dart';

String askQuestion(String question, String example) {
  print("${yellow("$question?")} ${grey("example: $example")}");
  final ans = stdin.readLineSync();
  if (ans != null && ans.isNotEmpty) {
    return ans;
  } else {
    return askQuestion(question, example);
  }
}
