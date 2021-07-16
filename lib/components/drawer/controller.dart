/*
 * @Author       : zhhjie
 * @Date         : 2021-07-09 13:41:42
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-16 18:28:14
 */
import 'package:flutter/material.dart';
import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';

class SlideNavCtrl with ChangeNotifier {
  List navList = [];
  bool showSubList = false;
  List subNavList = [];

  void getNavList() async {
    DioResult res = await SlideNavApi.getSlideNavData();
    if (res.result != null) {
      SlideNavRes result = SlideNavRes.fromJson(res.result);
      this.navList = result.data;
    }
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
