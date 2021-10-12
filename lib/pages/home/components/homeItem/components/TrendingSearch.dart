/*
 * @Author       : JHao
 * @Date         : 2021-10-12 17:21:39
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 17:19:11
 */

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/search.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/pages/home/contorller.dart';

class TrendingSearch extends StatelessWidget {
  const TrendingSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, List<HotKeyword>>(
      builder: (BuildContext context, List<HotKeyword> data, child) {
        return data != null && data.length > 0
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 28.w, 12.w, 0),
                child: Column(
                  children: [
                    ContentTitle(
                      title: S.of(context).trendingSearch,
                      showViewAll: false,
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                            spacing: 12.w,
                            runSpacing: 12.w,
                            children: data
                                .asMap()
                                .entries
                                .map((item) => ElevatedButton(
                                      onPressed: () {
                                        sendGTMData({
                                          "event": 'custom_click_ads',
                                          "ecommerce": {
                                            "event_label":
                                                item.value.eventLabel ?? ''
                                          }
                                        });
                                        String url =
                                            item.value.activityUrl ?? "";
                                        if (url != null && url != '') {
                                          handleSchema(context, url);
                                        } else {
                                          Routes.push(context, Routes.category,
                                              params: {
                                                'isSearchPage': 'true',
                                                'keyword': item.value.hotWord,
                                              });
                                        }
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 12.w)),
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColor.hotKeywordBgColor),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  AppColor.primaryPressed),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(36.w),
                                          ))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Offstage(
                                              offstage: item.key > 2,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 6.w),
                                                child: Image.asset(
                                                  "assets/images/home/hot.png",
                                                  width: 16.w,
                                                ),
                                              )),
                                          Text(
                                            item.value.hotWord,
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: AppColor.primaryText),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList()))
                  ],
                ))
            : Container();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return homeData.hotKeywordList;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}
