/*
 * @Author       : JHao
 * @Date         : 2021-09-01 16:28:18
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 17:54:00
 */
import 'dart:io';

class AppConfig {
  /// 奔溃监控 sentry 配置
  static const SENTRY_DSN =
      'https://1dd888a603ba4f49843bf07c03efaf49@sentry.homary.com/6';

  /// 苹果应用商店
  static const CHANNEL_APPLE_STORE = 'AppleStore';

  /// 谷歌应用商店
  static const CHANNEL_GOOGLE_PLAY = 'GooglePlay';

  /// 当前上架渠道
  static final appChannel = String.fromEnvironment("CHANNEL",
      defaultValue:
          Platform.isAndroid ? CHANNEL_GOOGLE_PLAY : CHANNEL_APPLE_STORE);
}
