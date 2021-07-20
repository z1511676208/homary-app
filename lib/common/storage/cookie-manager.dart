/*
 * @Author       : JHao
 * @Date         : 2021-07-06 16:05:52
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 15:00:10
 */
// get the CookieManager instance
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

CookieManager cookieManager = CookieManager.instance();

// set the expiration date for the cookie in milliseconds
final expiresDate =
    DateTime.now().add(Duration(days: 365)).millisecondsSinceEpoch;
final url = Uri.parse("https://m.homary.com");

setCookie(String key, dynamic value) async {
  print("======> $key   $value");
  await cookieManager.setCookie(
    url: url,
    name: key,
    value: value,
    domain: ".homary.com",
    expiresDate: expiresDate,
    isSecure: false,
  );
}

Future<List<Cookie>> getAllCookies() async {
  return await cookieManager.getCookies(url: url);
}

Future<Cookie> getCookie(String key) async {
  return await cookieManager.getCookie(url: url, name: key);
}

deleteCookie(String key) async {
  await cookieManager.deleteCookie(url: url, name: "myCookie");
}

deleteAllCookie() async {
  await cookieManager.deleteCookies(url: url);
}
