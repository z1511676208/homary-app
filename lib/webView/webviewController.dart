import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/bus.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/requsetUrl.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/pages/webview/controller.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class WebviewCtrl extends StatefulWidget {
  final String needLogin;
  final String source;
  final Map<String, dynamic> content;
  final String showAppLoading;
  final bool isInWebviewPage;
  final bool isPDF;
  WebviewCtrl(
      {Key key,
      this.needLogin,
      this.content,
      this.source,
      this.isInWebviewPage = true,
      this.isPDF = false,
      this.showAppLoading = '1'})
      : super(key: key);

  @override
  _WebviewCtrlState createState() => _WebviewCtrlState();
}

class _WebviewCtrlState extends State<WebviewCtrl> {
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
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

  InAppWebViewController controller;
  PullToRefreshController pullToRefreshController;

  void changeHeadStatus(Uri url) {
    bool showMore = false;
    bool showCollect = true;
    bool showCart = true;
    bool isShowAppBar = true;
    String appBarTitle = '';
    if (url.path.contains('/item')) {
      showMore = true;
    } else if (url.path.contains('/place') ||
        url.path.contains('/payfail') ||
        url.path.contains('/paysuccess') ||
        url.path.contains('/AppCustomerService') ||
        url.path.contains('/wishlists')) {
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
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: AppColor.primaryColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          controller?.reload();
        } else if (Platform.isIOS) {
          controller?.loadUrl(
              urlRequest: URLRequest(url: await controller?.getUrl()));
        }
      },
    );
    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<GlobalConfig>(context, listen: false).setIsWebviewPage(false);
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
    var currentConfig = Localstorage().getJSON('currentConfig') ?? {};
    var dynamicData = Localstorage().getJSON('dynamicData') ?? {};
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InAppWebView(
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),
      pullToRefreshController: pullToRefreshController,
      initialOptions: options,
      key: webViewKey,
      // initialFile: "assets/webview.html",
      initialUrlRequest: URLRequest(url: Uri.parse(url)),
      onWebViewCreated: (InAppWebViewController controller) async {
        this.controller = controller;
        Provider.of<GlobalConfig>(context, listen: false)
            .setIsWebviewPage(true);
        if (widget.showAppLoading == '1') {
          Toast.loading();
        }
        setPlatform(); // 设置公参 pf 到 webview cookie
        // 切换站点 语言 币种时，刷新webview
        busEvent.subWebViewCtrl('switchSite', ctrlName, () {
          setWebviewCookies();
          controller.reload();
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
            callback: (args) {
              String url = args[0];
              Map<String, dynamic> params = {};
              if (url.contains('?')) {
                int index = url.indexOf('?');
                String query = url.substring(index + 1);
                url = url.substring(0, index);
                List arr = query.split('?');
                String queryPath = arr[0];
                String queryParams = arr[1];
                List queryUrl = queryPath.split('=');
                params.addAll({
                  queryUrl[0]:
                      '${queryUrl[1]}?${Uri.encodeComponent(queryParams)}'
                });
                print(query);
              }
              if (url != null) {
                if (url.contains('/index')) {
                  Routes.replace(context, url, params: params);
                } else {
                  Routes.push(context, url, params: params);
                }
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
      },
      onLoadStart: (InAppWebViewController controller, Uri url) {
        changeHeadStatus(url);
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        if (progress > 80) {
          Toast.clear();
          pullToRefreshController.endRefreshing();
        }
      },
      onLoadStop: (InAppWebViewController controller, Uri url) async {
        pullToRefreshController.endRefreshing();
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var url = navigationAction.request.url;
        if (url.scheme == 'homary') {
          //   // print("进来  ${widget.isInWebviewPage}");
          //   var params = getSchemaParams(url.toString());
          //   var content = jsonDecode(params['params']['content']);
          //   if (widget.isInWebviewPage) {
          //     // 如果在 原生webview路由下 则在当前webviewCtrl跳转，否则打开新的/webview路由
          //     var link = Uri.decodeComponent(content['url']);
          //     controller.loadUrl(
          //       urlRequest: URLRequest(url: Uri.parse(link)),
          //     );
          //     return NavigationActionPolicy.CANCEL;
          //   } else {
          //     handleSchema(context, url.toString());
          //     return NavigationActionPolicy.CANCEL;
          //   }
          // bugfix: 为了解决屏幕右滑 webview不能返回上一页的问题
          handleSchema(context, url.toString());
          return NavigationActionPolicy.CANCEL;
        } else if (url.toString().contains('.pdf') && !widget.isPDF) {
          Routes.push(context, '/pdf', params: {"link": url.toString()});
          return NavigationActionPolicy.CANCEL;
        }
        return NavigationActionPolicy.ALLOW;
      },
      onUpdateVisitedHistory:
          (InAppWebViewController controller, Uri url, bool androidIsReload) {
        print("路由跳转 ===》$url");
        changeHeadStatus(url);
      },
      onLoadError: (context, url, i, e) {
        print('error====> $i   $e');
        pullToRefreshController.endRefreshing();
      },

      onReceivedServerTrustAuthRequest: (controller, challenge) async =>
          ServerTrustAuthResponse(
              action: ServerTrustAuthResponseAction.PROCEED),
    ));
  }
}
