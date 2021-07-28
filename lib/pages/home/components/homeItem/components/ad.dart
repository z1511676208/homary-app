/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 15:09:11
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';

class AD extends StatelessWidget {
  const AD({Key key}) : super(key: key);

  Widget _item(ListElement item) {
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
                      child: Center(
                          child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColor.primaryText),
                      )))
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
          print(item);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, Module>(
      builder: (BuildContext context, Module data, child) {
        // print("Swiper ${data?.moduleData ?? '999'}");
        return data?.moduleData != null && data?.moduleData?.list != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: data.moduleData.list.map((e) => _item(e)).toList(),
                ))
            : Container();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return homeData.adList;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}
