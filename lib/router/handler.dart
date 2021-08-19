/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-19 18:44:27
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
    String redirect = params['redirect_url']?.first ?? null;
    String showGuestBtn = params['showGuestBtn']?.first ?? null;
    String pageFrom = params['page_from']?.first ?? null;
    String adp = params['adp']?.first ?? '';
    return SignInPage(
        redirect: redirect,
        showGuestBtn:
            showGuestBtn != null && showGuestBtn == 'true' ? true : false,
        pageFrom: pageFrom,
        adp: adp);
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
      type: params['type']?.first,
    );
  },
);

Handler actHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ChannelTab(
      isPage: true,
      channelId: params['channelId']?.first,
      appBarTitle: params['appBarTitle']?.first ?? '',
      activityId: params['activityId']?.first,
    );
  },
);
