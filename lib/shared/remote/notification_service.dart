import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

import '../../firebase_options.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeFirebaseMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    print('Firebase Messaging Initialized');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//    await _createCustomChannel();
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    _showNotification(message);
  }

  // static Future<void> _createCustomChannel() async {
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'lovard_channel',
  //     'lovard_channel',
  //     importance: Importance.high,
  //     //playSound: true,
  //     //sound: RawResourceAndroidNotificationSound('notification'),
  //   );
  //
  //   _flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  //
  //   await FirebaseMessaging.instance.requestPermission(
  //     alert: true,
  //     announcement: true,
  //     badge: true,
  //     carPlay: true,
  //     criticalAlert: true,
  //     provisional: true,
  //     sound: true,
  //   );
  // }

  static void _showNotification(RemoteMessage message) async {
    print("Notification Received: ${message.data}");

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'lovard_channel',
      'lovard_channel',
      importance: Importance.high,
      priority: Priority.high,
      //sound: RawResourceAndroidNotificationSound('notification'),
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      1,
      message.data['title'],
      message.data['description'],
      platformChannelSpecifics,
    );
  }

  static void handleForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground Notification Received');
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked and app opened');
    });
  }

// static Future<void> subscribeToTopic(String personID) async {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   if (Platform.isIOS) {
//     String? apnsToken = await _firebaseMessaging.getAPNSToken();
//     if (apnsToken != null) {
//       await _firebaseMessaging.subscribeToTopic(personID);
//       print('Subscribed to topic $personID');
//     } else {
//       await Future<void>.delayed(const Duration(seconds: 3));
//       apnsToken = await _firebaseMessaging.getAPNSToken();
//       if (apnsToken != null) {
//         await _firebaseMessaging.subscribeToTopic(personID);
//         print('Subscribed to topic $personID after delay');
//       } else {
//         print('Failed to retrieve APNS token after delay');
//       }
//     }
//   } else {
//     await _firebaseMessaging.subscribeToTopic(personID);
//     print('Subscribed to topic $personID on non-iOS platform');
//   }
// }
}
