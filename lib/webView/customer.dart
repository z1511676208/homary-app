/*
 * @Author       : JHao
 * @Date         : 2021-07-06 13:52:46
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-19 14:17:19
 */
import 'package:flutter/material.dart';
// import 'package:flutter_demo/common/storage/cookie.dart';
// import 'package:flutter_demo/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/main.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/utils/bus.dart';
// import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/storage/webview-cookie.dart';

class CustomerServiceWebview extends StatefulWidget {
  CustomerServiceWebview({Key key}) : super(key: key);

  @override
  _CustomerServiceWebviewState createState() => _CustomerServiceWebviewState();
}

class _CustomerServiceWebviewState extends State<CustomerServiceWebview> {
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        applePayAPIEnabled: true,
        allowsInlineMediaPlayback: true,
      ));
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
      initialUrlRequest: URLRequest(url: Uri.parse(url)),
      onWebViewCreated: (InAppWebViewController controller) {
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
          (InAppWebViewController controller, Uri url, bool androidIsReload) {},
    ));
  }
}
