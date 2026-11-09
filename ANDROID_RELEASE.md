# Android release

The application ID is `com.ahmedallam.depifive`. The current version is
`1.0.0+1` in `pubspec.yaml`. Android SDK versions follow the installed Flutter
SDK (currently compile/target API 36).

## Signing files

- `upload-keystore.jks` at the project root: private RSA upload key, alias `upload`.
- `android/key.properties`: generated passwords and relative keystore path.
- Both files are excluded from Git and restricted to the local account.

Back up both files securely outside this project, and retain the same upload key
for subsequent releases. Do not commit or share the passwords. On another machine,
restore both files at the same paths. `android/key.properties.example` documents
the format. Gradle reports missing signing files rather than using a debug key.

This key is for a new Play application. If this package already has a Play listing,
confirm its registered upload certificate matches before uploading; an existing
listing may require its previous key or a Play Console upload-key reset.

## Build

```sh
flutter pub get
flutter build appbundle --release
```

The signed bundle is written to `build/app/outputs/bundle/release/app-release.aab`.
For each later upload, increase the build number in `pubspec.yaml`, or specify:

```sh
flutter build appbundle --release --build-name=1.0.1 --build-number=2
```

Upload the bundle in Play Console and use Play App Signing. Google manages the
distribution signing key; this local key signs uploads. Complete the store listing,
privacy policy, Data safety, app access and content declarations in Play Console.
Test the release through an internal testing track before rolling it out.

Signing/build validation does not verify live Firebase services, notifications,
account flows, or Play review acceptance. If configuring certificate-dependent
Firebase services, use the Play app signing certificate for Play-installed builds.

References: [Flutter Android release guide](https://docs.flutter.dev/deployment/android)
and [Android app signing](https://developer.android.com/studio/publish/app-signing).
