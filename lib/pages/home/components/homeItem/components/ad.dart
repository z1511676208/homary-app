/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 17:13:40
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/components/homeItem/components/AdCard.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:tuple/tuple.dart';

class AD extends StatelessWidget {
  const AD({Key key}) : super(key: key);

  Widget _item(BuildContext context, ModuleAdvDatum item) {
    return AdCard(
        width: (1.sw - 24.w - 12.w) / 2,
        imageHeight: 84.w,
        textHeight: 36.w,
        adImageUrl: item.imgUrl,
        adText: item.title,
        jumpUrl: item.jumpUrl,
        eventLabel: item.eventLabel,
        isLastCard: true);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, Tuple2<AdvDatum, AdvDatum>>(
      builder: (BuildContext context, Tuple2<AdvDatum, AdvDatum> data, child) {
        return Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                data.item1?.moduleData != null &&
                        data.item1.moduleData.length > 0
                    ? _item(context, data.item1.moduleData[0])
                    : Container(),
                data.item2?.moduleData != null &&
                        data.item2.moduleData.length > 0
                    ? _item(context, data.item2.moduleData[0])
                    : Container(),
              ],
            ));
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return Tuple2(homeData.leftAd, homeData.rightAd);
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}
