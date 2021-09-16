import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/components/appBar/search/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/pages/categoryTab/components/category_menu_bar_v2.dart';
import 'package:homary/pages/categoryTab/components/filter_drawer.dart';
import 'package:homary/pages/categoryTab/components/product_empty.dart';
import 'package:homary/pages/categoryTab/components/see_also.dart';
import 'package:homary/pages/categoryTab/components/view_more_button.dart';
import 'package:homary/pages/categoryTab/controller.dart';
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

  bool _debounce = false;
  Timer _timer;
  List<Map> pointList = [];

  _sendPointList() {
    if (_timer != null && _debounce == true) {
      _debounce = false;
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
    if (_debounce == false) {
      _debounce = true;
      _timer = Timer(Duration(seconds: 1), () {
        sendProductItemGTM(
          data: pointList,
          itemListName: 'Category Products',
          eventName: 'view_item_list',
        );
        pointList = [];
        _debounce = false;
      });
    }
  }

  @override
  void initState() {
    if (_timer != null) {
      // 页面销毁时触发定时器销毁
      if (_timer.isActive) {
        // 判断定时器是否是激活状态
        _timer.cancel();
      }
    }
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    if (_timer != null) {
      // 页面销毁时触发定时器销毁
      if (_timer.isActive) {
        // 判断定时器是否是激活状态
        _timer.cancel();
      }
    }
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
      preferredSize: Size.fromHeight(kToolbarHeight + 35.w),
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
                SliverToBoxAdapter(child: buildBanner()),
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
              SliverToBoxAdapter(child: CategoryMenuBarV2(),),
              ctrl.isShowEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(top: 80.w),
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

  Widget buildGridView(CategoryTabCtrl ctrl) {
    return GoodsCartSliverGrid(
      productList: ctrl.productList,
      showCorner: false,
      showSkuList: true,
      showFreeShipping: true,
      showRating: true,
      showDispatch: true,
      itemListName: 'Category Products',
      onExposure: (list) {
        pointList.addAll(list);
        _sendPointList();
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
    return Selector<CategoryTabCtrl, String>(
      selector: (context, ctrl) => ctrl.bannerImage,
      builder: (context, value, _) {
        if (value == null || value.isEmpty) {
          return Container();
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4.w,
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: AppStyle.primaryBorderRaduis,
              child: CustomNetworkImage(
                value,
                width: 351.w,
                height: 119.w,
              ),
            ),
          ),
        );
      },
    );
  }
}
