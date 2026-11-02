import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';

/// Runs in a separate isolate on Android. Notification payloads are displayed
/// by FCM while backgrounded; displaying them here would create duplicates.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Add background data processing here when the app needs it (no UI access).
}

class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();
  static const _channel = AndroidNotificationChannel(
    'app_notifications',
    'App notifications',
    description: 'Notifications received from Firebase',
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _token = ValueNotifier<String?>(null);
  final _openedNotification = ValueNotifier<RemoteMessage?>(null);
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  Future<void>? _initialization;

  /// Listen for changes to register the latest token with a trusted backend.
  ValueListenable<String?> get token => _token;

  /// Includes cold-start taps. Read .value as well as listening for later taps.
  /// Navigation can consume this after authentication and splash have finished.
  ValueListenable<RemoteMessage?> get openedNotification => _openedNotification;

  bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Safe to call more than once; notification failures never block startup.
  Future<void> initialize() => _initialization ??= _initializeSafely();

  Future<void> _initializeSafely() async {
    if (kIsWeb ||
        (!_isAndroid && defaultTargetPlatform != TargetPlatform.iOS)) {
      return;
    }
    try {
      final messaging = FirebaseMessaging.instance;
      if (_isAndroid) {
        await _localNotifications.initialize(
          settings: const InitializationSettings(
            android: AndroidInitializationSettings('ic_notification'),
          ),
          onDidReceiveNotificationResponse: _onLocalNotificationTap,
        );
        await _localNotifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.createNotificationChannel(_channel);
        final launch = await _localNotifications
            .getNotificationAppLaunchDetails();
        if (launch?.didNotificationLaunchApp ?? false) {
          final response = launch?.notificationResponse;
          if (response != null) _onLocalNotificationTap(response);
        }
      }

      // iOS presents remote alerts itself; only Android needs a local alert.
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      _subscriptions.addAll([
        FirebaseMessaging.onMessage.listen((message) {
          unawaited(_showForegroundNotification(message));
        }),
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          _openedNotification.value = message;
        }),
        // Keep FCM tokens for Firebase Console's "Send test message" workflow.
        // The replacement onRegistered API emits Installation IDs instead.
        // ignore: deprecated_member_use
        messaging.onTokenRefresh.listen(
          (value) => _token.value = value,
          onError: (Object error) {
            debugPrint('Notification token refresh failed: $error');
          },
        ),
      ]);
      final initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) _openedNotification.value = initialMessage;

      await requestPermission();
      await refreshToken();
    } catch (error) {
      debugPrint('Notification initialization failed: $error');
      for (final subscription in _subscriptions) {
        await subscription.cancel();
      }
      _subscriptions.clear();
      _initialization = null;
    }
  }

  Future<NotificationSettings> requestPermission() {
    return FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Can be called again when APNs registration or connectivity becomes ready.
  Future<String?> refreshToken() async {
    try {
      final messaging = FirebaseMessaging.instance;
      if (defaultTargetPlatform == TargetPlatform.iOS &&
          await messaging.getAPNSToken() == null) {
        return null;
      }
      // The Console test-message workflow requires an FCM registration token.
      // ignore: deprecated_member_use
      _token.value = await messaging.getToken();
      return _token.value;
    } catch (error) {
      debugPrint('Unable to retrieve the notification token: $error');
      return null;
    }
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (!_isAndroid || notification == null) return;
    try {
      await _localNotifications.show(
        id:
            (message.messageId ?? DateTime.now().toIso8601String()).hashCode &
            0x7fffffff,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: 'ic_notification',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    } catch (error) {
      debugPrint('Unable to display the foreground notification: $error');
    }
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;
    try {
      _openedNotification.value = RemoteMessage.fromMap(
        Map<String, dynamic>.from(jsonDecode(payload) as Map),
      );
    } catch (error) {
      debugPrint('Unable to read the notification payload: $error');
    }
  }
}
