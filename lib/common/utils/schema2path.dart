/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-19 10:52:36
 */
import 'package:homary/router/routes.dart';

void handleSchema(context, String link) {
  String targetUrl = link.replaceFirst(
    'homary://',
    '/',
  );
  Uri _paramsUri = Uri.parse(targetUrl);
  Map<String, String> schemaParams = _paramsUri.queryParameters;
  if (targetUrl != null) {
    // do something before page push
    Routes.push(context, targetUrl, params: schemaParams);
  }
}
