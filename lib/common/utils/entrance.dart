/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : JHao
 * @LastEditTime : 2021-12-30 18:04:31
 */
import 'dart:async';
import 'package:uni_links/uni_links.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:flutter/services.dart' show PlatformException;

Future initUniLinks(context) async {
  String initialLink;
  StreamSubscription sub;
  try {
    // get initial link when app start
    initialLink = await getInitialLink();
    // print("initialLink  $initialLink");
    if (initialLink != null &&
        !initialLink.startsWith('twittersdk://') &&
        initialLink.startsWith('homary://')) {
      // push to target page
      handleSchema(context, initialLink);
    }
  } on PlatformException {
    initialLink = 'Failed to get initial link.';
  } on FormatException {
    initialLink = 'Failed to parse the initial link as Uri.';
  }
  // Attach a listener to the links stream
  sub = linkStream.listen((String link) {
    if (link == null ||
        link.startsWith('twittersdk://') ||
        !link.startsWith('homary://')) return;
    //  跳转到指定页面
    handleSchema(context, link);
  }, onError: (err) {});
  return sub;
}
