/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:28:39
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-06 10:29:52
 */
import 'package:homary/common/utils/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomerServiceWebview extends StatefulWidget {
  @override
  _CustomerServiceWebviewState createState() => _CustomerServiceWebviewState();
}

class _CustomerServiceWebviewState extends State<CustomerServiceWebview> {
  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'MyApp',
        onMessageReceived: (JavascriptMessage message) {
          //js 收到了Flutter发送的消息
          Navigator.pop(context);
          print(message.message);
        });
  }

  Widget build(BuildContext context) {
    return Container(
      child: WebView(
          initialUrl: 'http://localhost:3001/customerService',
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: [_alertJavascriptChannel(context)].toSet()),
    );
  }
}
