/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-20 17:11:48
 */

import 'dart:async';

import 'package:exposure/exposure.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
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
            ? SliverGrid(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //Grid按两列显示
                  mainAxisSpacing: 8.w,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: ((1.sw - 24.w) / 2) / 320.w,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => ExposureDetector(
                          key: Key('RecommendList_$index'),
                          child: GoodsCard(
                            key: UniqueKey(),
                            width: (1.sw - 24.w) / 2,
                            data: data[index],
                            showCorner: false,
                            showSkuList: false,
                            showFreeShipping: true,
                            showRating: true,
                          ),
                          onExposure: (visibilityInfo) {
                            print(
                                '第$index 块曝光,展示比例为${visibilityInfo.visibleFraction}');
                            Map<String, dynamic> item = data[index].toJson();
                            pointList.add(item);
                            _sendPointList();
                          },
                        ),
                    childCount: data.length),
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
