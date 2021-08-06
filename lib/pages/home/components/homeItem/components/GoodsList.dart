/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-06 14:56:58
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/homeProductModule.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/pages/home/contorller.dart';

class GoodsList extends StatelessWidget {
  final String moduleName;
  final bool showCorner;
  const GoodsList({Key key, this.moduleName, this.showCorner})
      : super(key: key);

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
                          return GoodsCard(
                              key: UniqueKey(),
                              width: 140.w,
                              marginRight: 8.w,
                              moduleName: this.moduleName,
                              showCorner: this.showCorner,
                              data: data.productList[index]);
                        },
                        itemCount: data.productList.length,
                      ),
                    ),
                  ],
                ))
            : Container();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        if (this.moduleName == 'favoredList') {
          return homeData.favoredList;
        } else if (this.moduleName == 'deaksList') {
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
