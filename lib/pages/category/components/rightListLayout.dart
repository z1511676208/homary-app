/*
 * @Author       : JHao
 * @Date         : 2021-07-14 15:05:20
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-15 18:46:25
 */
import 'package:flutter/rendering.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/category/watcher.dart';
import 'productList.dart';
import 'tapNav.dart';

class RightListLayout extends StatefulWidget {
  RightListLayout({Key key}) : super(key: key);

  @override
  _RightListLayoutState createState() => _RightListLayoutState();
}

class _RightListLayoutState extends State<RightListLayout>
    with SingleTickerProviderStateMixin {
  bool _timer = false;
  final _scorllCtrl = ScrollController();
  TabController _topNavScorllCtrl;
  int _curTopNavItem = 0;

  @override
  void initState() {
    _topNavScorllCtrl =
        TabController(vsync: this, length: Watcher.productList.length);
    // Watcher.productListItemHeight =
    //     getPorductListItemHeight(Watcher.productList);
    _scorllCtrl.addListener(() {
      if (Watcher.isTap) return;
      // print("upDirection  ${_scorllCtrl.offset}");
      if (_timer == false) {
        _timer = true;
        Future.delayed(Duration(milliseconds: 200), () {
          _timer = false;
          for (var i = 0; i < Watcher.productListItemHeight.length; i++) {
            if (Watcher.itemOffsetList[i] - Watcher.productListItemHeight[i] <=
                    _scorllCtrl.offset &&
                _scorllCtrl.offset <= Watcher.itemOffsetList[i]) {
              // if (_curTopNavItem == i) {
              //   return;
              // }
              this.setState(() {
                _curTopNavItem = i;
              });
              // print(
              //     "_topNavScorllCtrl  ${Watcher.productListItemHeight.length} $i");
              _topNavScorllCtrl.animateTo(i);
            }
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scorllCtrl.dispose();
    super.dispose();
  }

  // 计算商品列表高度列表
  List<double> getPorductListItemHeight(List<dynamic> list) {
    List<double> _heightList = [];
    double topOffset = 135.h; // 轮播图 + 顶部导航高度
    double porductsListOffset = 0 + topOffset; // 默认加上 轮播图和顶栏的高度
    for (var i = 0; i < list.length; i++) {
      if (i != 0) {
        int rowCount = (list[0]["info"].length / 3).ceil(); // 计算有几行商品
        porductsListOffset += (rowCount * 130) + 50; // 计算行数加上标题的高度
      }
      _heightList.add(porductsListOffset); // 每个商品列表的高度
    }
    return _heightList;
  }

  Widget _banner() {
    return SliverToBoxAdapter(
      child: Container(
        width: 248.w,
        height: 86.w,
        margin: EdgeInsets.only(bottom: 12.w, top: 12.w),
        decoration: BoxDecoration(borderRadius: AppStyle.primaryBorderRaduis),
        child: Placeholder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 254.5.w,
      color: Colors.white,
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        // cacheExtent: 1000,
        controller: _scorllCtrl,
        slivers: [
          _banner(),
          TopNav(_scorllCtrl, _topNavScorllCtrl),
          ProductList(),
          // SliverToBoxAdapter(child: SizedBox(height: 30.h))
        ],
      ),
    );
  }
}
