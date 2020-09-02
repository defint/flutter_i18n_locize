import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_i18n_locize/flutter_i18n_locize.dart';

import 'package:flutter_i18n_locize/config.dart';

void main() {
  test('invokes "fetch" without crash', () async {
    var config = Config();
    config.languages = ["en"];
    config.namespaces = [];
    config.path = "./test/assets";

    final flutterI18Locize = FlutterI18Locize(config);
    await flutterI18Locize.fetch();
  });

  test('invokes "upload" without crash', () async {
    var config = Config();
    config.languages = ["en"];
    config.namespaces = [];
    config.path = "./test/assets";

    final flutterI18Locize = FlutterI18Locize(config);
    await flutterI18Locize.fetch();
  });
}
