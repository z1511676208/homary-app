/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-10 16:34:10
 */
// import 'package:localization_demo/i18n/app_localization_delegate.dart';
// import 'package:localization_demo/i18n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:homary/api/common.dart';
import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/bus.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/entity/serviceTimeRes.dart';

import 'package:homary/common/utils/toast.dart';

var busEvent = BusProvider();

class GlobalConfig with ChangeNotifier {
  var currentConfig; //当前公共配置信息
  List currentConfigList = []; //配置信息列表
  Locale _locale = Locale(
      getCurrentConfig() != null ? getCurrentConfig()['language'] : 'en', '');
  get curLocale => _locale;
  List navList = []; //侧边栏菜单列表
  CommonAmountList commonAmountList = new CommonAmountList();

  // 服务器时间
  int serviceTime;

  //判断当前页面是否是webview页面
  bool isWebviewPage = false;

  void setIsWebviewPage(bool val) {
    this.isWebviewPage = val;
  }

  //获取公共配置
  Future getCommonConfig() async {
    if (this.currentConfigList.isEmpty) {
      DioResult res = await SlideNavApi.getGlobalConfig();
      if (res.error == null) {
        GlobalConfigRes result = GlobalConfigRes.fromJson(res.result);
        List siteList = result?.data?.siteList;
        List languageList = result?.data?.languagesList;
        List currencyList = result?.data?.currencyList;
        this.commonAmountList = result?.data?.commonAmountList;
        CurrentConfig config = result?.data?.currentConfig;
        this.currentConfig = config;
        var site = config.siteName;
        var lang = config.languageName;
        var currency = config.currencyName;

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
        setCurrentConfig(config.toJson());
        _locale = Locale(config.language);
        notifyListeners();
      }
    }
  }

  //获取菜单
  Future getNavList({bool isNotNotify = false}) async {
    if (this.navList.isEmpty) {
      Toast.loading();
      DioResult res = await SlideNavApi.getSlideNavData();
      Toast.clear();
      if (res.error == null) {
        this.navList = SlideNavRes.fromJson(res.result).data;
      }
      if (!isNotNotify) {
        notifyListeners();
      }
    }
  }

  //更新公共配置  configData->配置数据 configType->配置类型 1:站点 2：语言 3：货币
  Future updateCurrentConfig(configData, configType) async {
    switch (configType) {
      case 1:
        this.currentConfig.site = configData.siteCode;
        this.currentConfig.language = configData.languageCode;
        this.currentConfig.currency = configData.currencyCode;
        break;
      case 2:
        this.currentConfig.language = configData.code;
        break;
      default:
        this.currentConfig.currency = configData.code;
    }
    setCurrentConfig(this.currentConfig.toJson());
    setCurrentConfigCookie();
    busEvent.pubWebViewCtrl('switchSite'); // 通知webview刷新页面
    this.navList = [];
    this.currentConfigList = [];
    await this.getNavList(isNotNotify: true);
    await this.getCommonConfig();
  }

  //登出
  void signOut() async {
    DioResult res = await UserApi.signOut();
    if (res.error == null) {
      Localstorage().remove('token');
      Localstorage().setBool('isLogin', false);
      setWebviewCookies();
    }
  }

  Future<void> getServiceTime() async {
    DioResult res = await CommonApi.getServiceTime();
    if (res.error == null) {
      ServiceTimeRes result = ServiceTimeRes.fromJson(res.result);
      this.serviceTime =
          result?.data?.timeStamp ?? new DateTime.now().millisecondsSinceEpoch;
    }
    notifyListeners();
  }

  // 上报设备ID
  Future<void> pushDeviceInfo({Map<String, dynamic> params}) async {
    if (Localstorage().getBool('isPushDeviceId') == false) {
      DioResult res = await CommonApi.pushDeviceInfo(params: params);
      if (res.error == null) {
        Localstorage().setBool('isPushDeviceId', true);
      }
    }
  }
}
