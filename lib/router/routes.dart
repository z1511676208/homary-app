/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:28:59
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-16 16:08:47
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:homary/router/handler.dart';
import 'package:homary/main.dart';
import 'package:homary/common/utils/navigateWatcher.dart';

/// 路由
class Routes {
  static FluroRouter router;

  /// 首页
  static String home = '/';
  static String index = '/index';

  /// 注册页
  static String signIn = '/signIn';

  /// webview
  static String webView = '/webview';

  /// 重置密码
  static String resetPassword = '/resetPassword';

  /// 评论详情
  static String reviewDetail = '/reviewDetail';

  /// 搜索页
  static String search = '/search';

  /// 商品类目页
  static String category = '/category';

  /// channel页
  static String channel = '/channel';

  /// pdf viewer
  static String pdfViewer = '/pdf';

  /// act页
  static String act = '/act';

  // 配置route
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print('page not found!');
      return;
    });

    router.define(index, handler: homePageHandler);
    router.define(signIn, handler: signInPageHandler);
    router.define(webView, handler: webViewInPageHandler); // webview
    router.define(resetPassword, handler: resetPasswordPageHandler);
    router.define(reviewDetail, handler: reviewDetailPageHandler);
    router.define(search, handler: searchPageHandler);
    router.define(category, handler: categoryHandler);
    router.define(channel, handler: channelHandler);
    router.define(pdfViewer, handler: pdfViewerHandler);
    router.define(act, handler: actHandler);
  }

  static String formatQueryParams(Map<String, dynamic> params) {
    int idx = 0;
    String queryStr = '';
    for (var key in params.keys) {
      var value = Uri.encodeComponent(params[key].toString());
      if (idx == 0) {
        queryStr = "?";
      } else {
        queryStr += "\&";
      }
      queryStr += "$key=$value";
      idx++;
    }
    return queryStr;
  }

  /// 跳转 方法
  /// path: 路由地址
  /// params: 参数
  /// transition: 转场动画
  /// replace: 代换
  static Future push(BuildContext context, String path,
      {Map<String, dynamic> params,
      TransitionType transition = TransitionType.cupertino,
      bool replace = false,
      bool clearStack = false}) {
    String queryStr = "";
    // 拼接 query 参数
    if (params != null) {
      queryStr = formatQueryParams(params);
    }
    path = path + queryStr;
    return router.navigateTo(context, path,
        transition: transition, replace: replace, clearStack: clearStack);
  }

  // 替换路由
  static Future replace(BuildContext context, String path,
      {Map<String, dynamic> params,
      TransitionType transition = TransitionType.fadeIn,
      bool replace = true,
      bool clearStack = false}) {
    String queryStr = "";
    // 拼接 query 参数
    if (params != null) {
      queryStr = formatQueryParams(params);
    }
    path = path + queryStr;
    return router.navigateTo(context, path,
        transition: transition, replace: replace, clearStack: clearStack);
  }

  /// 返回方法
  static pop() {
    /// 通过全局的 global key 获取到当前的路由 overlay 信息，就是用户当前打开的页面。然后调用返回
    BuildContext context = navigatorKey.currentState.overlay.context;
    router.pop(context);
  }

  /// 进入首页
  static goHome(
      {bool replace = true, int pageIndex = 0, Map<String, dynamic> params}) {
    String queryStr = "";
    if (params == null) {
      params = {};
    }
    params.addAll({"pageIndex": pageIndex});
    queryStr = formatQueryParams({
      ...params,
    });
    BuildContext context = navigatorKey.currentState.overlay.context;
    router.navigateTo(context, "/index" + queryStr,
        replace: replace, transition: TransitionType.fadeIn);
  }

  static getCurPath() {
    return NavigateWatcher.currentPath;
  }
}
