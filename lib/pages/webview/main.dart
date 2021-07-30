/*
 * @Author       : JHao
 * @Date         : 2021-07-06 13:48:25
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-29 17:45:25
 */
import 'package:homary/components/appBar/main.dart';
import 'package:homary/components/drawer/main.dart';
import 'package:flutter/material.dart';
import 'package:homary/webView/webviewController.dart';
import 'package:homary/common/utils/main.dart';

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
