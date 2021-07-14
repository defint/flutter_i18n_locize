# flutter_i18n_locize

Easy integration locize.io to flutter_i18n. Contains methods to fetch translations and upload new translations.

[![Pub Package](https://img.shields.io/pub/v/flutter_i18n_locize.svg)](https://pub.dev/packages/flutter_i18n_locize)
[![GitHub Actions](https://github.com/defint/flutter_i18n_locize/workflows/Publish%20CI/badge.svg)](https://github.com/defint/flutter_i18n_locize/actions)

## Use cases

### Fetching translations

Create config file `.locize.yaml` inside your root project folder and paste the next lines:

```yaml
assetsPath: "./assets/flutter_i18n"
project:
  id: "..."      # change your project id
  namespaces:    # change your supported namespaces
    - "mobile"
  languages:     # change your supported languages
    - "en"
    - "ru"
  version: "latest"
```

Open your terminal and run next command:

```
flutter pub run flutter_i18n_locize fetch
```

Check that translations has been loaded to your assets.

### Uploading new translations

Create config file `.locize.yaml` inside your root project folder and paste the next lines:

```yaml
assetsPath: "./assets/flutter_i18n"
project:
  id: "..."      # change your project id
  apiKey: "..."  # change your API key
  namespaces:    # change your supported namespaces
    - "mobile"
  languages:     # change your supported languages
    - "en"
    - "ru"
  version: "latest"
```

Add some translations to your assets.
Open your terminal and run:

```
flutter pub run flutter_i18n_locize upload
```

Check that translations has been uploaded to locize.io.

## Available commands

| Command | Description |
|---------|-------------|
| `fetch` | Downloads translations from the locize.io to your assets folder. |
| `upload` | Uploads translations to the locize.io from your assets folder. |
