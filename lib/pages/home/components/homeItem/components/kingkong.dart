/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 15:08:10
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';

class KingKong extends StatelessWidget {
  const KingKong({Key key}) : super(key: key);

  Widget _item(ListElement item) {
    return GestureDetector(
        child: Container(
            width: (1.sw - 24.w) * 1 / 4,
            // height: (1.sw - 24.w) * 1 / 4,
            child: Column(children: [
              ClipOval(
                  child: Container(
                      width: 57.w,
                      height: 57.w,
                      color: AppColor.primaryBackground,
                      child: CustomNetworkImage(
                        item.imgUrl,
                        width: 57.w,
                        height: 57.w,
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 8.w, 5.w, 8.w),
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.sp, color: AppColor.primarySubTitle),
                  ))
            ])),
        onTap: () {
          print(item);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, Module>(
      builder: (BuildContext context, Module data, child) {
        return data?.moduleData != null && data?.moduleData?.list != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
                child: Wrap(
                  children: data.moduleData.list.map((e) => _item(e)).toList(),
                ))
            : Container();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return homeData.kingKongList;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}
