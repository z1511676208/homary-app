/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 17:18:16
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
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Sale'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Me'),
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
        fixedColor: Colors.orange,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
