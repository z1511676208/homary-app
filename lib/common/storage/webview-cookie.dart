/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:56:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-04 14:39:52
 * webview cookie设置
 */
import 'dart:convert';
import 'dart:io';

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

setPlatform() {
  setCookie('homary_app_pf', Platform.isIOS ? 'ios' : 'android');
}
