/*
 * @Author       : JHao
 * @Date         : 2021-07-29 18:34:23
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 15:00:35
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/pages/categoryTab/main.dart';
import 'package:homary/pages/channelTab/main.dart';
import 'package:homary/webView/webviewController.dart';

class CategoryItem extends StatefulWidget {
  final String link;
  final int idx;
  final TabController tabController;

  CategoryItem({
    Key key,
    this.link,
    this.idx,
    this.tabController,
  }) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
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
    super.build(context);
    Map map = jsonDecode(schemaParams['params']['content']);
    if (map.containsKey('url')) {
      String url = map['url'] as String;
      if (url.contains('/category/')) {
        return CategoryTab(categoryId: getIdFromUrl(url));
      }
      if (url.contains('/channel/')) {
        return ChannelTab(type: getIdFromUrl(url));
      }
    }
    return Scaffold(
      body: WebviewCtrl(
        isInWebviewPage: false,
        needLogin: schemaParams['params']['needLogin'] ?? 0,
        source: schemaParams['params']['source'] ?? '',
        content: map ?? {},
      ),
    );
  }
}
