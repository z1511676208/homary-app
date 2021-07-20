/*
 * @Author       : JHao
 * @Date         : 2021-07-06 13:52:46
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 10:45:34
 */
import 'package:flutter/material.dart';
// import 'package:flutter_demo/common/storage/cookie.dart';
// import 'package:flutter_demo/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/main.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/utils/bus.dart';
// import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/storage/webview-cookie.dart';

class WebviewCtrl extends StatefulWidget {
  WebviewCtrl({Key key}) : super(key: key);

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
  // bool _flag = true; // 在 Android 上，shouldOverrideUrlLoading不会在第一页加载时调用,但IOS会，因此需要处理第一页时不掉用CANCEL

  // InAppWebViewController _controller;
  // @override
  // void initState() {
  //   super.initState();

  // }
  var _flag = false;

  var busEvent = BusProvider();

  var ctrlName = DateTime.now().microsecond.toString();

  var url = 'https://mpre-m.homary.com/';

  final GlobalKey webViewKey = GlobalKey();

  @override
  void dispose() {
    busEvent.removeControllers('switchSite', ctrlName);
    super.dispose();
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
        // _controller = controller;
        // value.addContorller(controller);
        busEvent.subWebViewCtrl('switchSite', ctrlName, () {
          setWebviewCookies();
          controller.reload();
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
      onLoadStart: (InAppWebViewController controller, Uri url) {},
      onProgressChanged: (InAppWebViewController controller, int progress) {
        // print("加载进度  ===》   $progress");
      },
      onLoadStop: (InAppWebViewController controller, Uri url) async {
        this.setState(() {
          _flag = true;
        });
        // print("onLoadStop => ");
        print(await controller.evaluateJavascript(
            source: "window.navigator.userAgent"));
      },
      onConsoleMessage:
          (InAppWebViewController controller, ConsoleMessage consoleMessage) {
        print("console  ===>   $consoleMessage");
      },
      onUpdateVisitedHistory:
          (InAppWebViewController controller, Uri url, bool androidIsReload) {
        // print("路由跳转 ===》$url");
        // print('===falldfe------ $_flag');
        // controller.goBack();
      },
      // shouldOverrideUrlLoading: (InAppWebViewController controller,
      //     NavigationAction navigationAction) async {
      //   // print(
      //   //     'avigationAction.request.url ----- ${navigationAction.request.url == Uri.parse(url)}');
      //   // print('Uri.parse(url)---- ${Uri.parse(url)}');
      //   print(
      //       'navigationAction.request.url---- ${navigationAction.request.url}');
      //   // print(
      //   //     'navigationAction.request.url---- ${navigationAction.request.url != Uri.parse("about:blank")}');
      //   if (navigationAction.request.url != Uri.parse(url) &&
      //       navigationAction.request.url != Uri.parse('about:blank')) {
      //     print('run ing hre');
      //     return NavigationActionPolicy.CANCEL;
      //   }
      //   return NavigationActionPolicy.ALLOW;
      // },
    ));
  }
}
