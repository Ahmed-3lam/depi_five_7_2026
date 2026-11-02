# depi_five

A new Flutter project.

## Firebase notifications

`NotificationService.instance` in `lib/core/services/notification_service.dart`
starts automatically after the first app frame. It requests notification
permission, retrieves the FCM token, listens for token refreshes, and handles
notification taps from foreground, background, and terminated launches.
Android uses a high-importance local notification for foreground messages;
iOS uses native foreground presentation. FCM displays notification payloads
while the app is backgrounded. Data-only messages do not create visible alerts;
add any background data processing in `firebaseMessagingBackgroundHandler`.
Initialization failures are logged and leave the app usable; call `initialize()`
again to retry setup, or `refreshToken()` to retry token retrieval.

Access the current token from another feature:

```dart
final notifications = NotificationService.instance;
final token = notifications.token.value ?? await notifications.refreshToken();
// Register token with your backend when implementing targeted notifications.
// Listen to notifications.token for subsequent token changes.
```

Notification taps open the app and update
`NotificationService.instance.openedNotification`. Its `.value` retains the
initial message; features can also add a listener for subsequent taps and read
`message.data`. No payload-based navigation is enabled: consume this after
the existing splash/authentication flow if adding specific destinations.
Remove listeners when their owning feature is disposed. Tokens are not logged
or uploaded automatically. The FCM token APIs are intentionally retained for
Firebase Console testing; Firebase Messaging 17's replacement registration API
emits Firebase Installation IDs instead.

To test on Android:

1. Run the app on a device/emulator with Google Play services and allow
   notifications (Android 13+ prompts at runtime).
2. Retrieve `NotificationService.instance.token.value` in the debugger.
3. In Firebase project `depi72026`, open Messaging, create a notification with
   a title/body, and use **Send test message** with that FCM token.
4. Verify a visible alert while foregrounded and backgrounded, then tap a
   background notification. Close the app normally and test a cold-start tap
   too. Android force-stop prevents delivery until the app is reopened.

For iOS, the repository includes push entitlements and the remote-notification
background mode. Enable Push Notifications for the app ID/provisioning profile
in your Apple Developer account, verify the capability in Xcode, and upload an
APNs authentication key in Firebase Project Settings > Cloud Messaging. Leave
Firebase method swizzling enabled. Test on a physical iPhone with valid signing;
if APNs registration is not ready yet, retry `refreshToken()` later.
These Apple/Firebase account steps and real push delivery require device testing.

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
