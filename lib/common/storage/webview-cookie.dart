/*
 * @Author       : JHao
 * @Date         : 2021-07-05 14:56:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-08 11:32:45
 * webview cookie设置
 */
import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:webview_flutter/webview_flutter.dart';

setWebviewCurrentConfig(WebViewController controller) {
  String currentConfig = getCurrentConfig();
  String cookie = '''
          var config = JSON.stringify($currentConfig);
          document.cookie = 'currentConfig=' + config + ';domain=.homary.com;';
       ''';
  controller?.evaluateJavascript(cookie);
}

setWebviewToken(WebViewController controller) {
  String token = getToken();
  String cookie = '''
          document.cookie = 'token=$token;domain=.homary.com;';
       ''';
  controller?.evaluateJavascript(cookie);
}

setCurrentConfigCookie() {
  String currentConfig = getCurrentConfig();
  setCookie('currentConfig', currentConfig);
}

setTokenCookie() {
  String token = getToken();
  setCookie('token', token);
}
