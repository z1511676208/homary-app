/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:31:45
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 11:43:52
 */
import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/config/storage.dart';

/// 获取请求url
String getRequsetUrl(String target) {
  String targetUrl;
  var storage = Localstorage().getJSON(REQUEST_URL);
  // 如果本地存储没有请求列表，使用固定的请求列表
  if (storage != null && storage[target] != null)
    targetUrl = storage[target];
  else
    targetUrl = baseRequestUrl[target];
  return targetUrl;
}

/// 格式化请求url
Map<String, dynamic> getRealUrlNParams(String u) {
  u = u.replaceAll('=#', '=');
  Uri uri = Uri.parse(u);
  String url = u.split('?')[0];
  Map<String, String> params = uri.queryParameters;
  return {"url": url, "params": params};
}
