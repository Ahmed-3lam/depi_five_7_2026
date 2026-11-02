# depi_five

A new Flutter project.

## Required app updates

`lib/core/services/remote_config_service.dart` reads these Firebase Remote Config
parameters during the splash screen:

- `force_update` (Boolean, default `false`)
- `min_app_version` (String, default `1.0.0`)

The update dialog blocks navigation, outside taps, and Back only when
`force_update` is true and the installed app version is below `min_app_version`.
Versions use semantic comparison (`1.10.0` is newer than `1.9.0`); build numbers
are ignored. Equal or newer versions continue through the existing startup flow.
Fetch failures use activated cached values, or defaults on a fresh installation.
Malformed version values do not block startup.

Replace the dummy `AppConfig.appStoreUrl` in `lib/config/app_config.dart` with the
published store URL before release. The Update now action opens it externally
and keeps the app blocked. Check again re-evaluates the policy. Fetches have a
10-second timeout and a one-hour minimum interval in release builds (zero in
debug builds), so release checks may reuse cached policy within that interval.

To test with the current `1.0.0` app, **publish** `force_update = true` and
`min_app_version = 1.0.1` in Firebase, then restart the app. Draft console values
are not fetched. Setting the minimum to `1.0.0` should allow this version through.
Use platform conditions if Android and iOS require different minimum versions.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
