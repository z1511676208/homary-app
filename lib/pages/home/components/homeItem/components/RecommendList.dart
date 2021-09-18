/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-08 14:52:44
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics_util.dart';
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
                  AnalyticsUtil.instance.sendProductItemGTM(
                    pointList: list,
                    itemListName: 'Home - Recommend Goods',
                    eventName: 'view_item_list',
                    extraParams: {"event_label": 'Recommend For You'},
                  );
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
