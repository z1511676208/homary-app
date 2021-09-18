/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-08 14:52:03
 */

import 'package:exposure/exposure.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/analytics_util.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/homeProductModule.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/pages/home/contorller.dart';

class GoodsList extends StatefulWidget {
  final String moduleName;
  final bool showCorner;
  GoodsList({Key key, this.moduleName, this.showCorner}) : super(key: key);

  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, HotSaleActivity>(
      builder: (BuildContext context, HotSaleActivity data, child) {
        return data != null &&
                data?.productList != null &&
                data.productList.length > 0
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 20.w, 12.w, 0),
                child: Column(
                  children: [
                    ContentTitle(
                        title: data.title, moreJumpUrl: data.moreJumpUrl),
                    Container(
                      height: 230.w,
                      margin: EdgeInsets.fromLTRB(0, 12.w, 0, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        clipBehavior: Clip.none,
                        itemBuilder: (BuildContext ctx, int index) {
                          return ExposureDetector(
                              key: Key(
                                  '${widget.moduleName}_${data.productList[index].skuId}'),
                              child: GoodsCard(
                                key: UniqueKey(),
                                width: 140.w,
                                marginRight: 8.w,
                                moduleName: widget.moduleName,
                                showCorner: widget.showCorner,
                                data: data.productList[index],
                                itemListName: widget.moduleName == 'favoredList'
                                    ? itemListName['HomeFavoredbyCustomers']
                                    : 'Home ${itemListName['TodaysDeals']}',
                              ),
                              onExposure: (visibilityInfo) {
                                AnalyticsUtil.instance.sendProductItemGTM(
                                  pointList: [data.productList[index].toJson()],
                                  itemListName: widget.moduleName ==
                                          'favoredList'
                                      ? itemListName['HomeFavoredbyCustomers']
                                      : 'Home ${itemListName['TodaysDeals']}',
                                  eventName: 'view_item_list',
                                );
                              });
                        },
                        itemCount: data.productList.length,
                      ),
                    ),
                  ],
                ))
            : Container();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        if (widget.moduleName == 'favoredList') {
          return homeData.favoredList;
        } else if (widget.moduleName == 'deaksList') {
          return homeData.deaksList;
        }
        return homeData.favoredList;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}
