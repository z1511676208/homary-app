/*
 * @Author       : JHao
 * @Date         : 2021-06-21 18:40:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-14 14:34:49
 */
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homary/common/config/storage.dart';

/// 全局变量
class Global {
  /// 判断当前环境是否 release (生产环境)
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // 初始化工具函数
    Request();
    await Localstorage.init();

    // 请求 init 接口，获取基础配置
    Future.delayed(Duration(seconds: 1)).then((value) {
      Localstorage().setJSON(REQUEST_URL, {
        "getProductUrl":
            "https://frontapi.homary.com/home/index?pid=%replace%&name=%replace%&sku=%replace%"
      });
    });

    /// android 初始化
    if (Platform.isAndroid) {}

    /// IOS 初始化
    if (Platform.isIOS) {}
  }
}
