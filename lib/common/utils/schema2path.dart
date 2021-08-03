/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-04 15:09:12
 */
import 'package:homary/router/routes.dart';

void handleSchema(context, String link) {
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
  Uri _paramsUri = Uri.parse(targetUrl);
  String url = targetUrl.split('?')[0];
  Map<String, String> schemaParams = _paramsUri.queryParameters;
  if (targetUrl != null) {
    // do something before page push
    Routes.push(context, url, params: schemaParams);
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
