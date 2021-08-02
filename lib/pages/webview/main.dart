/*
 * @Author       : JHao
 * @Date         : 2021-07-06 13:48:25
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-02 16:18:54
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/drawer/main.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/bus.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/webView/webviewController.dart';

import 'controller.dart';

class WebviewPageView extends StatefulWidget {
  final String needLogin;
  final String source;
  final String content;
  final String appBarTitle;
  final String showAppLoading;
  WebviewPageView(
      {Key key,
      this.needLogin,
      this.content,
      this.source,
      this.appBarTitle,
      this.showAppLoading})
      : super(key: key);

  @override
  _WebviewPageViewState createState() => _WebviewPageViewState();
}

class _WebviewPageViewState extends State<WebviewPageView> {
  var busEvent = BusProvider();

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<WebviewAppBarCtrl>(context, listen: false).setAppBarStatus(
    //       appBarType: widget.appBarType,
    //       isShowAppBar: widget.showAppBar,
    //       appBarTitle: widget.appBarTitle);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebviewAppBarCtrl>(
        builder: (BuildContext context, WebviewAppBarCtrl data, child) {
      return Scaffold(
          appBar: PreferredSize(
            child: GoBackAppBar(
              showBorder: data.isShowAppBar,
              showCart: data.showCart,
              showMore: data.showMore,
              showCollet: data.showCollect,
            ),
            preferredSize:
                data.isShowAppBar ? Size.fromHeight(44.h) : Size.zero,
          ),
          drawer: GlobalDrawer(),
          body: SafeArea(
              top: false,
              bottom: true,
              child: Container(
                  child: WebviewCtrl(
                      needLogin: widget.needLogin,
                      source: widget.source,
                      content: widget.content,
                      showAppLoading: widget.showAppLoading))));
    });
  }
}

class WebviewPage extends StatelessWidget {
  final String needLogin;
  final String source;
  final String content;
  final String appBarTitle;
  final String showAppLoading;
  const WebviewPage(
      {Key key,
      this.needLogin,
      this.content,
      this.source,
      this.appBarTitle,
      this.showAppLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WebviewAppBarCtrl>(
          create: (context) => WebviewAppBarCtrl(),
        )
      ],
      child: WebviewPageView(
        needLogin: this.needLogin,
        content: this.content,
        source: this.source,
        appBarTitle: this.appBarTitle,
        showAppLoading: this.showAppLoading,
      ),
    );
  }
}
