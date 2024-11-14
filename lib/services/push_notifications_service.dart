import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notifications/firebase_options.dart';
import 'package:flutter_notifications/services/local_notification_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      sendTokenToServer(value ?? "");
    });
    messaging.onTokenRefresh.listen((value) {
      sendTokenToServer(value);
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    // Foreground
    handleForegroundMessage();
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static void handleForegroundMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(message: message);
    });
  }

  static void sendTokenToServer(String token) {
    // Put Logic For Send Token To API
  }
}
