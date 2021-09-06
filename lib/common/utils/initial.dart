/*
 * @Author       : JHao
 * @Date         : 2021-06-21 18:40:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-02 17:23:02
 */
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homary/api/common.dart';
import 'package:homary/common/config/packageInfo.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/config/proxyConfig.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/entity/initConfig.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:system_proxy/system_proxy.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // await Firebase.initializeApp();
//   print("Handling a background message ${message.messageId}");
// }

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// 全局变量
class Global {
  /// 判断当前环境是否 release (生产环境)
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // 强制竖屏
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // 获取包信息
    packageInfo = await PackageInfo.fromPlatform();
    print(
        'packageInfo  ${packageInfo.appName}  ${packageInfo.buildNumber}  ${packageInfo.packageName}  ${packageInfo.version}');

    // 获取设备代理信息
    proxy = await SystemProxy.getProxySettings();

    // 初始化工具函数
    Request();
    await Localstorage.init();

    // 请求 init 接口，获取基础配置
    InitConfigRes result;
    final commonResult = await CommonApi.getInitConfig();
    await Localstorage().setJSON(StorageKey.REQUEST_URL, {});
    if (commonResult.error == null) {
      result = InitConfigRes.fromJson(commonResult.result);
      if (result?.data?.urlMapData != null) {
        await Localstorage().setJSON(StorageKey.REQUEST_URL, result.data.urlMapData);
      }
      if (result?.data?.dynamicData != null) {
        await Localstorage().setJSON(StorageKey.DYNAMIC_DATA, result.data.dynamicData);
      }
    }

    /// android 初始化
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    /// IOS 初始化
    if (Platform.isIOS) {}
  }
}
