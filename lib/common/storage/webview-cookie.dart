/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:56:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-16 17:12:54
 * webview cookie设置
 */
import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/storage/cookie.dart';

setCurrentConfigCookie() {
  String currentConfig = getCurrentConfig();
  setCookie('currentConfig', currentConfig);
}

setTokenCookie() {
  String token = getToken();
  setCookie('token', token);
}
