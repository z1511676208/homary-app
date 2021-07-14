/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:38:55
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-13 14:01:21
 * APP本地数据存储
 */

import 'package:homary/common/utils/localstorage.dart';

Future<void> setCurrentConfig(dynamic data) async {
  await Localstorage().setJSON('currentConfig', data);
}

Future<void> setToken(String token) async {
  await Localstorage().setString('token', token);
}

Future<void> setUserInfo(dynamic data) async {
  await Localstorage().setJSON('userInfo', data);
}

String getCurrentConfig() {
  return Localstorage().getString('currentConfig');
}

String getToken() {
  String token = Localstorage().getString('token');
  return token;
}

String getUserInfo() {
  return Localstorage().getString('userInfo');
}
