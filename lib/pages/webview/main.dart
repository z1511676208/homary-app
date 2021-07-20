/*
 * @Author       : JHao
 * @Date         : 2021-07-06 13:48:25
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 14:35:30
 */
import 'dart:convert';

import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/requsetUrl.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/appBar/main.dart';
import 'package:homary/components/drawer/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/utils/bus.dart';
import 'package:homary/common/storage/webview-cookie.dart';

class WebviewPage extends StatelessWidget {
  final String needLogin;
  final String source;
  final String content;
  const WebviewPage({Key key, this.needLogin, this.content, this.source})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: GlobalAppbar(),
          preferredSize: Size.fromHeight(95.h),
        ),
        drawer: GlobalDrawer(),
        body: Container(
            child: WebviewCtrl(
          needLogin: this.needLogin,
          source: this.source,
          content: this.content,
        )));
  }
}

class WebviewCtrl extends StatefulWidget {
  final String needLogin;
  final String source;
  final String content;
  WebviewCtrl({Key key, this.needLogin, this.content, this.source})
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
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        applePayAPIEnabled: true,
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
    print(url);
    super.initState();
  }

  @override
  void dispose() {
    busEvent.removeControllers('switchSite', ctrlName);
    super.dispose();
  }

  // 替换 url 目标参数
  String _formatParams() {
    String finalStringParams = "";
    String url = content['url'] ?? 'https://m.homary.com';
    Map<String, dynamic> urlData = getRealUrlNParams(url);
    Map<String, dynamic> finalParams = {};
    var currentConfig = Localstorage().getJSON('currentConfig') ?? {};
    var dynamicData = Localstorage().getJSON('dynamicData') ?? {};
    urlData['params'].forEach((key, value) {
      finalParams.addAll({key: dynamicData[key] ?? currentConfig[key] ?? ''});
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
    return '${urlData['url']}?$finalStringParams';
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
        //传值给webview
        controller.addJavaScriptHandler(
            handlerName: "goban",
            callback: (args) {
              return {"a": 1, "b": 2};
            });
        controller.addJavaScriptHandler(
            handlerName: "Get",
            callback: (args) {
              // print("webview 传过来的值 => $args");
            });
      },
      onLoadStart: (InAppWebViewController controller, Uri url) {},
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
    ));
  }
}
