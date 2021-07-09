import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:homary/common/utils/main.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:io';

class ProductWebview extends StatefulWidget {
  ProductWebview({Key key}) : super(key: key);

  @override
  _ProductWebviewState createState() => _ProductWebviewState();
}

class _ProductWebviewState extends State<ProductWebview> {
  double _viewsHeight = 100.0.h;
  WebViewController _webViewController;
  String ua;

  _getWebViewHeight() async {
    await _webViewController.evaluateJavascript('''
      try {
        let scrollHeight = document.documentElement.scrollHeight;
        if (scrollHeight) {
          /// 如果在 onPageFinished 中调用执行结果，需要将 postMessage wrap 成异步； 
          setTimeout(() => car.postMessage(scrollHeight), 0)
        }
      } catch {}
    ''');
  }

  // 注册js回调
  JavascriptChannel _invokeJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'op',
        onMessageReceived: (JavascriptMessage message) {
          print('papgeg --- ${message.message}');
          // var webViewHeight = double.parse(message.message);
          // if (webViewHeight != null) {
          //   setState(() {
          //     _viewsHeight = webViewHeight;
          //   });
          // }
        });
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/webview.html');
    _webViewController.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _viewsHeight,
      child: WebView(
          initialUrl: '',

          /// 描述webview中 js 是否可用
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            _loadHtmlFromAssets();
          },
          javascriptChannels: <JavascriptChannel>[
            _invokeJavascriptChannel(context),
          ].toSet(),
          onPageFinished: (String url) async {
            await _getWebViewHeight();
          },
          userAgent: _viewsHeight.toString()),
    );
  }
}
