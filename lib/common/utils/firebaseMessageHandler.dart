/*
 * @Author       : JHao
 * @Date         : 2021-09-02 17:29:21
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-02 18:39:24
 */
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homary/common/style/color.dart';
import 'package:homary/common/utils/initial.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/main.dart';

class FirebaseMessageHandler {
  static BuildContext context = navigatorKey.currentState.overlay.context;

  static _jumpUrl(Map<String, dynamic> messageData) {
    if (messageData['jump_url'] != null && messageData['jump_url'] != "") {
      handleSchema(context, messageData['jump_url']);
    }
  }

  // APP未启动时,启动后获取 firebase meeage
  static Future<void> getInitialMessage() async {
    RemoteMessage message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      var messageData = message.data;
      _jumpUrl(messageData);
    }
    await flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
            android: AndroidInitializationSettings('launcher_small'),
            iOS: IOSInitializationSettings()),
        onSelectNotification: (String payload) async {
      var messageData = jsonDecode(payload);
      _jumpUrl(messageData);
    });
  }

  // 當app 處於開啟狀態時，監聽推撥訊息用
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launcher_small',
                color: AppColor.primaryColor,
                largeIcon: DrawableResourceAndroidBitmap('launcher_icon'),
              ),
            ),
            payload: jsonEncode(message.data));
      }
    });
  }

  // APP在后台运行时 點通知訊息后要做的事情
  static Future<void> onMessageOpenedApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var messageData = message.data;
      _jumpUrl(messageData);
    });
  }
}
