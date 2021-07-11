import 'dart:io';

import 'package:yaml/yaml.dart';

class Config {
  late String projectId;
  late String apiKey;
  late List<String> namespaces;
  late String version;
  late String path;
  late List<String> languages;

  Future<void> loadConfig() async {
    String yamlConfig = await File("./.locize.yaml").readAsString();
    var config = loadYaml(yamlConfig);

    path = config["assetsPath"] ?? './assets/flutter_i18n';

    var projectConfig = config["project"];

    if (projectConfig == null) {
      throw new Exception("Project config not found.");
    }

    projectId = projectConfig["id"];
    apiKey = projectConfig["apiKey"];
    languages =
        (projectConfig["languages"] as YamlList).toList().cast<String>();
    namespaces =
        (projectConfig["namespaces"] as YamlList).toList().cast<String>();
    version = config["project"]["version"] ?? "latest";
  }
}
