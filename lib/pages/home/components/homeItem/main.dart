/*
 * @Author       : JHao
 * @Date         : 2021-07-19 16:50:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-30 18:15:01
 */
import 'package:exposure/exposure.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/home/components/homeItem/components/RecommendList.dart';
import 'package:homary/pages/home/components/homeItem/components/ad.dart';
import 'package:homary/pages/home/components/homeItem/components/kingkong.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/pages/home/contorller.dart';
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

class _HomeItemState extends State<HomeItem>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool showBackTopButton = false;

  _handleScroll() {
    if (_scrollController.offset >= 250 && showBackTopButton == false) {
      setState(() {
        showBackTopButton = true;
      });
    } else if (_scrollController.offset < 250 && showBackTopButton == true) {
      setState(() {
        showBackTopButton = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ExposureDetectorController.instance.exposureTime = 100; //设置曝光时长 (ms)
    ExposureDetectorController.instance.exposureFraction = 0.5; // 设置曝光比例
    ExposureDetectorController.instance.updateInterval =
        Duration(milliseconds: 200); // 设置延时检测时间
    return Scaffold(
      body: RefreshIndicator(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(12.w, 5.w, 12.w, 0),
                        sliver: BannerList(),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(12.w, 8.w, 12.w, 0),
                        sliver: ServiceItems(),
                      ),
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
                        sliver: SliverToBoxAdapter(
                          child: ContentTitle(
                            title: S.of(context).HomePage_recommendTitle,
                            showViewAll: false,
                          ),
                        ),
                      ),
                      RecommendList(),
                      RecommendViewMoreButton(),
                    ],
                  ),
                )
              ],
            ),
            showBackTopButton
                ? Positioned(
                    bottom: 100.w,
                    right: 20.w,
                    child: GoTopMenu(
                      scrollController: _scrollController,
                    ))
                : Container()
          ],
        ),
        onRefresh: () async {
          await Provider.of<GlobalConfig>(context, listen: false)
              .getServiceTime();
          Provider.of<HomeCtrl>(context, listen: false).getAdvInfo();
          Provider.of<HomeCtrl>(context, listen: false).getProductModule();
          Provider.of<HomeCtrl>(context, listen: false).getReviewModule();
          Provider.of<HomeCtrl>(context, listen: false).getRecommendList();
        },
      ),
    );
  }
}
