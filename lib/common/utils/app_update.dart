import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:homary/common/config/appConfig.dart';
import 'package:homary/common/config/packageInfo.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateUtil {
  static void goAppStore() {
    if (Platform.isIOS) {
      _appleStore();
    }
    if (Platform.isAndroid) {
      _androidStore();
    }
  }

  static void _androidStore() async {
    if (AppConfig.appChannel == AppConfig.CHANNEL_GOOGLE_PLAY) {
      // 判断是否已安装 google 应用市场
      bool isInstalled = await DeviceApps.isAppInstalled('com.android.vending');

      final market = 'market://details?id=${packageInfo.packageName}';
      if (isInstalled && await canLaunch(market)) {
        launch(market);
        return;
      }

      final url =
          'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';
      if (await canLaunch(url)) {
        launch(url);
        return;
      }
    }
  }

  static void _appleStore() {}
}
