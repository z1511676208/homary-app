/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 14:24:38
 */

import 'package:exposure/exposure.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';

class RecommendList extends StatelessWidget {
  const RecommendList({Key key}) : super(key: key);

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
                  childAspectRatio: ((1.sw - 24.w) / 2) / 354.w,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => ExposureDetector(
                          key: Key('RecommendList_$index'),
                          child: GoodsCard(
                            key: UniqueKey(),
                            width: (1.sw - 24.w) / 2,
                            data: data[index],
                            showCorner: false,
                            showSkuList: true,
                            showFreeShipping: true,
                            showRating: true,
                          ),
                          onExposure: (visibilityInfo) {
                            print(
                                '第$index 块曝光,展示比例为${visibilityInfo.visibleFraction}');
                            // Toast.show('第$index 块曝光,展示比例为${visibilityInfo.visibleFraction}',
                            //     context);
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
