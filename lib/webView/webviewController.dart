import 'dart:convert';
import 'dart:io';

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
  final String content;
  final String showAppLoading;
  WebviewCtrl(
      {Key key,
      this.needLogin,
      this.content,
      this.source,
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
  dynamic content;
  String url;

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

  @override
  void initState() {
    needLogin = widget.needLogin;
    source = widget.source;
    content = jsonDecode(widget.content) ?? {};
    url = _formatParams();
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
      initialOptions: options,
      key: webViewKey,
      // initialFile: "assets/webview.html",
      initialUrlRequest: URLRequest(url: Uri.parse(url)),
      onWebViewCreated: (InAppWebViewController controller) async {
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
          bool canGoBack = await controller?.canGoBack();
          print('canGoBack=====>$canGoBack');
          if (canGoBack) {
            controller.goBack();
          } else {
            Routes.pop();
          }
        });
        // webview 与 App 通信
        controller.addJavaScriptHandler(
            handlerName: "webviewGoBack",
            callback: (args) {
              controller.goBack();
            });
        controller.addJavaScriptHandler(
            handlerName: "AppGoBack",
            callback: (args) {
              Routes.pop();
            });
        controller.addJavaScriptHandler(
            handlerName: "AppJumpUrl",
            callback: (args) {
              String url = args[0];
              if (url != null) {
                Routes.push(context, url);
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
              final result = await Braintree.requestPaypalNonce(
                jsonData['token'],
                request,
              );
              // Toast.clear();
              if (result != null) {
                print(result.nonce);
                return result.nonce;
              }
            });
      },
      onLoadStart: (InAppWebViewController controller, Uri url) {
        changeHeadStatus(url);
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        if (progress > 80) {
          Toast.clear();
        }
      },
      onLoadStop: (InAppWebViewController controller, Uri url) async {},
      onLoadResourceCustomScheme: (InAppWebViewController controller, Uri url) {
        // 拦截webview 跳转 homary协议地址
        // print("onLoadResourceCustomScheme $url");
        if (url.scheme == 'homary') {
          var params = getSchemaParams(url.toString());
          var content = jsonDecode(params['params']['content']);
          var link = Uri.decodeComponent(content['url']);
          controller.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(link)),
          );
          return null;
        }
        return null;
      },
      onUpdateVisitedHistory:
          (InAppWebViewController controller, Uri url, bool androidIsReload) {
        print("路由跳转 ===》$url");
        changeHeadStatus(url);
      },
      onLoadError: (context, url, i, e) {
        print('error====> $i   $e');
      },

      onReceivedServerTrustAuthRequest: (controller, challenge) async =>
          ServerTrustAuthResponse(
              action: ServerTrustAuthResponseAction.PROCEED),
    ));
  }
}
