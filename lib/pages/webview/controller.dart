/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 18:05:16
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-31 10:30:36
 */
import 'package:homary/common/utils/main.dart';

class WebviewAppBarCtrl with ChangeNotifier {
  bool showMore = false;
  bool showCart = false;
  bool showCollect = false;
  bool isShowAppBar = true;
  bool showBorder = true;
  String appBarTitle = '';

  void setAppBarStatus(
      {bool showMore = false,
      bool showCart = false,
      bool showCollect = false,
      bool isShowAppBar = true,
      bool showBorder = true,
      String appBarTitle = ''}) {
    this.showMore = showMore;
    this.showCart = showCart;
    this.showCollect = showCollect;
    this.isShowAppBar = isShowAppBar;
    this.showBorder = showBorder;
    this.appBarTitle = appBarTitle;
    notifyListeners();
  }
}
