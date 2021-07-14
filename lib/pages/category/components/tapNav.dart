import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/category/watcher.dart';

class TopNav extends StatefulWidget {
  final ScrollController _scrollCtrl;
  final TabController _topNavScorllCtrl;

  TopNav(this._scrollCtrl, this._topNavScorllCtrl, {Key key}) : super(key: key);

  @override
  _TopNavState createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  int curTab = 0;

  changeCurTab(idx) {
    this.setState(() => curTab = idx);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: _SliverAppBarDelegate(
            widget._scrollCtrl, widget._topNavScorllCtrl, changeCurTab));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController _scrollCtrl; // 商品列表 scroll controller
  final TabController _topNavScorllCtrl; // 顶部导航 scroll controller
  final Function changeCurTab; // 修改当前页签视图方法

  _SliverAppBarDelegate(
      this._scrollCtrl, this._topNavScorllCtrl, this.changeCurTab)
      : super();

  // 获取 product list 滚动距离
  void productListScrollTo(idx) {
    Watcher.isTap = true;
    _scrollCtrl
        .animateTo(Watcher.productListItemHeight[idx].w,
            duration: Duration(milliseconds: 500), curve: Curves.linear)
        .then((value) => Watcher.isTap = false);
  }

  List<Widget> tabItemsWidget() {
    List<Widget> tabs = [];
    for (var i = 0; i < Watcher.productList.length; i++) {
      tabs.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: _topNavScorllCtrl.index == i
                    ? AppColor.primaryColor
                    : AppColor.primaryBorderOutline,
                width: 2)),
        child: Text(Watcher.productList[i]['title'],
            style: TextStyle(
                fontSize: 14.sp,
                color: _topNavScorllCtrl.index == i
                    ? AppColor.primaryColor
                    : AppColor.primaryLightSubTitle)),
      ));
    }
    return tabs;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.white,
        height: 32.w,
        width: 254.5.w,
        child: TabBar(
            controller: _topNavScorllCtrl,
            tabs: tabItemsWidget(),
            isScrollable: true,
            onTap: (int idx) {
              changeCurTab(idx);
              productListScrollTo(idx);
            },
            labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
            indicatorWeight: 0.01,
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.label));
  }

  @override
  double get maxExtent => 32.w;

  @override
  double get minExtent => 32.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
