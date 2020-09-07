library flutter_i18_locize;

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_i18n/loaders/network_file_translation_loader.dart';
import 'package:flutter_i18n_locize/config.dart';

BaseOptions _options = new BaseOptions(
  baseUrl: 'https://api.locize.app',
  headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  },
);

class FlutterI18Locize {
  final Config config;

  FlutterI18Locize(this.config);

  Future<void> fetch() async {
    for (String lang in config.languages) {
      print("Fetching translations for \"$lang\" language:");

      var content = {};

      for (String namespace in config.namespaces) {
        var resource = await _getResourceByLang(lang, namespace);
        content[namespace] = resource;
      }

      await _saveToFile(lang, content);
    }
  }

  Future<void> upload() async {
    for (String lang in config.languages) {
      print("Uploading translations for \"$lang\" language:");

      for (String namespace in config.namespaces) {
        var resource = await _loadFromFile(lang);
        await _saveToServer(lang, namespace, resource[namespace]);
      }
    }
  }

  _saveToFile(String lang, content) async {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String encodedJson = encoder.convert(content);
    await File("${config.path}/$lang.json").writeAsString(encodedJson);
  }

  _loadFromFile(String lang) async {
    String resourceString =
        await File("${config.path}/$lang.json").readAsString();
    JsonDecoder decoder = new JsonDecoder();
    return decoder.convert(resourceString);
  }

  _saveToServer(String lang, String namespace, Map data) async {
    print("...namespace: \"$namespace\"");
    var dio = new Dio(_options);

    try {
      await dio.post(
          '/missing/${config.projectId}/${config.version}/$lang/$namespace',
          data: data,
          options:
              Options(headers: {"Authorization": "Bearer ${config.apiKey}"}));
    } on DioError catch (e) {
      if (e.response.statusCode == 412) {
        // Ignore, because nothing to update
      } else {
        throw e;
      }
    }
  }

  _getResourceByLang(String lang, String namespace) async {
    print("...namespace: \"$namespace\"");
    var dio = new Dio(_options);
    var resourceResponse = await dio
        .get('/${config.projectId}/${config.version}/$lang/$namespace');
    return resourceResponse.data;
  }
}

class LocizeTranslationLoader extends NetworkFileTranslationLoader {
  LocizeTranslationLoader({
    forcedLocale,
    fallbackFile = "en",
    useCountryCode = false,
  }) : super(
          fallbackFile: fallbackFile,
          useCountryCode: useCountryCode,
          forcedLocale: forcedLocale,
          baseUri: Uri.https("api.locize.io", "get"),
          decodeStrategies: [JsonDecodeStrategy()],
        );

  Future<String> loadString(final String fileName, final String extension) {
    return networkAssetBundle.loadString("3f3dc751-3bf1-4563-82ca-f3b7091c2a93/latest/ru/mobile");
  }
}
