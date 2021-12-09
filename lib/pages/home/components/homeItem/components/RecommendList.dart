/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-12-09 18:26:23
 */

import 'package:exposure/exposure.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics_util.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';

// class RecommendList extends StatefulWidget {
//   RecommendList({Key key}) : super(key: key);

//   @override
//   _RecommendListState createState() => _RecommendListState();
// }

// class _RecommendListState extends State<RecommendList> {
//   @override
//   Widget build(BuildContext context) {
//     return Selector<HomeCtrl, List<ModuleDataProductList>>(
//       builder: (BuildContext context, List<ModuleDataProductList> data, child) {
//         return SliverToBoxAdapter(
//             child: data.length != 0
//                 ? Container(
//                     height: 290.w,
//                     margin: EdgeInsets.fromLTRB(12.w, 16.w, 12.w, 28.w),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       // shrinkWrap: true,
//                       clipBehavior: Clip.none,
//                       itemBuilder: (BuildContext ctx, int index) {
//                         return ExposureDetector(
//                             key: Key('Recommend_${data[index].skuId}'),
//                             child: GoodsCard(
//                               key: UniqueKey(),
//                               width: 155.w,
//                               marginRight: 12.w,
//                               showCorner: false,
//                               showSkuList: false,
//                               showFreeShipping: true,
//                               showRating: true,
//                               data: data[index],
//                               itemListName: 'Home - Recommend Goods',
//                             ),
//                             onExposure: (visibilityInfo) {
//                               AnalyticsUtil.instance.sendProductItemGTM(
//                                 pointList: [data[index].toJson()],
//                                 itemListName: 'Home - Recommend Goods',
//                                 eventName: 'view_item_list',
//                               );
//                             });
//                       },
//                       itemCount: data.length,
//                     ),
//                   )
//                 : SizedBox());
//       },
//       selector: (BuildContext context, HomeCtrl homeData) {
//         return homeData.recommendList;
//       },
//       shouldRebuild: (pre, next) {
//         return pre != next;
//       },
//     );
//   }
// }

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
