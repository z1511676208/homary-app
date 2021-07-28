import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/category.dart';
import 'package:homary/pages/category/controller.dart';
import 'package:homary/pages/category/Watcher.dart';

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
        delegate: _SliverAppBarDelegate(widget._scrollCtrl,
            widget._topNavScorllCtrl, changeCurTab, curTab));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController _scrollCtrl; // 商品列表 scroll controller
  final TabController _topNavScorllCtrl; // 顶部导航 scroll controller
  final Function changeCurTab; // 修改当前页签视图方法
  final int curTab; // 当前选中的tab

  _SliverAppBarDelegate(
      this._scrollCtrl, this._topNavScorllCtrl, this.changeCurTab, this.curTab)
      : super();

  // 获取 product list 滚动距离
  void productListScrollTo(idx) {
    Watcher.isTap = true;
    // 如果点击的 tab 大于当前首屏商品列表的高度先移动到首屏最后商品的位置
    print("idx $idx");
    if (Watcher.productListItemHeight.length - 1 < idx) {
      int lastIdx = Watcher.productListItemHeight.length - 1;
      double top = Watcher.itemOffsetList[lastIdx] -
          Watcher.productListItemHeight[lastIdx]; // tabbar点击滚动在item头部
      _scrollCtrl
          .animateTo(top,
              duration: Duration(milliseconds: 100), curve: Curves.linear)
          .then((value) => productListScrollTo(idx)); // 移动结束后，递归执行，直到缓存列表有对应的高度
    } else {
      // print("itemOffsetList  ${Watcher.itemOffsetList}");
      double top = Watcher.itemOffsetList[idx] -
          Watcher.productListItemHeight[idx]; // tabbar点击滚动在item头部
      _scrollCtrl
          .animateTo(top,
              duration: Duration(milliseconds: 500), curve: Curves.linear)
          .then((value) => Watcher.isTap = false);
    }
  }

  List<Widget> tabItemsWidget(BuildContext context) {
    List<Data> subList =
        Provider.of<CategoryCtrl>(context, listen: false).subList;
    List<Widget> tabs = [];
    if (subList != null && subList.length > 0) {
      for (var i = 0; i < subList.length; i++) {
        tabs.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
          decoration: BoxDecoration(
              color: _topNavScorllCtrl.index == i
                  ? AppColor.activeColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: _topNavScorllCtrl.index == i
                      ? AppColor.primaryColor
                      : AppColor.primaryBorderOutline,
                  width: 1)),
          child: Text(subList[i].categoryName,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: _topNavScorllCtrl.index == i
                      ? AppColor.primaryColor
                      : AppColor.primaryLightSubTitle)),
        ));
      }
    }
    return tabs;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.white,
        height: 40.w,
        width: 260.w,
        child: TabBar(
            controller: _topNavScorllCtrl,
            tabs: tabItemsWidget(context),
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
  double get maxExtent => 40.w;

  @override
  double get minExtent => 40.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
