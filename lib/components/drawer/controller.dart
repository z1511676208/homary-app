/*
 * @Author       : zhhjie
 * @Date         : 2021-07-09 13:41:42
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 19:22:08
 */
import 'package:flutter/material.dart';

class SlideNavCtrl with ChangeNotifier {
  List currentConfigList = []; //当前配置信息列表
  List subNavList = []; //二级菜单
  bool showSubList = false; //是否显示二级菜单
  bool isConfigSecondary = false; //判断二级菜单展开是否是配置菜单 1是0否
  int configType = 1; //1：站点 2：语言 3：货币
  var currentConfig; //当前配置
  String subTitle; //二级菜单标题

  //二级菜单展开关闭
  void subListToggle() {
    if (!this.showSubList) {
      this.isConfigSecondary = false;
    }
    this.showSubList = !this.showSubList;
    notifyListeners();
  }

  //二级菜单数据更新
  void setSubList(data, subTitle) {
    this.subNavList = data ?? [];
    this.subTitle = subTitle;
    notifyListeners();
  }

  //设置二级配置菜单类型 1：站点 2：语言 3：货币
  void setConfig(type) {
    this.isConfigSecondary = true;
    this.configType = type ?? 1;
    notifyListeners();
  }
}
