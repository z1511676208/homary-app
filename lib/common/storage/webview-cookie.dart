/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:56:41
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 16:35:14
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
  setCookie('token', token);
}

// EID
setEidCookie() {
  String eid = getEid();
  setCookie('EID', eid);
}
