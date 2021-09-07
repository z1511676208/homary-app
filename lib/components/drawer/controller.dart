/*
 * @Author       : zhhjie
 * @Date         : 2021-07-09 13:41:42
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-07 12:07:12
 */
import 'package:flutter/material.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/main.dart';

class SlideNavCtrl with ChangeNotifier {
  List subNavList = []; //二级菜单
  bool showSubList = false; //是否显示二级菜单
  bool isConfigSecondary = false; //判断二级菜单展开是否是配置菜单 1是0否
  int configType = 1; //1：站点 2：语言 3：货币
  var currentConfig = getCurrentConfig(); //当前配置
  String subTitle; //二级菜单标题
  List linkURL;
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

  List<BottomLink> bottomLinkList;
  List<Child> bottomLinkChildList;

  String setAffiliateProgram() {
    Map<String, String> siteLinks = {
      'us': '/lego/influencer-142.html',
      'uk': '/lego/influencer-143.html',
      'fr': '/lego/influencer-144.html',
      'de': '/lego/influencer-145.html',
      'es': '/lego/influencer-146.html',
      'au': '/lego/influencer-147.html',
      'ca': '/lego/influencer-148.html',
      'global': '/lego/influencer-149.html'
    };
    if (currentConfig != null) {
      return siteLinks[currentConfig['site']] ?? siteLinks['us'];
    }
    return siteLinks['us'];
  }

  String setInfluencerProgram() {
    Map<String, String> siteLinks = {
      'us': '/lego/influencer-134.html',
      'uk': '/lego/influencer-135.html',
      'fr': '/lego/influencer-136.html',
      'de': '/lego/influencer-137.html',
      'es': '/lego/influencer-138.html',
      'au': '/lego/influencer-139.html',
      'ca': '/lego/influencer-140.html',
      'global': '/lego/influencer-141.html'
    };
    if (currentConfig != null) {
      return siteLinks[currentConfig['site']] ?? siteLinks['us'];
    }
    return siteLinks['us'];
  }

  void initLinkUrl() {
    String affiliateProgramUrl = setAffiliateProgram();
    String influencerProgramUrk = setInfluencerProgram();
    linkURL = [
      [
        '/help-center/article-detail/64',
        '/reviews',
        '/help-center/article-detail/65',
        '/help-center/article-detail/57',
        '/help-center/article-detail/58'
      ],
      [
        '/help-center',
        '/help-center/article-detail/61',
        '/help-center/category/5',
        '/help-center/article-detail/59'
      ],
      [
        '/help-center/article-detail/78',
        '/big-customer',
        affiliateProgramUrl,
        influencerProgramUrk
      ]
    ];
    if (currentConfig['site'] == 'us') {
      linkURL[2].removeAt(0);
    }
  }

  void setBbottomLinkList(List<String> titleList, List<String> childList) {
    initLinkUrl();
    List<BottomLink> bottomList = [];

    for (var i = 0; i < titleList.length; i++) {
      bottomLinkChildList = [];
      List arr = childList[i].split(',');
      print(arr);
      if (currentConfig['site'] == 'us' && i == 2) {
        arr.removeAt(0);
      }
      for (var j = 0; j < arr.length; j++) {
        bottomLinkChildList.add(Child(
            categoryName: arr[j],
            jumpUrl: 'https://m.homary.com${linkURL[i][j]}'));
      }
      bottomList
          .add(BottomLink(title: titleList[i], data: bottomLinkChildList));
    }

    bottomLinkList = bottomList;
  }

  void initBottomLink(context) {
    setBbottomLinkList([
      S.of(context).bottom_information_title,
      S.of(context).bottom_customer_title,
      S.of(context).bottom_b2b_title,
    ], [
      S.of(context).bottom_information_list,
      S.of(context).bottom_customer_list,
      S.of(context).bottom_b2b_list,
    ]);
    notifyListeners();
  }
}

class Child {
  String categoryName;
  String jumpUrl;
  Child({this.categoryName, this.jumpUrl});
}

class BottomLink {
  String title;
  List<Child> data;

  BottomLink({this.title, this.data});
}
