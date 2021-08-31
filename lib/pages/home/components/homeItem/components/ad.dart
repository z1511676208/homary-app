/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-31 10:19:04
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:tuple/tuple.dart';

class AD extends StatelessWidget {
  const AD({Key key}) : super(key: key);

  Widget _item(BuildContext context, ModuleAdvDatum item) {
    return GestureDetector(
        child: Container(
          child: ClipRRect(
            child: Container(
                width: (1.sw - 24.w - 12.w) / 2,
                height: 100.w,
                child: Column(children: [
                  Container(
                      width: double.infinity,
                      height: 66.w,
                      color: AppColor.primaryBackground,
                      child: CustomNetworkImage(
                        item.imgUrl,
                      )),
                  Container(
                      width: double.infinity,
                      height: 34.w,
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColor.primaryText),
                      ))
                ])),
            borderRadius: BorderRadius.circular(6.w),
          ),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppColor.primaryBorderShadow,
              blurRadius: 6.w,
              spreadRadius: 2.w,
              offset: Offset(1.w, 1.w),
            )
          ]),
        ),
        onTap: () {
          // print(item);
          handleSchema(context, item.jumpUrl);
        });
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
