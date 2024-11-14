package com.example.flutter_notifications

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Notifications.createNotificationChannels(this)
    }
}