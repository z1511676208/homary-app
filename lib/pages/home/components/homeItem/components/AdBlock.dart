/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-22 14:24:05
 */
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/components/homeItem/components/AdCard.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';

class AdBlock extends StatelessWidget {
  final AdvDatum data;
  final bool showTitle;
  const AdBlock({Key key, @required this.data, this.showTitle = true})
      : super(key: key);

  Widget adGridColumn2(AdvDatum data) {
    return data != null && data.moduleData != null && data.moduleData.length > 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdCard(
                  width: 170.w,
                  imageHeight: 215.w,
                  textHeight: 36.w,
                  adImageUrl: data.moduleData[0].imgUrl,
                  adText: data.moduleData[0].title,
                  jumpUrl: data.moduleData[0].jumpUrl,
                  eventLabel: data.moduleData[0].eventLabel,
                  isLastCard: true),
              Column(
                children: [
                  AdCard(
                      width: 170.w,
                      imageHeight: 84.w,
                      textHeight: 36.w,
                      adImageUrl: data.moduleData[1].imgUrl,
                      adText: data.moduleData[1].title,
                      jumpUrl: data.moduleData[1].jumpUrl,
                      eventLabel: data.moduleData[1].eventLabel,
                      isLastCard: true),
                  SizedBox(
                    height: 11.w,
                  ),
                  AdCard(
                      width: 170.w,
                      imageHeight: 84.w,
                      textHeight: 36.w,
                      adImageUrl: data.moduleData[2].imgUrl,
                      adText: data.moduleData[2].title,
                      jumpUrl: data.moduleData[2].jumpUrl,
                      eventLabel: data.moduleData[2].eventLabel,
                      isLastCard: true),
                ],
              )
            ],
          )
        : SizedBox();
  }

  Widget adItem1(AdvDatum data) {
    return data != null && data.moduleData != null && data.moduleData.length > 0
        ? AdCard(
            width: 1.sw - 24.w,
            imageHeight: 140.w,
            textHeight: 36.w,
            adImageUrl: data.moduleData[0]?.imgUrl,
            adText: data.moduleData[0]?.title,
            jumpUrl: data.moduleData[0]?.jumpUrl,
            eventLabel: data.moduleData[0]?.eventLabel,
            isLastCard: true)
        : SizedBox();
  }

  Widget adItem2(AdvDatum data) {
    return data != null && data.moduleData != null && data.moduleData.length > 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: data.moduleData
                .map((e) => AdCard(
                    width: (1.sw - 24.w - 12.w) / 2,
                    imageHeight: 84.w,
                    textHeight: 36.w,
                    adImageUrl: e.imgUrl,
                    adText: e.title,
                    jumpUrl: e.jumpUrl,
                    eventLabel: e.eventLabel,
                    isLastCard: true))
                .toList())
        : SizedBox();
  }

  Widget filterAdBlock(AdvDatum data) {
    // show_type  展示方式【1-单图，2-轮播，3-隔栅，4-金刚区】
    // grille_type 格栅类型【1-一排一张图片，2-一排2张图片，3-一排三张图片】
    if (data.showType == 1 || data.showType == 3 && data.grilleType == 1) {
      return adItem1(data);
    }
    if (data.showType == 3 && data.grilleType == 2) {
      return adItem2(data);
    }
    if (data.showType == 3 && data.grilleType == 3) {
      return adGridColumn2(data);
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return data != null && data.moduleData != null && data.moduleData.length > 0
        ? Padding(
            padding: EdgeInsets.fromLTRB(12.w,
                data.title != "" && this.showTitle ? 28.w : 12.w, 12.w, 0),
            child: Column(
              children: [
                Offstage(
                    offstage: data.title == "" || this.showTitle == false,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.w),
                      child: ContentTitle(
                        title: data.title,
                        eventLabel: data.positionJumpUrlEventLabel,
                        moreJumpUrl: data.positionJumpUrl,
                      ),
                    )),
                filterAdBlock(this.data)
              ],
            ))
        : SizedBox();
  }
}
