import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/analytics_util.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/components/appBar/search/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/categoryTab/components/category_menu_bar_v2.dart';
import 'package:homary/pages/categoryTab/components/filter_drawer.dart';
import 'package:homary/pages/categoryTab/components/product_empty.dart';
import 'package:homary/pages/categoryTab/components/see_also.dart';
import 'package:homary/pages/categoryTab/components/view_more_button.dart';
import 'package:homary/pages/categoryTab/controller.dart';
import 'package:homary/pages/home/components/homeItem/components/AdBlock.dart';
import 'package:homary/pages/home/components/homeItem/components/kingkong.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:tuple/tuple.dart';

/// 首页类目Tab栏，类目页，搜索结果页
class CategoryTab extends StatefulWidget {
  const CategoryTab({
    Key key,
    this.categoryId,
    this.isPage = false,
    this.appBarTitle,
    this.isSearchPage = false,
    this.keyword,
  }) : super(key: key);

  final String categoryId;
  final bool isPage;
  final String appBarTitle;
  final bool isSearchPage;
  final String keyword;

  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  final ScrollController _scrollController = ScrollController();

  bool showBackTopButton = false;

  int config;

  void _handleScroll() {
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
  void initState() {
    super.initState();
    if (widget.isSearchPage) {
      sendGTMData({
        'event': 'view_search_results',
        "ecommerce": {
          'event_label': 'search_result',
          'search_term': widget.keyword ?? ''
        },
      });
    }
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<GlobalConfig, CategoryTabCtrl>(
      create: (context) => CategoryTabCtrl(
          keyword: widget.keyword,
          selectedCategoryId: widget.categoryId,
          selectedCategoryName: widget.appBarTitle,
          context: context),
      update: (context, config, ctrl) {
        if (this.config != config.currentConfig.hashCode) {
          this.config = config.currentConfig.hashCode;
          config.getServiceTime();
          ctrl.setCategoryList(config.navList);
          ctrl.init();
        }
        return ctrl;
      },
      child: Scaffold(
        appBar: widget.isPage ? buildAppBar() : null,
        endDrawer: FilterDrawer(),
        body: Stack(
          children: [
            buildProduct(),
            buildGoTop(),
          ],
        ),
      ),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 40.w),
      child: Selector<CategoryTabCtrl, String>(
        selector: (context, ctrl) => ctrl.selectedCategoryName,
        builder: (context, value, _) {
          return Column(
            children: [
              GoBackAppBar(
                showBorder: false,
                showCart: true,
                showMore: false,
                showCollet: true,
                title: value ?? '',
              ),
              AppbarSearch(
                marginTop: 0,
                searchContent: widget.keyword,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildProduct() {
    return Consumer<CategoryTabCtrl>(
      builder: (BuildContext context, ctrl, _) {
        return PullToRefresh(
          controller: ctrl.refreshController,
          onRefresh: ctrl.onRefresh,
          onLoading: ctrl.getProductList,
          enablePullUp: !ctrl.isShowEmpty,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (!widget.isSearchPage)
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    buildTitle(ctrl),
                    buildBanner(),
                    buildKingKong(),
                    buildGridAds()
                  ],
                )),
              if (widget.isSearchPage) SliverToBoxAdapter(child: SeeAlso()),
              // SliverPersistentHeader(
              //   pinned: true,
              //   delegate: StickyDelegate(
              //     child: PreferredSize(
              //       child: CategoryMenuBarV2(),
              //       preferredSize: Size.fromHeight(47.w),
              //     ),
              //   ),
              // ),

              SliverToBoxAdapter(
                child: CategoryMenuBarV2(
                  showTitle: widget.isSearchPage,
                ),
              ),
              ctrl.isShowEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(top: 80.w, bottom: 80.w),
                        child: ProductEmptyWidget(),
                      ),
                    )
                  : buildGridView(ctrl),
            ],
          ),
        );
      },
    );
  }

  Widget buildTitle(CategoryTabCtrl ctrl) {
    return Padding(
        padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            top: 8.w,
            bottom: widget.isSearchPage ? 12.w : 4.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                ctrl.selectedCategoryId != null
                    ? '${ctrl.selectedCategoryName}'
                    : ctrl.keyword.isEmpty
                        ? S.of(context).search_view_all
                        : '${S.of(context).search_showing_results(ctrl.keyword)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Text(
                '${ctrl.productTotal} ${S.of(context).category_items}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColor.primarySubTitle,
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildGridView(CategoryTabCtrl ctrl) {
    return GoodsCartSliverGrid(
      productList: ctrl.productList,
      showCorner: false,
      showSkuList: true,
      showFreeShipping: true,
      showRating: true,
      showDispatch: true,
      itemListName:
          widget.isSearchPage ? 'Search Results' : 'Category Products',
      onExposure: (list) {
        AnalyticsUtil.instance.sendProductItemGTM(
          pointList: list,
          itemListName:
              widget.isSearchPage ? 'Search Results' : 'Category Products',
          eventName: 'view_item_list',
        );
      },
    );
  }

  Widget buildViewMore() {
    return Selector<CategoryTabCtrl, Tuple2<int, bool>>(
      selector: (_, ctrl) {
        return Tuple2(ctrl.hasMorePage, ctrl.isLoading);
      },
      builder: (context, value, __) {
        if (value.item1 == 0) {
          return SliverToBoxAdapter();
        }
        return SliverToBoxAdapter(
          child: Center(
            child: ViewMoreButton(
              isLoading: value.item2,
              onLoadMore: () {
                context.read<CategoryTabCtrl>().getProductList();
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildGoTop() {
    if (!showBackTopButton) {
      return Container();
    }
    return Positioned(
      bottom: 100.w,
      right: 20.w,
      child: GoTopMenu(
        scrollController: _scrollController,
      ),
    );
  }

  Widget buildBanner() {
    return Selector<CategoryTabCtrl, AdvDatum>(
      selector: (context, ctrl) => ctrl.categoryTopBanner,
      builder: (context, value, _) {
        if (value == null ||
            value.moduleData == null ||
            value.moduleData.length == 0) {
          return Container();
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4.w,
          ),
          child: Center(
            child: ClipRRect(
                borderRadius: AppStyle.primaryBorderRaduis,
                child: GestureDetector(
                  onTap: () {
                    sendGTMData({
                      "event": 'custom_click_ads',
                      "ecommerce": {
                        "event_label": value.moduleData[0].eventLabel ?? ''
                      }
                    });
                    handleSchema(context, value.moduleData[0].jumpUrl);
                  },
                  child: CustomNetworkImage(
                    value.moduleData[0].imgUrl,
                    width: 351.w,
                    height: 119.w,
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget buildKingKong() {
    return Selector<CategoryTabCtrl, AdvDatum>(
      selector: (context, ctrl) => ctrl.categoryKingKong,
      builder: (context, value, _) {
        if (value == null ||
            value.moduleData == null ||
            value.moduleData.length == 0) {
          return Container();
        }
        return KingKong(
          data: value,
          showTitle: false,
          paddingTop: 0,
        );
      },
    );
  }

  Widget buildGridAds() {
    return Selector<CategoryTabCtrl, AdvDatum>(
      selector: (context, ctrl) => ctrl.categorySpecialAds,
      builder: (context, value, _) {
        if (value == null ||
            value.moduleData == null ||
            value.moduleData.length == 0) {
          return Container();
        }
        return Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: AdBlock(
              data: value,
              showTitle: false,
            ));
      },
    );
  }
}
