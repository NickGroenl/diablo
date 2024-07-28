import 'package:diablo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


 void showNotification(String title, String description) {
    
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        description,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher'),
        ),
        payload: 'payload');
    
}