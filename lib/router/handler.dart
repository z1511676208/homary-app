/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-06 14:17:16
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:homary/pages/categoryTab/main.dart';
import 'package:homary/pages/channelTab/main.dart';
import 'package:homary/pages/index/main.dart';
import 'package:homary/pages/reviewDetail/main.dart';
import 'package:homary/pages/signIn/main.dart';
import 'package:homary/pages/webview/main.dart';
import 'package:homary/pages/resetPassword/main.dart';
import 'package:homary/pages/search/main.dart';

Map<String, dynamic> _getContent(dynamic content) {
  String contentString = content ?? '{}';
  return jsonDecode(contentString);
}

// 登录
Handler signInPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String redirect = params['redirectUrl']?.first ?? null;
    return SignInPage(redirect: redirect);
  },
);

// 首页
Handler homePageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String pageIndex = params['pageIndex']?.first ?? '0';
    return IndexPage(
      pageIndex: pageIndex,
    );
  },
);

// webview
Handler webViewInPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String needLogin = params['needLogin']?.first ?? '0';
    String source = params['source']?.first ?? '';
    String appBarTitle = params['appBarTitle']?.first ?? '';
    String showAppLoading = params['showAppLoading']?.first ?? '1';
    return WebviewPage(
        needLogin: needLogin,
        source: source,
        content: _getContent(params['content']?.first),
        appBarTitle: appBarTitle,
        showAppLoading: showAppLoading);
  },
);

// resePassword
Handler resetPasswordPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ResetPassword();
  },
);
// reviewDetail
Handler reviewDetailPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String index = params['index']?.first ?? 0;
    return ReviewsDetail(index: index);
  },
);
Handler searchPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Search();
  },
);

Handler categoryHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return CategoryTab(
      isPage: true,
      categoryId: params['categoryId']?.first,
      appBarTitle: params['appBarTitle']?.first ?? '',
    );
  },
);

Handler channelHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ChannelTab(
      isPage: true,
      channelId: params['channelId']?.first,
      appBarTitle: params['appBarTitle']?.first ?? '',
      type: params['type']?.first ?? '1',
    );
  },
);