/*
 * @Author       : JHao
 * @Date         : 2021-07-06 13:48:25
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-08 11:44:20
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/appBar/main.dart';
import 'package:homary/components/drawer/main.dart';
import 'package:homary/webView/webview.dart';

// 列表页页面
class WebviewPage extends StatelessWidget {
  const WebviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: GlobalAppbar(),
          preferredSize: Size.fromHeight(95.h),
        ),
        drawer: GlobalDrawer(),
        body: Container(child: TestWebview()));
  }
}
