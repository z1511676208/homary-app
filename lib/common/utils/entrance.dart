/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-19 16:35:22
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
    print("initialLink  $initialLink");
    if (initialLink != null) {
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
    print('link $link');
    if (link == null) return;
    //  跳转到指定页面
    handleSchema(context, link);
  }, onError: (err) {});
  return sub;
}
