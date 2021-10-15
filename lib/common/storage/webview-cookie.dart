/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:56:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 19:52:14
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
  print(currentConfig);
  setCookie('currentConfig', currentConfig);
}

// token
setTokenCookie() {
  String token = getToken();
  if (token == '' || token == null) {
    try {
      // 不存在cookie时进行delete会发生错误，所以此处用try-catch包围
      deleteCookie('token');
    } catch (e) {
      print(e.toString());
    }
  } else {
    setCookie('token', token);
  }
}

// EID
setEidCookie() {
  String eid = getEid();
  setCookie('EID', eid);
}

setPlatform() {
  setCookie('homary_app_pf', Platform.isIOS ? 'ios' : 'android');
}

setGuest(String isGuest) {
  setCookie('isGuest', isGuest);
}
