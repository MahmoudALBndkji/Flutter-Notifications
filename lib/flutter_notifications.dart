import 'package:flutter/material.dart';
import 'package:flutter_notifications/screen/home_screen.dart';

class FlutterNotifications extends StatelessWidget {
  const FlutterNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notifications',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
