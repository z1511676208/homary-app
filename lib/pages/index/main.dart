/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-08 17:43:41
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

  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    SalePage(),
    UserPage(),
  ];

  List<BottomNavigationBarItem> _barItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Sale'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Me'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: GlobalAppbar(),
        preferredSize: Size.fromHeight(95.h),
      ),
      drawer: GlobalDrawer(),
      body: this._pageList[this._currentIndex],
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
