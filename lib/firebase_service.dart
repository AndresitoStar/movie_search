import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service for request firebase account information
///
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class FirebaseService {
  static FirebaseMessaging get instance => _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Gets the firebase token based on firebase configurations
  Future<String> get token {
    return _firebaseMessaging.getToken();
  }

  Future<void> requestNotificationPermissions() async {
    await _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
  }

  initializeApp() async {
    await requestNotificationPermissions();
    await Firebase.initializeApp();

    print(await token);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _firebaseMessaging.configure(
      onBackgroundMessage: _myBackgroundMessageHandler,
    );
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

Future<dynamic> _myBackgroundMessageHandler(
    Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  await Firebase.initializeApp();

  // Or do other work.
}
