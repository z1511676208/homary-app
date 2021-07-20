/*
 * @Author       : JHao
 * @Date         : 2021-07-23 18:34:11
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 15:18:27
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';

class ReviewsList extends StatelessWidget {
  const ReviewsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, Module>(
      builder: (BuildContext context, Module data, child) {
        return data?.moduleData != null &&
                data?.moduleData?.reviewList != null &&
                data?.moduleData?.reviewList?.length != 0
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
                      height: 365.w,
                      margin: EdgeInsets.fromLTRB(0, 12.w, 0, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        itemBuilder: (BuildContext ctx, int index) {
                          return GestureDetector(
                            child: Container(
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.primaryBorderShadow,
                                      blurRadius: 4.w,
                                      spreadRadius: 1.w,
                                      offset: Offset(1.w, 1.w),
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: AppStyle.primaryBorderRaduis,
                                  child: Column(
                                    children: [
                                      CustomNetworkImage(
                                        data.moduleData.reviewList[index]
                                            .imgUrl,
                                        width: 240.w,
                                        height: 240.w,
                                      ),
                                      Container(
                                        width: 240.w,
                                        padding: EdgeInsets.all(8.w),
                                        color: Colors.white,
                                        child: Column(children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: RatingBarIndicator(
                                              rating: data.moduleData
                                                  .reviewList[index].score,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Color(0xFFFFB400),
                                              ),
                                              unratedColor: Color(0xFFE3E3E3),
                                              itemCount: 5,
                                              itemSize: 18.w,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                          Container(
                                            height: 65.w,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.w),
                                            child: Text(
                                              data.moduleData.reviewList[index]
                                                  .content,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  width: 20.w,
                                                  height: 20.w,
                                                  color: AppColor.primaryText,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    data
                                                        .moduleData
                                                        .reviewList[index]
                                                        .username
                                                        .substring(0, 1),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                data.moduleData
                                                    .reviewList[index].username,
                                                style: TextStyle(
                                                    color: AppColor
                                                        .primarySubTitle,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                        ]),
                                      )
                                    ],
                                  ),
                                )),
                            onTap: () {
                              Routes.push(context, '/reviewDetail',
                                  params: {"index": index.toString()},
                                  transition: TransitionType.inFromTop);
                            },
                          );
                        },
                        itemCount: data.moduleData.reviewList.length,
                      ),
                    ),
                  ],
                ))
            : Container();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return homeData.reviewList;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}
