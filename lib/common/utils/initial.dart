/*
 * @Author       : JHao
 * @Date         : 2021-06-21 18:40:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-29 14:34:44
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homary/api/common.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/entity/initConfig.dart';

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
    InitConfigRes result;
    CommonApi.getInitConfig().then((res) {
      if (res.error == null) {
        result = InitConfigRes.fromJson(res.result);
        if (result?.data?.urlMapData != null) {
          Localstorage().setJSON(REQUEST_URL, result.data.urlMapData);
        }
        if (result?.data?.dynamicData != null) {
          Localstorage().setJSON(DYNAMIC_DATA, result.data.dynamicData);
        }
      }
    });

    /// android 初始化
    if (Platform.isAndroid) {}

    /// IOS 初始化
    if (Platform.isIOS) {}
  }
}
