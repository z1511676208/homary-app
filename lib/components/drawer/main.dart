/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 16:22:43
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/generated/l10n.dart';
import 'package:tuple/tuple.dart';
import 'components/contactUs.dart';
import 'components/slideNav/main.dart';
import 'components/navItem.dart';
import 'controller.dart';
import 'components/slideNav/expansionItem.dart';

class GlobalDrawerView extends StatefulWidget {
  GlobalDrawerView({Key key}) : super(key: key);

  @override
  _GlobalDrawerViewState createState() => _GlobalDrawerViewState();
}

class _GlobalDrawerViewState extends State<GlobalDrawerView> {
  List<BottomLink> bottomLinkList;
  var currentConfig;
  void setBbottomLinkList(List<String> titleList, List<String> childList) {
    List<BottomLink> bottomList = [];
    for (var i = 0; i < titleList.length; i++) {
      bottomList.add(BottomLink(
          title: titleList[i],
          data: childList[i]
              .split(',')
              .map((e) => Child(categoryName: e))
              .toList()));
    }
    setState(() {
      bottomLinkList = bottomList;
    });
  }

  void initBottomLink() {
    setBbottomLinkList([
      S.of(context).bottom_information_title,
      S.of(context).bottom_customer_title,
      S.of(context).bottom_b2b_title,
    ], [
      S.of(context).bottom_information_list,
      S.of(context).bottom_customer_list,
      S.of(context).bottom_b2b_list,
    ]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      this.initBottomLink();
      await Provider.of<GlobalConfig>(context, listen: false).getNavList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
          child: Stack(
            children: [
              Selector<GlobalConfig, Tuple2<List, List>>(
                selector: (context, GlobalConfig globalConfig) {
                  return Tuple2(
                      globalConfig.navList, globalConfig.currentConfigList);
                },
                shouldRebuild: (pre, next) {
                  return pre != next;
                },
                builder: (context, Tuple2<List, List> data, child) {
                  return SafeArea(
                      child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                          delegate: SliverChildBuilderDelegate((contex, index) {
                        return NavItem(
                            index: index,
                            title: data?.item1[index]?.categoryName,
                            subList: data?.item1[index]?.subList,
                            isConfig: false);
                      }, childCount: data?.item1?.length)),
                      SliverToBoxAdapter(
                        child: Container(
                          color: AppColor.primaryBackground,
                          child: SizedBox(
                            height: 12.h,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate((contex, index) {
                        return NavItem(
                          trailing: index == 0
                              ? Icon(Iconfont.Site)
                              : index == 1
                                  ? Icon(Iconfont.Language)
                                  : Icon(Iconfont.Currency),
                          title: data?.item2[index]['title'],
                          subTitle: Text(data?.item2[index]['subTitle'] ?? '',
                              style: TextStyle(
                                  color: AppColor.primaryLightSubTitle)),
                          subList: data?.item2[index]['subList'],
                          isConfig: true,
                          configType: data?.item2[index]['type'],
                        );
                      }, childCount: data?.item2?.length)),
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5.w,
                                      color: AppColor.primaryBorderOutline))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 14.w),
                          child: Row(
                            children: [
                              Icon(Iconfont.Customer),
                              SizedBox(width: 17.5.w),
                              Expanded(
                                  child: Text(
                                'Customer Service',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              Icon(
                                Icons.chevron_right,
                                color: AppColor.primaryBorderLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Offstage(
                            offstage: !Localstorage().getBool('isLogin'),
                            child: Container(
                              height: 40.h,
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              margin: EdgeInsets.only(top: 16.w, bottom: 16.w),
                              child: OutlinedButton(
                                onPressed: () {
                                  Provider.of<GlobalConfig>(context,
                                          listen: false)
                                      .signOut();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(color: AppColor.primaryText),
                                ),
                              ),
                            )),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate((contex, index) {
                        return Container(
                            color: AppColor.primaryBackground,
                            child: ExpansionItem(
                                list: bottomLinkList[index].data,
                                title: bottomLinkList[index].title));
                      }, childCount: bottomLinkList?.length ?? 0)),
                      ContactUs()
                    ],
                  ));
                },
              ),
              Selector<SlideNavCtrl, List>(
                selector: (context, SlideNavCtrl slideNavCtrl) {
                  return slideNavCtrl.subNavList;
                },
                shouldRebuild: (pre, next) {
                  return pre != next;
                },
                builder: (context, List data, child) {
                  return SlideNav();
                },
              ),
            ],
          ),
        ));
  }
}

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SlideNavCtrl>(
          create: (context) => SlideNavCtrl(),
        )
      ],
      child: GlobalDrawerView(),
    );
  }
}

class Child {
  String categoryName;
  Child({this.categoryName});
}

class BottomLink {
  String title;
  List<Child> data;
  BottomLink({this.title, this.data});
}
