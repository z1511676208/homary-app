/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-19 16:12:31
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/drawer/main.dart';
import 'package:homary/components/appBar/main.dart';
import 'package:homary/pages/home/main.dart';
import 'package:homary/pages/category/main.dart';
import 'package:homary/pages/user/main.dart';
import 'package:homary/pages/sale/main.dart';

class IndexPage extends StatefulWidget {
  final Map<String, dynamic> content;
  final String pageIndex;
  IndexPage({Key key, this.pageIndex = '0', this.content}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Map _pageList = {
    0: {'is_show_app_bar': true, 'component': HomePage()},
    1: {'is_show_app_bar': true, 'component': CategoryPage()},
    2: {'is_show_app_bar': true, 'component': SalePage()},
    3: {'is_show_app_bar': false, 'component': UserPage()}
  };

  PageController indexPageCtrl = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    _currentPageIndex = int.parse(widget.pageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (indexPageCtrl.hasClients) {
      indexPageCtrl.jumpToPage(_currentPageIndex);
    }
    return Scaffold(
      appBar: this._pageList[_currentPageIndex]['is_show_app_bar']
          ? PreferredSize(
              child: GlobalAppbar(),
              preferredSize: Size.fromHeight(96.5.w),
            )
          : null,
      drawer: GlobalDrawer(),
      body: PageView(
          controller: indexPageCtrl,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int i) {
            _currentPageIndex = i;
          },
          children:
              _pageList.values.map((e) => e['component'] as Widget).toList()),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int i) {
          setState(() {
            _currentPageIndex = i;
          });
          indexPageCtrl.jumpToPage(i);
        },
        backgroundColor: Colors.white,
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Iconfont.HomeBarItem),
              activeIcon: Icon(Iconfont.ActiveHomeBarItem),
              label: S.of(context).Home),
          BottomNavigationBarItem(
              icon: Icon(Iconfont.CategoryBarItem),
              activeIcon: Icon(Iconfont.ActiveCategoryBarItem),
              label: S.of(context).category),
          BottomNavigationBarItem(
              icon: Icon(Iconfont.SaleBarItem),
              activeIcon: Icon(Iconfont.ActiveSaleBarItem),
              label: S.of(context).Sale),
          BottomNavigationBarItem(
              icon: Icon(Iconfont.MeBarItem),
              activeIcon: Icon(Iconfont.ActiveMeBarItem),
              label: S.of(context).Me),
        ],
        fixedColor: AppColor.primaryColor,
        unselectedFontSize: 12.sp,
        selectedFontSize: 12.sp,
        unselectedItemColor: AppColor.primaryText,
        iconSize: 22.sp,
        unselectedLabelStyle: TextStyle(height: 1.2.w),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
