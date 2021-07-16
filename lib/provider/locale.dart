/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 19:31:42
 */
// import 'package:localization_demo/i18n/app_localization_delegate.dart';
// import 'package:localization_demo/i18n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/utils/localstorage.dart';

class GlobalConfig with ChangeNotifier {
  Locale _locale = Locale('en', '');
  var currentConfig; //当前公共配置信息
  List currentConfigList = []; //配置信息列表
  get curLocale => _locale;
  List navList = []; //侧边栏菜单列表
  //获取公共配置
  void getCommonConfig() async {
    DioResult res = await SlideNavApi.getCommonConfig();
    if (res.error == null) {
      CommonConfigRes result = CommonConfigRes.fromJson(res.result);
      List siteList = result?.data?.siteList;
      List languageList = result?.data?.languagesList;
      List currencyList = result?.data?.currencyList;
      var config = result?.data?.currentConfig;
      this.currentConfig = config;
      setCurrentConfig(config.toJson());
      var site = siteList
          .where((item) => item.siteCode == config.site)
          .toList()[0]
          .siteName;
      var lang = languageList
          .where((item) => item.code == config.language)
          .toList()[0]
          .name;
      var currency = currencyList
          .where((item) => item.code == config.currency)
          .toList()[0]
          .enName;
      this.currentConfigList = [
        {'title': 'Site', 'subTitle': site, 'subList': siteList, 'type': 1},
        {
          'title': 'Language',
          'subTitle': lang,
          'subList': languageList,
          'type': 2
        },
        {
          'title': 'Currency',
          'subTitle': currency,
          'subList': currencyList,
          'type': 3
        }
      ];
      _locale = Locale(config.site);
      notifyListeners();
    }
  }

  //获取菜单
  void getNavList() async {
    if (this.navList.isEmpty) {
      DioResult res = await SlideNavApi.getSlideNavData();
      if (res.error == null) {
        this.navList = SlideNavRes.fromJson(res.result).data;
      }
      notifyListeners();
    }
  }

  //更新公共配置  configData->配置数据 configType->配置类型 1:站点 2：语言 3：货币
  updateCurrentConfig(configData, configType) {
    switch (configType) {
      case 1:
        this.currentConfig.site = configData.siteCode;
        this.currentConfig.language = configData.languageCode;
        this.currentConfig.currency = configData.currencyCode;
        this._locale = Locale(configData.languageCode, '');
        this.currentConfigList[0]['subTitle'] = configData.siteName;
        break;
      case 2:
        this.currentConfig.language = configData.code;
        this.currentConfigList[1]['subTitle'] = configData.name;
        this._locale = Locale(configData.code, '');
        break;
      default:
        this.currentConfig.currency = configData.code;
        this.currentConfigList[2]['subTitle'] = configData.enName;
    }
    setCurrentConfig(this.currentConfig.toJson());
    this.navList = [];
    this.getNavList();
    notifyListeners();
  }

  //登出
  void signOut() async {
    await UserApi.signOut();
    Localstorage().remove('token');
    Localstorage().setBool('isLogin', false);
  }
}
