import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notifications/firebase_options.dart';
import 'package:flutter_notifications/flutter_notifications.dart';
import 'package:flutter_notifications/services/local_notification_service.dart';
import 'package:flutter_notifications/services/push_notifications_service.dart';
import 'package:flutter_notifications/services/work_manager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.wait([
    LocalNotificationService.init(),
    PushNotificationsService.init(),
    WorkManagerService().init(),
  ]);
  runApp(const FlutterNotifications());
}
