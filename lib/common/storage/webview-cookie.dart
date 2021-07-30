/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:56:41
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 15:16:53
 * webview cookie设置
 */
import 'dart:convert';

import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/storage/cookie.dart';

setWebviewCookies() {
  setCurrentConfigCookie();
  setTokenCookie();
  setEidCookie();
}

// 站点信息
setCurrentConfigCookie() {
  String currentConfig = jsonEncode(getCurrentConfig());
  setCookie('currentConfig', currentConfig);
}

// token
setTokenCookie() {
  String token = getToken();
  print('token====>$token');
  setCookie('token', token);
}

// EID
setEidCookie() {
  String eid = getEid();
  setCookie('EID', eid);
}
