/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 18:05:16
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-03 10:15:52
 */
import 'package:homary/common/utils/main.dart';

class WebviewAppBarCtrl with ChangeNotifier {
  bool showMore = false;
  bool showCart = false;
  bool showCollect = false;
  bool isShowAppBar = true;
  String appBarTitle = '';

  void setAppBarStatus(
      {bool showMore,
      bool showCart,
      bool showCollect,
      bool isShowAppBar,
      String appBarTitle = ''}) {
    this.showMore = showMore;
    this.showCart = showCart;
    this.showCollect = showCollect;
    this.isShowAppBar = isShowAppBar;
    this.appBarTitle = appBarTitle;
    notifyListeners();
  }
}
