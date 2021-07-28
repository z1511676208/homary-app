/*
 * @Author       : JHao
 * @Date         : 2021-07-19 16:50:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 15:18:44
 */
import 'dart:math';

import 'package:exposure/exposure.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/home/components/homeItem/components/RecommendList.dart';
import 'package:homary/pages/home/components/homeItem/components/ad.dart';
import 'package:homary/pages/home/components/homeItem/components/kingkong.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/pages/home/contorller.dart';

import 'package:tuple/tuple.dart';

import 'components/RecommendViewMoreButton.dart';
import 'components/ReviewsList.dart';
import 'components/serviveItems.dart';
import 'components/swiper.dart';
import 'components/GoodsList.dart';

class HomeItem extends StatefulWidget {
  HomeItem({Key key}) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  final ScrollController _scrollController = ScrollController();
  var currentConfig;

  @override
  void initState() {
    super.initState();
    // Future.microtask(() async {
    //   await Provider.of<GlobalConfig>(context, listen: false).getServiceTime();
    //   Provider.of<HomeCtrl>(context, listen: false).getIndexData();
    //   Provider.of<HomeCtrl>(context, listen: false).getRecommendList();
    // });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ExposureDetectorController.instance.exposureTime = 100; //设置曝光时长 (ms)
    ExposureDetectorController.instance.exposureFraction = 0.5; // 设置曝光比例
    ExposureDetectorController.instance.updateInterval =
        Duration(milliseconds: 200); // 设置延时检测时间
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: CustomScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          slivers: [
            // SliverToBoxAdapter(
            //   child: TextButton(
            //       onPressed: () {
            //         Routes.push(context, '/webview', params: {
            //           "needLogin": '1',
            //           "source": "facebook",
            //           "content":
            //               '{"url":"https://m.homary.com/category/coffee-tables-174.html"}'
            //         });
            //       },
            //       child: Text("To Webview")),
            // ),
            SliverPadding(
                padding: EdgeInsets.fromLTRB(12.w, 10.w, 12.w, 0),
                sliver: BannerList()),
            SliverPadding(
                padding: EdgeInsets.fromLTRB(12.w, 8.w, 12.w, 0),
                sliver: ServiceItems()),
            KingKong(),
            AD(),
            GoodsList(
              moduleName: 'favoredList',
              showCorner: true,
            ),
            GoodsList(
              moduleName: 'deaksList',
              showCorner: false,
            ),
            ReviewsList(),
            SliverPadding(
                padding: EdgeInsets.fromLTRB(12.w, 20.w, 12.w, 0),
                sliver: ContentTitle(
                  title: S.of(context).HomePage_recommendTitle,
                )),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
              sliver: RecommendList(),
            ),
            RecommendViewMoreButton(),
          ],
        ))
      ],
    ));
  }
}
