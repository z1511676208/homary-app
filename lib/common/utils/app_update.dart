import 'dart:io';

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
    final market = 'market://details?id=${packageInfo.packageName}';
    if (await canLaunch(market)) {
      launch(market);
      return;
    }
    if (AppConfig.appChannel == AppConfig.CHANNEL_GOOGLE_PLAY) {
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
