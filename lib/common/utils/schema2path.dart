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
