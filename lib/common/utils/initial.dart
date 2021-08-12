/*
 * @Author       : JHao
 * @Date         : 2021-06-21 18:40:47
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-16 09:50:03
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homary/api/common.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/config/proxyConfig.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/entity/initConfig.dart';
import 'package:system_proxy/system_proxy.dart';

/// 全局变量
class Global {
  /// 判断当前环境是否 release (生产环境)
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // 强制竖屏
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    proxy = await SystemProxy.getProxySettings();

    // 初始化工具函数
    Request();
    await Localstorage.init();

    // 请求 init 接口，获取基础配置
    InitConfigRes result;
    final commonResult = await CommonApi.getInitConfig();
    if (commonResult.error == null) {
      result = InitConfigRes.fromJson(commonResult.result);
      if (result?.data?.urlMapData != null) {
        await Localstorage().setJSON(REQUEST_URL, result.data.urlMapData);
      }
      if (result?.data?.dynamicData != null) {
        await Localstorage().setJSON(DYNAMIC_DATA, result.data.dynamicData);
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
