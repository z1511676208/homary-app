import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/bus.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/requsetUrl.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/pages/webview/controller.dart';

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

  @override
  void initState() {
    needLogin = widget.needLogin;
    source = widget.source;
    content = jsonDecode(widget.content) ?? {};
    url = _formatParams();
    super.initState();
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
      onWebViewCreated: (InAppWebViewController controller) {
        Toast.loading();
        busEvent.subWebViewCtrl('switchSite', ctrlName, () {
          setWebviewCookies();
          controller.reload();
        });
        busEvent.subWebViewCtrl('goback', ctrlName, () async {
          bool canGoBack = await controller.canGoBack();
          if (canGoBack) {
            controller.goBack();
          } else {
            Routes.pop();
          }
        });
        //传值给webview
        controller.addJavaScriptHandler(
            handlerName: "TEST",
            callback: (args) {
              return {"a": 1, "b": 2};
            });
        controller.addJavaScriptHandler(
            handlerName: "Get",
            callback: (args) {
              // print("webview 传过来的值 => $args");
            });
      },
      onLoadStart: (InAppWebViewController controller, Uri url) {
        String appBarType;
        String isShowAppBar = '1';

        if (url.path.indexOf('/item/') > -1) {
          appBarType = '3';
        } else if (url.path.indexOf('/shoppingcart') > -1) {
          appBarType = '2';
        }
        Provider.of<WebviewAppBarCtrl>(context, listen: false).setAppBarStatus(
            appBarType: appBarType, isShowAppBar: isShowAppBar);
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        // print("加载进度  ===》   $progress");
      },
      onLoadStop: (InAppWebViewController controller, Uri url) async {
        // print("onLoadStop => ");
        Toast.clear();
        // print(await controller.evaluateJavascript(
        //     source: "window.navigator.userAgent"));
      },
      onUpdateVisitedHistory:
          (InAppWebViewController controller, Uri url, bool androidIsReload) {
        // print("路由跳转 ===》$url");
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async =>
          ServerTrustAuthResponse(
              action: ServerTrustAuthResponseAction.PROCEED),
    ));
  }
}
