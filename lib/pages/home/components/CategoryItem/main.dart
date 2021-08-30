/*
 * @Author       : JHao
 * @Date         : 2021-07-29 18:34:23
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-27 18:37:06
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

  bool isBuild = false;

  @override
  void initState() {
    var params = getSchemaParams(widget.link);
    schemaParams['url'] = params['url'];
    schemaParams['params'] = params['params'];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.tabController.offset == 0 &&
        widget.tabController.index == 0 &&
        !isBuild) {
      return Container();
    }

    isBuild = true;

    Map map = jsonDecode(schemaParams['params']['content']);
    if (map.containsKey('url')) {
      String url = map['url'] as String;
      if (url.contains('/category/')) {
        return CategoryTab(categoryId: getIdFromUrl(url));
      }
      if (url.contains('/channel/')) {
        return ChannelTab(type: getIdFromUrl(url));
      }
      if (url.contains('/act/')) {
        return ChannelTab(activityId: getIdFromUrl(url));
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
