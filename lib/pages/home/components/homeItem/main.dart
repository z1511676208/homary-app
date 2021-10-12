/*
 * @Author       : JHao
 * @Date         : 2021-07-19 16:50:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 17:13:56
 */
import 'package:flutter/material.dart';
import 'package:homary/common/event/refresh_tab.dart';
import 'package:homary/common/utils/event_bus.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/home/components/homeItem/components/AdBlock.dart';
import 'package:homary/pages/home/components/homeItem/components/MiniShoppingCart.dart';
import 'package:homary/pages/home/components/homeItem/components/RecommendList.dart';
import 'package:homary/pages/home/components/homeItem/components/RoomAd.dart';
import 'package:homary/pages/home/components/homeItem/components/TrendingSearch.dart';
import 'package:homary/pages/home/components/homeItem/components/ad.dart';
import 'package:homary/pages/home/components/homeItem/components/kingkong.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/pages/home/contorller.dart';
// import 'components/RecommendViewMoreButton.dart';
import 'components/NewFlashSale.dart';
import 'components/ReviewsList.dart';
import 'components/serviveItems.dart';
import 'components/swiper.dart';

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
    HomeCtrl ctrl = Provider.of<HomeCtrl>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          PullToRefresh(
            child: CustomScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(12.w, 5.w, 12.w, 0),
                  sliver: BannerList(),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(12.w, 12.w, 0.w, 0.w),
                  sliver: ServiceItems(),
                ),
                MiniShoppingCart(),
                Selector<HomeCtrl, AdvDatum>(
                  builder: (BuildContext context, AdvDatum data, child) {
                    return SliverToBoxAdapter(
                      child: KingKong(
                        data: data,
                      ),
                    );
                  },
                  selector: (BuildContext context, HomeCtrl homeData) {
                    return homeData.kingKongList;
                  },
                  shouldRebuild: (pre, next) {
                    return pre != next;
                  },
                ),

                AD(),
                Selector<HomeCtrl, AdvDatum>(
                  builder: (BuildContext context, AdvDatum data, child) {
                    return RoomAd(
                      data: data,
                    );
                  },
                  selector: (BuildContext context, HomeCtrl homeData) {
                    return homeData.fisrtRoomAds;
                  },
                  shouldRebuild: (pre, next) {
                    return pre != next;
                  },
                ),
                Selector<HomeCtrl, AdvDatum>(
                  builder: (BuildContext context, AdvDatum data, child) {
                    return RoomAd(
                      data: data,
                    );
                  },
                  selector: (BuildContext context, HomeCtrl homeData) {
                    return homeData.secondRoomAds;
                  },
                  shouldRebuild: (pre, next) {
                    return pre != next;
                  },
                ),
                Selector<HomeCtrl, AdvDatum>(
                  builder: (BuildContext context, AdvDatum data, child) {
                    return SliverToBoxAdapter(
                        child: AdBlock(
                      data: data,
                    ));
                  },
                  selector: (BuildContext context, HomeCtrl homeData) {
                    return homeData.firstGridAds;
                  },
                  shouldRebuild: (pre, next) {
                    return pre != next;
                  },
                ),
                ReviewsList(),
                NewFlashSale(),
                Selector<HomeCtrl, AdvDatum>(
                  builder: (BuildContext context, AdvDatum data, child) {
                    return SliverToBoxAdapter(
                        child: AdBlock(
                      data: data,
                    ));
                  },
                  selector: (BuildContext context, HomeCtrl homeData) {
                    return homeData.secondGridAds1;
                  },
                  shouldRebuild: (pre, next) {
                    return pre != next;
                  },
                ),
                Selector<HomeCtrl, AdvDatum>(
                  builder: (BuildContext context, AdvDatum data, child) {
                    return SliverToBoxAdapter(
                        child: AdBlock(
                      data: data,
                    ));
                  },
                  selector: (BuildContext context, HomeCtrl homeData) {
                    return homeData.secondGridAds2;
                  },
                  shouldRebuild: (pre, next) {
                    return pre != next;
                  },
                ),
                // AdBlock(),
                // GoodsList(
                //   moduleName: 'favoredList',
                //   showCorner: true,
                // ),
                // GoodsList(
                //   moduleName: 'deaksList',
                //   showCorner: false,
                // ),
                TrendingSearch(),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(12.w, 28.w, 12.w, 0.w),
                  sliver: SliverToBoxAdapter(
                    child: ContentTitle(
                      title: S.of(context).HomePage_recommendTitle,
                      showViewAll: false,
                    ),
                  ),
                ),
                RecommendList(),
              ],
            ),
            controller: ctrl.refreshController,
            enablePullUp: false,
            // onLoading: ctrl.handleGetMoreProduct,
            onRefresh: () async {
              Provider.of<GlobalConfig>(context, listen: false)
                  .getServiceTime();
              ctrl.getFlashSaleModule();
              ctrl.getShoppingCartData();
              // ctrl.getProductModule();
              ctrl.getReviewModule();
              ctrl.getRecommendList();
              await ctrl.getAdvInfo(isShowLoading: false);
              final channelMap = await ctrl.getTopChannelCategory();
              EventBus.instance.emit(RefreshTabEvent(channelMap));
            },
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
    );
  }
}
