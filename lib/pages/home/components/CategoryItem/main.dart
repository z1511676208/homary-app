/*
 * @Author       : JHao
 * @Date         : 2021-07-29 18:34:23
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 15:00:35
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/webView/webviewController.dart';

class CategoryItem extends StatefulWidget {
  final String link;
  final int idx;
  final TabController tabController;
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
  int _currentTabIndex;

  @override
  void initState() {
    var params = getSchemaParams(widget.link);
    schemaParams['url'] = params['url'];
    schemaParams['params'] = params['params'];
    widget.tabController.addListener(_getCurrentTabIndex);
    super.initState();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_getCurrentTabIndex);
    super.dispose();
  }

  _getCurrentTabIndex() {
    int index = widget.tabController.index;
    double value = widget.tabController.animation.value;
    if (index.toDouble() == value) {
      setState(() {
        _currentTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.idx + 1 == _currentTabIndex
          ? WebviewCtrl(
              needLogin: schemaParams['params']['needLogin'] ?? 0,
              source: schemaParams['params']['source'] ?? '',
              content: schemaParams['params']['content'] ?? "",
            )
          : Container(),
    );
  }
}
