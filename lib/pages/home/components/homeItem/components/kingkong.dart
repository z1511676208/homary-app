/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-10 16:12:17
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';

class KingKong extends StatelessWidget {
  const KingKong({Key key}) : super(key: key);

  Widget _item(BuildContext context, ModuleAdvDatum item) {
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
          handleSchema(context, item.jumpUrl);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, AdvDatum>(
      builder: (BuildContext context, AdvDatum data, child) {
        return data?.moduleData != null && data?.moduleData?.length != 0
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
                child: Wrap(
                  children:
                      data.moduleData.map((e) => _item(context, e)).toList(),
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
