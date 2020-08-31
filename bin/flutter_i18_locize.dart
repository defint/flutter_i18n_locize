import 'package:flutter_i18_locize/flutter_i18_locize.dart';

void main(List<String> args) async {
  if (args.length == 0) {
    print("You have to pass 'fetch' or 'upload' argument");
    return;
  }

  if (args[0] == 'fetch') {
    await FlutterI18Locize().fetch();
  }

  if (args[0] == 'upload') {
    await FlutterI18Locize().upload();
  }

  print("Done!");
}
