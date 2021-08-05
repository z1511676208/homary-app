/*
 * @Author       : JHao
 * @Date         : 2021-07-14 15:05:20
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-05 18:38:21
 */
import 'package:flutter/rendering.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/category.dart';
import 'package:homary/pages/category/controller.dart';
import 'package:homary/pages/category/Watcher.dart';
import 'package:homary/widget/networkImg.dart';
import 'productList.dart';
import 'tapNav.dart';

class RightListLayout extends StatefulWidget {
  RightListLayout({Key key}) : super(key: key);

  @override
  _RightListLayoutState createState() => _RightListLayoutState();
}

class _RightListLayoutState extends State<RightListLayout>
    with TickerProviderStateMixin {
  bool _timer = false;
  final _scorllCtrl = ScrollController();
  TabController _topNavScrollCtrl;
  int _curTopNavItem = 0;
  String _lastActiveCategoryId;

  @override
  void initState() {
    _topNavScrollCtrl = TabController(vsync: this, length: 0);
    _scorllCtrl.addListener(() {
      if (Watcher.isTap) return;
      if (_timer == false) {
        _timer = true;
        Future.delayed(Duration(milliseconds: 200), () {
          _timer = false;
          for (var i = 0; i < Watcher.productListItemHeight.length; i++) {
            if (Watcher.itemOffsetList[i] - Watcher.productListItemHeight[i] <=
                    _scorllCtrl.offset &&
                _scorllCtrl.offset <= Watcher.itemOffsetList[i]) {
              this.setState(() {
                _curTopNavItem = i;
              });
              _topNavScrollCtrl.animateTo(_curTopNavItem);
            }
          }
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scorllCtrl.dispose();
    _topNavScrollCtrl.dispose();
    super.dispose();
  }

  Widget _banner() {
    return SliverToBoxAdapter(
      child: Container(
        width: 248.w,
        height: 86.w,
        margin: EdgeInsets.only(bottom: 12.w, top: 12.w, right: 6.5.w),
        decoration: BoxDecoration(borderRadius: AppStyle.primaryBorderRaduis),
        child: Selector<CategoryCtrl, Map<String, String>>(
          builder: (BuildContext context, Map<String, String> data, child) {
            return GestureDetector(
              child: data['app_category_banner'] != ""
                  ? CustomNetworkImage(data['app_category_banner'])
                  : Image.asset(
                      'assets/baseImage.png',
                      width: 248.w,
                      fit: BoxFit.cover,
                    ),
              onTap: () {
                handleSchema(context, data['jump_url']);
              },
            );
          },
          selector: (BuildContext context, CategoryCtrl category) {
            return category.categoryBannerMap;
          },
          shouldRebuild: (pre, next) {
            return pre != next;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CategoryCtrl, List<Data>>(
      selector: (context, CategoryCtrl controller) {
        return controller.subList;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
      builder: (context, List<Data> data, child) {
        _topNavScrollCtrl = TabController(vsync: this, length: data.length);
        _topNavScrollCtrl.animateTo(_curTopNavItem);
        print("_curTopNavItem  $_curTopNavItem");
        String activeCategoryId =
            Provider.of<CategoryCtrl>(context, listen: false).activeCategoryId;
        if (activeCategoryId != _lastActiveCategoryId) {
          _topNavScrollCtrl.animateTo(0);
        }
        _lastActiveCategoryId = activeCategoryId;
        return Container(
          width: 254.5.w,
          color: Colors.white,
          child: CustomScrollView(
            key: ValueKey(activeCategoryId),
            physics: ClampingScrollPhysics(),
            // cacheExtent: 1000,
            controller: _scorllCtrl,
            slivers: [
              _banner(),
              TopNav(
                _scorllCtrl,
                _topNavScrollCtrl,
                key: ValueKey(activeCategoryId),
              ),
              ProductList(
                subList: data,
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30.h))
            ],
          ),
        );
      },
    );
  }
}
