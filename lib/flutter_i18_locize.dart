library flutter_i18_locize;

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

const String PROJECT_ID = '...';
const String API_KEY = '...';
const List<String> NAMESPACES = ['mobile'];
const String VERSION = 'latest';
const String PATH = './assets/flutter_i18n';
const List<String> LANGUAGES = ["en", "ru"];

BaseOptions _options = new BaseOptions(
  baseUrl: 'https://api.locize.app',
  headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  },
);

class FlutterI18Locize {
  doFetch() async {
    for (String lang in LANGUAGES) {
      print("Fetching translations for \"$lang\" language:");

      var content = {};

      for (String namespace in NAMESPACES) {
        var resource = await getResourceByLang(lang, namespace);
        content[namespace] = resource;
      }

      await saveToFile(lang, content);
    }
  }

  doUpload() async {
    for (String lang in LANGUAGES) {
      print("Uploading translations for \"$lang\" language:");

      for (String namespace in NAMESPACES) {
        var resource = await loadFromFile(lang);
        await saveToServer(lang, namespace, resource[namespace]);
      }
    }
  }

  saveToFile(String lang, content) async {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String encodedJson = encoder.convert(content);
    await File("$PATH/$lang.json").writeAsString(encodedJson);
  }

  loadFromFile(String lang) async {
    String resourceString = await File("$PATH/$lang.json").readAsString();
    JsonDecoder decoder = new JsonDecoder();
    return decoder.convert(resourceString);
  }

  Future saveToServer(String lang, String namespace, Map data) async {
    print("...namespace: \"$namespace\"");
    var dio = new Dio(_options);

    await dio.post('/missing/$PROJECT_ID/$VERSION/$lang/$namespace',
        data: data,
        options: Options(headers: {"Authorization": "Bearer $API_KEY"}));
  }

  Future getResourceByLang(String lang, String namespace) async {
    print("...namespace: \"$namespace\"");
    var dio = new Dio(_options);
    var resourceResponse =
        await dio.get('/$PROJECT_ID/$VERSION/$lang/$namespace');
    return resourceResponse.data;
  }
}
