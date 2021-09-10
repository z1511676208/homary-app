import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/bus.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/requsetUrl.dart';
import 'package:homary/common/utils/sale_page_list.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/pages/webview/controller.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:homary/webView/web_recognizer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewCtrl extends StatefulWidget {
  final String needLogin;
  final String source;
  final Map<String, dynamic> content;
  final String showAppLoading;
  final bool isInWebviewPage;
  final bool isSalePage;
  WebviewCtrl(
      {Key key,
      this.needLogin,
      this.content,
      this.source,
      this.isInWebviewPage = true,
      this.isSalePage = false,
      this.showAppLoading = '1'})
      : super(key: key);

  @override
  _WebviewCtrlState createState() => _WebviewCtrlState();
}

class _WebviewCtrlState extends State<WebviewCtrl> {
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        transparentBackground: true,
        useShouldOverrideUrlLoading: true,
        // https://github.com/pichillilorenzo/flutter_inappwebview/pull/860
        // applicationNameForUserAgent: "Homary"
        userAgent: "Mobile,${Platform.isIOS ? 'iPhone' : 'Android'},Homary",
        resourceCustomSchemes: ['homary'],
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        // applePayAPIEnabled: true,
        allowsInlineMediaPlayback: true,
      ));
  var busEvent = BusProvider();
  var ctrlName = DateTime.now().microsecond.toString();
  final GlobalKey webViewKey = GlobalKey();
  // 路由参数
  String needLogin = '0';
  String source = '';
  Map<String, dynamic> content;
  String url;
  bool isInitUrl = true; //记录当前是否是第一次进来的URL,用于shouldOverrideUrlLoading拦截判断

  InAppWebViewController controller;

  RefreshController refreshController = RefreshController();
  WebViewVerticalGestureRecognizer verticalRecognizer =
      WebViewVerticalGestureRecognizer();

  void changeHeadStatus(Uri url) {
    bool showMore = false;
    bool showCollect = true;
    bool showCart = true;
    bool isShowAppBar = true;
    bool showBorder = true;
    String appBarTitle = '';
    if (url.path.contains('/item')) {
      showMore = true;
    } else if (url.path.contains('/place') ||
        url.path.contains('/payfail') ||
        url.path.contains('/paysuccess') ||
        url.path.contains('/customerService')) {
      isShowAppBar = false;
    } else if (url.path.contains('/shoppingcart')) {
      showCart = false;
      appBarTitle = '';
    } else if (url.path.contains('/usercenter') ||
        url.path.contains('/help-center') ||
        url.path.contains('/address')) {
      showCollect = false;
      showCart = false;
    }
    Provider.of<WebviewAppBarCtrl>(context, listen: false).setAppBarStatus(
        showMore: showMore,
        showCart: showCart,
        showBorder: showBorder,
        showCollect: showCollect,
        isShowAppBar: isShowAppBar,
        appBarTitle: appBarTitle);
  }

  void changeAppBarTitle(String title) {
    Provider.of<WebviewAppBarCtrl>(context, listen: false)
        .setAppBarStatus(appBarTitle: title);
  }

  void goback(controller) async {
    bool canGoBack = await controller?.canGoBack();
    if (canGoBack) {
      controller.goBack();
    } else {
      Routes.pop();
    }
  }

  @override
  void initState() {
    needLogin = widget.needLogin;
    source = widget.source;
    content = widget.content;
    url = _formatParams();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    busEvent.removeControllers('switchSite', ctrlName);
    busEvent.removeControllers('goback', ctrlName);
    Toast.clear();
    super.dispose();
  }

  // 替换 url 目标参数
  String _formatParams() {
    String finalStringParams = "";
    String url = Uri.decodeComponent(content['url']) ?? 'https://m.homary.com';
    Map<String, dynamic> urlData = getRealUrlNParams(url);
    Map<String, dynamic> finalParams = {};
    var currentConfig = Localstorage().getJSON(StorageKey.CURRENT_CONFIG) ?? {};
    var dynamicData = Localstorage().getJSON(StorageKey.DYNAMIC_DATA) ?? {};
    urlData['params'].forEach((key, value) {
      finalParams
          .addAll({key: dynamicData[key] ?? currentConfig[key] ?? value ?? ''});
    });
    for (int i = 0; i < finalParams.keys.toList().length; i++) {
      if (i != finalParams.keys.length - 1) {
        finalStringParams +=
            "${finalParams.keys.toList()[i]}=${finalParams.values.toList()[i]}&";
      } else {
        finalStringParams +=
            "${finalParams.keys.toList()[i]}=${finalParams.values.toList()[i]}";
      }
    }
    return finalStringParams == ""
        ? urlData['url']
        : '${urlData['url']}?$finalStringParams';
  }

  _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : Toast.error('Could not launch $_url');

  @override
  Widget build(BuildContext context) {
    return PullToRefresh(
      controller: refreshController,
      enablePullUp: false,
      onRefresh: () async {
        isInitUrl = true;
        controller?.reload();
      },
      child: InAppWebView(
        gestureRecognizers: Set()
          ..add(
              Factory<VerticalDragGestureRecognizer>(() => verticalRecognizer))
          ..add(Factory<HorizontalDragGestureRecognizer>(
              () => HorizontalDragGestureRecognizer())),
        initialOptions: options,
        key: webViewKey,
        // initialFile: "assets/webview.html",
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        onScrollChanged: (InAppWebViewController controller, int x, int y) {
          if (y == 0) {
            verticalRecognizer.isAtTop = true;
          } else {
            verticalRecognizer.isAtTop = false;
          }
        },
        onWebViewCreated: (InAppWebViewController controller) async {
          this.controller = controller;

          if (widget.showAppLoading == '1') {
            Toast.loading();
          }
          setPlatform(); // 设置公参 pf 到 webview cookie
          // 切换站点 语言 币种时，刷新webview
          busEvent.subWebViewCtrl('switchSite', ctrlName, () {
            setWebviewCookies();
            isInitUrl = true;
            if (widget.isSalePage) {
              String link = getSalePageLink();
              controller.loadUrl(
                urlRequest: URLRequest(url: Uri.parse(link)),
              );
            } else {
              controller.reload();
            }
          });
          // webview header 返回按钮
          busEvent.subWebViewCtrl('goback', ctrlName, () async {
            goback(controller);
          });
          // webview 与 App 通信
          controller.addJavaScriptHandler(
              handlerName: "webviewGoBack",
              callback: (args) {
                goback(controller);
              });
          controller.addJavaScriptHandler(
              handlerName: "AppBarTitle",
              callback: (args) {
                changeAppBarTitle(args[0]);
              });
          controller.addJavaScriptHandler(
              handlerName: "AppJumpToSeach",
              callback: (args) {
                Routes.push(context, '/search');
              });
          controller.addJavaScriptHandler(
              handlerName: "AppJumpUrl",
              callback: (args) async {
                String url = args[0];
                String path = url.split('?')[0];
                Uri _paramsUri = Uri.parse(url);
                Map<String, String> params = _paramsUri.queryParameters;
                if (url != null && path != '/index') {
                  final result =
                      await Routes.push(context, path, params: params);
                  if (result ?? false) {
                    isInitUrl = true;
                    controller?.reload();
                  }
                } else if (path == '/index') {
                  Routes.goHome();
                }
              });

          controller.addJavaScriptHandler(
              handlerName: 'AppPaypal',
              callback: (args) async {
                var jsonData = json.decode(args[0]);
                final request = BraintreePayPalRequest(
                    currencyCode: jsonData['currency'],
                    amount: jsonData['amount'].toString());
                // Toast.loading();
                BraintreePaymentMethodNonce result =
                    await Braintree.requestPaypalNonce(
                  jsonData['token'],
                  request,
                );
                // Toast.clear();
                if (result != null) {
                  print(result.nonce);
                  return result.nonce;
                }
              });
          // 首页分类webview 隐藏搜索框
          if (!widget.isInWebviewPage) {
            controller.addJavaScriptHandler(
                handlerName: "hideSearchBar",
                callback: (args) {
                  return true;
                });
          }
          // pdf 跳转
          controller.addJavaScriptHandler(
              handlerName: "AppPdfViewer",
              callback: (args) {
                print(' ----  ${args[0]}');
                _launchURL(args[0]);
              });
          //更新App购物车显示数量
          controller.addJavaScriptHandler(
              handlerName: "AppUpdateShopCartNumber",
              callback: (args) {
                Provider.of<GlobalConfig>(context, listen: false)
                    .getShoppingCartNumber();
              });

          //跳转到登录页
          controller.addJavaScriptHandler(
              handlerName: "AppGuestLogin",
              callback: (args) {
                setToken(args[0]);
                Localstorage().setBool(StorageKey.IS_LOGIN, true);
                args[1]['token'] = null;
                setUserInfo(args[1]);
                setWebviewCookies();
              });
          //更新App购物车显示数量
          controller.addJavaScriptHandler(
              handlerName: "AppUpdateShopCartNumber",
              callback: (args) {
                Provider.of<GlobalConfig>(context, listen: false)
                    .getShoppingCartNumber();
              });
          // M站GTM上报
          controller.addJavaScriptHandler(
              handlerName: "AppSendGTMData",
              callback: (args) {
                sendGTMData(args[0]);
              });

          controller.addJavaScriptHandler(
              handlerName: "scollerInPopup",
              callback: (args) {
                verticalRecognizer.isAtTop = false;
              });
        },
        onLoadStart: (InAppWebViewController controller, Uri url) {
          if (hostList.contains(url.origin)) {
            // 安卓首次进入不掉用shouldOverrideUrlLoading 在此处将 isInitUrl 设为false
            isInitUrl = false;
          }
          changeHeadStatus(url);
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          if (progress > 80) {
            Toast.clear();
            refreshController.refreshCompleted();
          }
        },
        onLoadStop: (InAppWebViewController controller, Uri url) async {
          refreshController.refreshCompleted();
          // 处理某些机型点击获取focus时出现边框
          controller.injectCSSCode(source: '''
          *:focus {
              -webkit-focus-ring-color: rgba(0, 0, 0, 1)!important;
              outline: none!important;
          }
        ''');
          if (!widget.isInWebviewPage) {
            controller.injectCSSCode(source: '''
          body,html{
            background:#ffffff;
          }
        ''');
          }
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          Uri url = navigationAction.request.url;

          if (url.scheme == 'homary') {
            handleSchema(context, url.toString());
            return NavigationActionPolicy.CANCEL;
          } else if (url.toString().contains('my.yotpo.com')) {
            _launchURL(url.toString());
            return NavigationActionPolicy.CANCEL;
          } else if (!widget.isInWebviewPage &&
              !isInitUrl &&
              (url.toString().contains('.homary.com/'))) {
            Routes.push(context, '/webview',
                params: {"content": '{"url":"${url.toString()}"}'});
            return NavigationActionPolicy.CANCEL;
          }
          if (hostList.contains(url.origin)) {
            // 安卓首次进入不掉用shouldOverrideUrlLoading 在此处将 isInitUrl 设为false
            // 排除PC站链接重定向
            isInitUrl = false;
          }

          return NavigationActionPolicy.ALLOW;
        },
        onUpdateVisitedHistory:
            (InAppWebViewController controller, Uri url, bool androidIsReload) {
          changeHeadStatus(url);
        },
        onLoadError: (context, url, i, e) {
          // print('error====> $i   $e');
          refreshController.refreshCompleted();
        },

        onReceivedServerTrustAuthRequest: (controller, challenge) async =>
            ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED),
      ),
    );
  }
}
