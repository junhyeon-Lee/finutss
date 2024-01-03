// ignore_for_file: require_trailing_commas
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/social_pages/other_user_profile_page.dart';
import 'package:finutss/presentation/screens/track_screens/track_distance_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDNyZ9Q0mkJP51Kev3yrVe5rqNXY6koQsY',
    appId: '1:863785678740:android:0568616a4f075a35928181',
    messagingSenderId: '863785678740',
    projectId: 'finutss',
  ));
  print('-= Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
String? selectedNotificationPayload;

class PushHelp {
  final authController = Get.put(AuthController());
  var list = {};
  void init() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyDNyZ9Q0mkJP51Kev3yrVe5rqNXY6koQsY',
      appId: '1:863785678740:android:0568616a4f075a35928181',
      messagingSenderId: '863785678740',
      projectId: 'finutss',
    ));

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        print('-= getInitialMessage');
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'launch_background',
                ),
              ),
              payload: message.messageId);
        }

        list[message.messageId] = message.data;
      });
    }

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      print("-= getInitialMessage");
    });

    setNotification();

    var token = await getToken();
    print(" token is : ${token}");

    var value = {"pushToken": token};
    if (Platform.isAndroid) {
      value["pushType"] = "android";
    }
    if (Platform.isIOS) {
      value["pushType"] = "ios";
    }
    if (authController.user != null) authController.callApiUpdateUserInfo(value);
  }

  getToken() async {
    return await (FirebaseMessaging.instance)
        .getToken(vapidKey: 'BBHRYyYCYOjlDDUx7xUmCxDRRf39PQL3URKbMu9U88fdnPjrPX7eTv3zRbsFIB5pNoIoKNYZiFHB0eXypQCLDOU');
  }

  Future<void> setNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {
          print('onDidReceiveLocalNotification');
        });
    const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }

      selectedNotificationPayload = payload;

      var data = list[payload];

      if (data["type"] == "invite") {
        Get.to(() => TrackDistanceScreen());
      }
      if (data["type"] == "social") {
        var userInfo = await AuthController.callApIUserInfo(data["userId"]);
        Get.to(() => OtherUserProfilePage(), arguments: userInfo);
      }
      print("-= onSelectNotification");
    });
  }
}
