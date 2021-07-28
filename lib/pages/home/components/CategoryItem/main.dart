/*
 * @Author       : JHao
 * @Date         : 2021-07-29 18:34:23
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-30 10:10:34
 */
import 'package:flutter/material.dart';
import 'package:homary/webView/webviewController.dart';

class CategoryItem extends StatefulWidget {
  final String link;
  int idx;
  TabController tabController;
  CategoryItem({Key key, this.link, this.idx, this.tabController})
      : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  // with AutomaticKeepAliveClientMixin {
  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.idx + 1 == widget.tabController.index
          ? WebviewCtrl(
              content: '{"url":"https://m.homary.com${widget.link}"}',
            )
          : Container(),
    );
  }
}
