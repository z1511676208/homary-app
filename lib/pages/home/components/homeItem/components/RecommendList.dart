/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-08 14:52:44
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';

class RecommendList extends StatefulWidget {
  RecommendList({Key key}) : super(key: key);

  @override
  _RecommendListState createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList> {
  bool _debounce = false;
  Timer _timer;
  List<Map> pointList = [];

  _sendPointList() {
    if (_timer != null && _debounce == true) {
      _debounce = false;
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
    if (_debounce == false) {
      _debounce = true;
      _timer = Timer(Duration(seconds: 1), () {
        sendProductItemGTM(
            data: pointList,
            itemListName: 'Home - Recommend Goods',
            eventName: 'view_item_list',
            extraParms: {"event_label": 'Recommend For You'});
        pointList = [];
        _debounce = false;
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      // 页面销毁时触发定时器销毁
      if (_timer.isActive) {
        // 判断定时器是否是激活状态
        _timer.cancel();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<HomeCtrl, List<ModuleDataProductList>>(
      builder: (BuildContext context, List<ModuleDataProductList> data, child) {
        return data.length != 0
            ? GoodsCartSliverGrid(
                productList: data,
                showCorner: false,
                showSkuList: false,
                showFreeShipping: true,
                showRating: true,
                itemListName: 'Home - Recommend Goods',
                onExposure: (list) {
                  pointList.addAll(list);
                  _sendPointList();
                },
              )
            : SliverToBoxAdapter(
                child: Container(),
              );
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return homeData.recommendList;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    );
  }
}
