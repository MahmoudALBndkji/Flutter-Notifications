import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  // * Basic Notification & With Custom Sound
  static void showBasicNotification({required RemoteMessage message}) async {
    // For Receive Image
    final http.Response response = await http.get(
      Uri.parse(message.notification?.android?.imageUrl ?? ""),
    );
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(
        base64Encode(response.bodyBytes),
      ),
    );

    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_id",
        "channel_name",
        priority: Priority.high,
        importance: Importance.max,
        // For Display Image
        styleInformation: bigPictureStyleInformation,
        playSound: true,
        sound:
            RawResourceAndroidNotificationSound('sound.wav'.split('.').first),
      ),
      iOS: const DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: "Payload Data",
    );
  }

  // * Repeated Notification
  static void showRepeatedNotification() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id 2",
        "Repeated Notification",
        priority: Priority.high,
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Repeated Notification',
      'Body',
      RepeatInterval.everyMinute,
      details,
      payload: "Payload Data",
    );
  }

  // * Scheduled Notification
  static void showScheduledNotification() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id 3",
        "Scheduled Notification",
        priority: Priority.high,
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      "Scheduled Notification",
      "Time : ${tz.TZDateTime.now(tz.local).hour} : ${tz.TZDateTime.now(tz.local).minute}",
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 4)),
      // tz.TZDateTime(tz.local, 2024, 10, 31, 2, 6),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // * Daily Scheduled Notification
  static void showDailyScheduledNotification() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id 4",
        "Daily Scheduled Notification",
        priority: Priority.high,
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var currentTime = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      12,
      0,
    );
    if (scheduledTime.isBefore(currentTime)) {
      scheduledTime = scheduledTime.add(Duration(hours: 1));
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      4,
      "Daily Scheduled Notification",
      "body",
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      scheduledTime,
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
