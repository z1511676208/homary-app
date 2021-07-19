/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:56:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-19 13:43:17
 * webview cookie设置
 */
import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/storage/cookie.dart';

setWebviewCookies() {
  setCurrentConfigCookie();
  setTokenCookie();
  setEidCookie();
}

// 站点信息
setCurrentConfigCookie() {
  String currentConfig = getCurrentConfig();
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
