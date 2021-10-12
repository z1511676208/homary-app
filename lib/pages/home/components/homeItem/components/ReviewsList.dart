import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/homeReviewModule.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';

class ReviewsList extends StatelessWidget {
  const ReviewsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, ReviewData>(
      builder: (BuildContext context, ReviewData data, child) {
        return data != null &&
                data.reviewList != null &&
                data.reviewList.isNotEmpty
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 28.w, 12.w, 0),
                child: Column(
                  children: [
                    ContentTitle(
                      title: data.title,
                      moreJumpUrl: data?.moreJumpUrl,
                      eventLabel: data.eventLabel,
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: RatingBarIndicator(
                            rating: data.avgScore == ""
                                ? 0
                                : double.parse(data.avgScore.toString()),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Color(0xFFFFB400),
                            ),
                            unratedColor: Color(0xFFE3E3E3),
                            itemCount: 5,
                            itemSize: 14.w,
                            direction: Axis.horizontal,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          data.avgScore == "" ? '0' : data.avgScore,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColor.primaryText),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          'Powered by',
                          style: TextStyle(
                              fontSize: 14.sp, color: AppColor.primaryText),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Icon(
                          Iconfont.yotpo,
                          size: 16.sp,
                          color: AppColor.primaryText,
                        )
                      ],
                    ),
                    Container(
                      height: 360.w,
                      margin: EdgeInsets.fromLTRB(0, 16.w, 0, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemBuilder: (BuildContext ctx, int index) {
                          return GestureDetector(
                            child: Container(
                                width: 230.w,
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
                                      Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        padding: EdgeInsets.all(8.w),
                                        child: Row(
                                          children: [
                                            ClipOval(
                                              child: data.reviewList[index]
                                                          ?.headImg !=
                                                      ""
                                                  ? CustomNetworkImage(
                                                      data.reviewList[index]
                                                          ?.headImg,
                                                      width: 32.w,
                                                      height: 32.w,
                                                    )
                                                  : Container(
                                                      width: 32.w,
                                                      height: 32.w,
                                                      color:
                                                          AppColor.primaryText,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        data.reviewList[index]
                                                            .username
                                                            .substring(0, 1),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.sp),
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.reviewList[index]
                                                      .username,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.primaryText,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  data.reviewList[index].job,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColor
                                                        .primarySubTitle,
                                                    fontSize: 12.sp,
                                                  ),
                                                )
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                      CustomNetworkImage(
                                        data.reviewList[index].imgUrl,
                                        width: double.infinity,
                                        height: 230.w,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8.w),
                                        color: Colors.white,
                                        child: Container(
                                          height: 65.w,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.w),
                                          child: Text(
                                            data.reviewList[index].content,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: AppColor.primaryText),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            onTap: () {
                              sendGTMData({
                                "event": 'custom_click_ads',
                                "ecommerce": {
                                  "event_label":
                                      data.reviewList[index].eventLabel ?? ''
                                }
                              });
                              Routes.push(context, '/reviewDetail',
                                  params: {"index": index.toString()},
                                  transition: TransitionType.inFromTop);
                            },
                          );
                        },
                        itemCount: data.reviewList.length,
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
