/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:38:55
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-09 11:22:03
 * APP本地数据存储
 */

import 'package:homary/common/config/storage.dart';
import 'package:homary/common/utils/localstorage.dart';

Future<void> setCurrentConfig(dynamic data) async {
  await Localstorage().setJSON(StorageKey.CURRENT_CONFIG, data);
}

Future<void> setToken(String token) async {
  await Localstorage().setString(StorageKey.TOKEN, token);
}

Future<void> setUserInfo(dynamic data) async {
  await Localstorage().setJSON(StorageKey.USER_INFO, data);
}

getCurrentConfig() {
  return Localstorage().getJSON(StorageKey.CURRENT_CONFIG) ??
      {"site": 'us', "language": 'en', "currency": 'usd', "isDefault": true};
}

String getToken() {
  String token = Localstorage().getString(StorageKey.TOKEN);
  return token;
}

String getUserInfo() {
  return Localstorage().getString(StorageKey.USER_INFO);
}

String getEid() {
  return Localstorage().getString(StorageKey.EID);
}
