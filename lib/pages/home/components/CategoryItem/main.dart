/*
 * @Author       : JHao
 * @Date         : 2021-07-29 18:34:23
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-03 10:14:07
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/schema2path.dart';
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
  Map<String, dynamic> schemaParams = {"url": "", "params": {}};
  @override
  void initState() {
    var params = getSchemaParams(widget.link);
    schemaParams['url'] = params['url'];
    schemaParams['params'] = params['params'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.idx + 1 == widget.tabController.index
          ? WebviewCtrl(
              needLogin: schemaParams['params']['needLogin'] ?? 0,
              source: schemaParams['params']['source'] ?? '',
              content: schemaParams['params']['content'] ?? "",
            )
          : Container(),
    );
  }
}
