/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 11:04:58
 */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:homary/pages/index/main.dart';
import 'package:homary/pages/reviewDetail/main.dart';
import 'package:homary/pages/scroll-list/main.dart';
import 'package:homary/pages/signIn/main.dart';
import 'package:homary/pages/customer/main.dart';
import 'package:homary/pages/webview/main.dart';
import 'package:homary/pages/resetPassword/main.dart';

// 登录
Handler signInPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String redirect = params['redirectUrl']?.first ?? null;
    return SignInPage(redirect: redirect);
  },
);

// 登录
Handler indexPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return IndexPage();
  },
);
// 客服
Handler customerPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CustomerPage();
});

// 滚动列表埋点
Handler scrollListInPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ScrollListExposure();
  },
);

// webview
Handler webViewInPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String needLogin = params['needLogin']?.first ?? '0';
    String source = params['source']?.first ?? '';
    String content = params['content']?.first ?? null;
    return WebviewPage(needLogin: needLogin, source: source, content: content);
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
