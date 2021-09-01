import 'dart:io';

class AppConfig {
  /// 奔溃监控 sentry 配置
  static const SENTRY_DSN =
      'https://d252459507f2481fb6694d8301d260b5@sentry.homary.com/5';

  /// 苹果应用商店
  static const CHANNEL_APPLE_STORE = 'AppleStore';
  /// 谷歌应用商店
  static const CHANNEL_GOOGLE_PLAY = 'GooglePlay';

  /// 当前上架渠道
  static final appChannel = String.fromEnvironment("CHANNEL",
      defaultValue:
          Platform.isAndroid ? CHANNEL_GOOGLE_PLAY : CHANNEL_APPLE_STORE);
}