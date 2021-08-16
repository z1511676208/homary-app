/*
 * @Author       : JHao
 * @Date         : 2021-08-16 16:07:21
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-16 18:56:38
 */
import 'package:flutter/material.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/webView/webviewController.dart';

class PdfViewer extends StatelessWidget {
  final String link;
  final String title;
  const PdfViewer({Key key, this.link, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: GoBackAppBar(
            title: this.title,
          ),
          preferredSize: Size.fromHeight(44.h)),
      body: WebviewCtrl(
        isPDF: true,
        content: {"url": this.link},
      ),
    );
  }
}
