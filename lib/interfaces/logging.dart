import 'package:dcli/dcli.dart';

mixin Logging {
  void yellowLog(String text) {
    print(yellow(text));
  }

  void greenLog(String text) {
    print(green(text));
  }

  void blueLog(String text) {
    print(blue(text));
  }
}
