/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 18:05:16
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 18:39:54
 */
import 'package:homary/common/utils/main.dart';

class WebviewAppBarCtrl with ChangeNotifier {
  bool showMore = false;
  bool showCart = false;
  bool showCollect = false;
  bool isShowAppBar = true;
  String appBarTitle = '';

  void setAppBarStatus(
      {String appBarType, String isShowAppBar, String appBarTitle = ''}) {
    this.showMore = appBarType != '0' && appBarType != '2';
    this.showCart = appBarType != '2';
    this.showCollect = appBarType != '1';
    this.isShowAppBar = isShowAppBar == '1';
    this.appBarTitle = appBarTitle;
    notifyListeners();
  }
}
