/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 15:16:45
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';

class GoodsList extends StatelessWidget {
  final String moduleName;
  final bool showCorner;
  const GoodsList({Key key, this.moduleName, this.showCorner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, Module>(
      builder: (BuildContext context, Module data, child) {
        return data?.moduleData != null && data?.moduleData?.productList != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 20.w, 12.w, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(data.moduleData.title,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryText)),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Routes.push(context, '/signIn?');
                          },
                          child: Row(
                            children: [
                              Text(
                                'View All',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColor.primaryLightSubTitle),
                              ),
                              Icon(
                                Iconfont.ArrowRight,
                                size: 12.w,
                                color: AppColor.primaryLightSubTitle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 230.w,
                      margin: EdgeInsets.fromLTRB(0, 12.w, 0, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        itemBuilder: (BuildContext ctx, int index) {
                          return GoodsCard(
                              key: UniqueKey(),
                              width: 140.w,
                              marginRight: 8.w,
                              moduleName: this.moduleName,
                              showCorner: this.showCorner,
                              data: data.moduleData.productList[index]);
                        },
                        itemCount: data.moduleData.productList.length,
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
