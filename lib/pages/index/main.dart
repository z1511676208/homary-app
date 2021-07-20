/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-19 16:12:14
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/drawer/main.dart';
import 'package:homary/components/appBar/main.dart';
import 'package:homary/pages/home/main.dart';
import 'package:homary/pages/category/main.dart';
import 'package:homary/pages/user/main.dart';
import 'package:homary/pages/sale/main.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  Map _pageList = {
    0: {'is_show_app_bar': true, 'component': HomePage()},
    1: {'is_show_app_bar': true, 'component': CategoryPage()},
    2: {'is_show_app_bar': true, 'component': SalePage()},
    3: {'is_show_app_bar': false, 'component': UserPage()}
  };

  List<BottomNavigationBarItem> _barItem = [
    BottomNavigationBarItem(
        icon: Icon(Iconfont.HomeBarItem),
        activeIcon: Icon(Iconfont.ActiveHomeBarItem),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Iconfont.CategoryBarItem),
        activeIcon: Icon(Iconfont.ActiveCategoryBarItem),
        label: 'Category'),
    BottomNavigationBarItem(
        icon: Icon(Iconfont.SaleBarItem),
        activeIcon: Icon(Iconfont.ActiveSaleBarItem),
        label: 'Sale'),
    BottomNavigationBarItem(
        icon: Icon(Iconfont.MeBarItem),
        activeIcon: Icon(Iconfont.ActiveMeBarItem),
        label: 'Me'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._pageList[this._currentIndex]['is_show_app_bar']
          ? PreferredSize(
              child: GlobalAppbar(),
              preferredSize: Size.fromHeight(96.5.w),
            )
          : null,
      drawer: GlobalDrawer(),
      body: this._pageList[this._currentIndex]['component'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        currentIndex: this._currentIndex,
        items: _barItem,
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
