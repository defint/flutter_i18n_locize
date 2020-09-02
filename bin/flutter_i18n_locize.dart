import 'package:flutter_i18n_locize/config.dart';
import 'package:flutter_i18n_locize/flutter_i18n_locize.dart';

void main(List<String> args) async {
  if (args.length == 0) {
    print("You have to pass 'fetch' or 'upload' argument");
    return;
  }

  var config = Config();
  await config.loadConfig();

  var locize = FlutterI18Locize(config);

  switch (args[0]) {
    case 'fetch':
      await locize.fetch();
      break;
    case 'upload':
      await locize.upload();
      break;
    default:
      print("You have to pass 'fetch' or 'upload' argument");
      return;
  }

  print("Done!");
}
