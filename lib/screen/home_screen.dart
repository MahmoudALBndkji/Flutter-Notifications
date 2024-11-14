import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notifications/screen/notification_details_screen.dart';
import 'package:flutter_notifications/services/local_notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    listenToNotificationStream();
  }

  void listenToNotificationStream() {
    LocalNotificationService.streamController.stream
        .listen((notificationResponse) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              NotificationDetailsScreen(response: notificationResponse),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: const Icon(Icons.notifications),
        titleSpacing: 0.0,
        title: const Text('Flutter Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic Notification
            ListTile(
              onTap: () {
                LocalNotificationService.showBasicNotification(
                  message: const RemoteMessage(
                    notification: RemoteNotification(
                      title: 'Basic Notification',
                      body: 'body',
                    ),
                  ),
                );
              },
              leading: const Icon(Icons.notifications),
              trailing: IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () {
                  LocalNotificationService.cancelNotification(0);
                },
              ),
              title: const Text('Basic Notification'),
            ),
            // Repeated Notification
            ListTile(
              onTap: () {
                LocalNotificationService.showRepeatedNotification();
              },
              leading: const Icon(Icons.notifications),
              trailing: IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () {
                  LocalNotificationService.cancelNotification(1);
                },
              ),
              title: const Text('Repeated Notification'),
            ),
            // Scheduled Notification
            ListTile(
              onTap: () {
                LocalNotificationService.showScheduledNotification();
              },
              leading: const Icon(Icons.notifications),
              trailing: IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () {
                  LocalNotificationService.cancelNotification(2);
                },
              ),
              title: const Text('Scheduled Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotificationService.flutterLocalNotificationsPlugin
                    .cancelAll();
              },
              child: const Text("Cancel All"),
            ),
          ],
        ),
      ),
    );
  }
}
