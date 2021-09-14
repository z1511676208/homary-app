/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:28:59
<<<<<<< HEAD
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-06 18:59:24
=======
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-06 15:08:42
>>>>>>> 2981602 (feat: 收藏页面)
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/event/go_home.dart';
import 'package:homary/common/utils/event_bus.dart';
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

  /// act页
  static String act = '/act';

  /// 收藏页
  static String wishlist = '/usercenter/wishlists';

  /// 设置
  static String setting = '/setting';

  /// 用户足迹
  static String viewed = '/usercenter/viewed';

  /// 用户优惠券
  static String coupons = '/usercenter/coupons';

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
    router.define(act, handler: actHandler);
    router.define(setting, handler: settingHandler);
    router.define(viewed, handler: viewedHandler);
    router.define(wishlist, handler: wishlistHandler);
    router.define(coupons, handler: couponsHandler);
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
  static Future pop({dynamic result}) async {
    /// 通过全局的 global key 获取到当前的路由 overlay 信息，就是用户当前打开的页面。然后调用返回
    BuildContext context = navigatorKey.currentState.overlay.context;
    return router.pop(context, result);
  }

  /// 进入首页
  static goHome({int pageIndex = 0, int pageTabIndex = 0}) {
    BuildContext context = navigatorKey.currentState.overlay.context;
    Navigator.of(context).popUntil((route) => route.isFirst);
    EventBus.instance.emit(GoHomeEvent(
      index: pageIndex,
      homeTabIndex: pageTabIndex,
    ));
  }

  static getCurPath() {
    return NavigateWatcher.currentPath;
  }
}
