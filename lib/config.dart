import 'dart:io';

import 'package:yaml/yaml.dart';

class Config {
  String projectId;
  String apiKey;
  List<String> namespaces;
  String version;
  String path;
  List<String> languages;

  Future<void> loadConfig() async {
    String yamlConfig = await File("./.locize.yaml").readAsString();
    var config = loadYaml(yamlConfig);

    path = config["assetsPath"] ?? './assets/flutter_i18n';
    projectId = config["project"]["id"];
    apiKey = config["project"]["apiKey"];
    languages =
        (config["project"]["languages"] as YamlList).toList().cast<String>();
    namespaces =
        (config["project"]["namespaces"] as YamlList).toList().cast<String>();
    version = config["project"]["version"] ?? "latest";
  }
}
