# flutter_i18n_locize examples

## Fetching translations

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

## Uploading new translations

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