import 'dart:async';

import 'package:exposure/exposure.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/components/appBar/search/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/pages/categoryTab/components/category_menu_bar.dart';
import 'package:homary/pages/categoryTab/components/filter_drawer.dart';
import 'package:homary/pages/categoryTab/components/product_empty.dart';
import 'package:homary/pages/categoryTab/components/view_more_button.dart';
import 'package:homary/pages/categoryTab/controller.dart';
import 'package:tuple/tuple.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab(
      {Key key, this.categoryId, this.isPage = false, this.appBarTitle})
      : super(key: key);

  final String categoryId;
  final bool isPage;
  final String appBarTitle;

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
      create: (context) => CategoryTabCtrl(widget.categoryId,
          selectedCategoryName: widget.appBarTitle),
      update: (context, config, ctrl) {
        if (this.config != config.currentConfig.hashCode) {
          this.config = config.currentConfig.hashCode;
          config.getServiceTime().then((value) {
            ctrl.setCategoryList(config.navList);
            ctrl.init();
          });
        }
        return ctrl;
      },
      child: Scaffold(
        appBar: widget.isPage ? buildAppBar() : null,
        endDrawer: FilterDrawer(),
        body: Column(
          children: [
            CategoryMenuBar(),
            Expanded(
              child: Stack(
                children: [
                  buildProduct(),
                  buildGoTop(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(96.w),
      child: Selector<CategoryTabCtrl, String>(
        selector: (context, ctrl) => ctrl.selectedCategoryName,
        builder: (context, value, _) {
          return Column(
            children: [
              GoBackAppBar(
                showBorder: true,
                showCart: true,
                showMore: false,
                showCollet: true,
                title: value,
              ),
              AppbarSearch(),
            ],
          );
        },
      ),
    );
  }

  Widget buildProduct() {
    return Consumer<CategoryTabCtrl>(
      builder: (BuildContext context, ctrl, _) {
        return LayoutBuilder(
          builder: (_, constraints) {
            return RefreshIndicator(
              onRefresh: ctrl.onRefresh,
              child: ctrl.isShowEmpty
                  ? SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        height: constraints.maxHeight,
                        child: ProductEmptyWidget(),
                      ),
                    )
                  : CustomScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      slivers: [
                        buildGridView(ctrl),
                        buildViewMore(),
                      ],
                    ),
            );
          },
        );
      },
    );
  }

  Widget buildGridView(CategoryTabCtrl ctrl) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Grid按两列显示
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          childAspectRatio: ((1.sw - 24.w) / 2) / 354.w,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ExposureDetector(
              key: Key('Category_$index'),
              child: GoodsCard(
                key: UniqueKey(),
                width: (1.sw - 24.w) / 2,
                data: ctrl.productList[index],
                showCorner: false,
                showSkuList: true,
                showFreeShipping: true,
                showRating: true,
              ),
              onExposure: (visibilityInfo) {
                Map<String, dynamic> item = ctrl.productList[index].toJson();
                pointList.add(item);
                _sendPointList();
              },
            );
          },
          childCount: ctrl.productList.length,
        ),
      ),
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
}
