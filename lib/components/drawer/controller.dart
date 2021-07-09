/*
 * @Author       : zhhjie
 * @Date         : 2021-07-09 13:41:42
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-09 15:42:15
 */
import 'package:flutter/material.dart';
import 'package:homary/api/main.dart';

class SlideNavCtrl with ChangeNotifier {
  List navList = [];
  bool showSubList = false;
  List subNavList = [];

  void getNavList() async {
    SlideNavRes res = await SlideNavApi.getSlideNavData();
    this.navList = res.data;
    notifyListeners();
  }

  void subListToggle() {
    this.showSubList = !this.showSubList;
    notifyListeners();
  }

  void getSubList(idx) {
    this.subNavList = navList[idx]?.subList ?? [];
    notifyListeners();
  }
}
