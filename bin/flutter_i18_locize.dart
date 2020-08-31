import 'package:flutter_i18_locize/config.dart';
import 'package:flutter_i18_locize/flutter_i18_locize.dart';

void main(List<String> args) async {
  if (args.length == 0) {
    print("You have to pass 'fetch' or 'upload' argument");
    return;
  }

  var config = Config();
  await config.loadConfig();

  var locize = FlutterI18Locize(config);

  if (args[0] == 'fetch') {
    await locize.fetch();
  }

  if (args[0] == 'upload') {
    await locize.upload();
  }

  print("Done!");
}
