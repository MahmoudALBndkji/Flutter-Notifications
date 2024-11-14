import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key, required this.response});
  final NotificationResponse response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Response Id : ${response.id}\n Response Payload: ${response.payload}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
