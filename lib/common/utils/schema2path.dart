/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-04 18:51:48
 */
import 'dart:convert';

import 'package:homary/common/utils/utils.dart';
import 'package:homary/router/routes.dart';

void handleSchema(context, String link, {String appBarTitle}) {
  String targetUrl = link.replaceFirst(
    'homary://',
    '/',
  );
  if (targetUrl == '/') {
    targetUrl = '/index';
  }
  if (targetUrl.startsWith('/?')) {
    targetUrl = "/index?" + targetUrl.substring(2);
  }
  Map<String, String> paramsMap = {};
  Uri _paramsUri = Uri.parse(targetUrl);
  String url = targetUrl.split('?')[0];
  Map<String, String> schemaParams = _paramsUri.queryParameters;
  paramsMap.addAll(schemaParams);
  if (appBarTitle != null) {
    paramsMap.addAll({"appBarTitle": appBarTitle});
  }

  Map contentMap = jsonDecode(paramsMap['content']);
  String contentUrl = contentMap['url'];
  if(contentUrl != null){
    if(contentUrl.contains('/category/')){
      url = Routes.category;
      paramsMap['categoryId'] = getIdFromUrl(contentUrl);
    } else if (contentUrl.contains('/channel/')){
      url = Routes.channel;
      paramsMap['type'] = getIdFromUrl(contentUrl);
    } else if (contentUrl.contains('/act/')){
      url = Routes.act;
      paramsMap['activityId'] = getIdFromUrl(contentUrl);
    }
  }

  if (targetUrl != null) {
    // do something before page push
    Routes.push(context, url, params: paramsMap);
  }
}

Map<String, dynamic> getSchemaParams(String link) {
  String targetUrl = link.replaceFirst(
    'homary://',
    '/',
  );
  Uri _paramsUri = Uri.parse(targetUrl);
  String url = targetUrl.split('?')[0];
  Map<String, String> schemaParams = _paramsUri.queryParameters;
  if (targetUrl != null) {
    return {'url': url, 'params': schemaParams};
  }
  return {'url': "", 'params': {}};
}
