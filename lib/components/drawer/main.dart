/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 15:15:50
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';

import 'package:tuple/tuple.dart';
import 'components/slideNav/main.dart';
import 'components/navItem.dart';
import 'controller.dart';
import 'components/slideNav/expansionItem.dart';

class Child {
  String categoryName;
  Child({this.categoryName});
}

class BottomLink {
  String title;
  List<Child> data;
  BottomLink({this.title, this.data});
}

class GlobalDrawerView extends StatefulWidget {
  GlobalDrawerView({Key key}) : super(key: key);

  @override
  _GlobalDrawerViewState createState() => _GlobalDrawerViewState();
}

class _GlobalDrawerViewState extends State<GlobalDrawerView> {
  List<BottomLink> arr;
  @override
  void initState() {
    super.initState();
    arr = [
      BottomLink(title: 'test', data: [Child(categoryName: 'test')])
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GlobalConfig>(context, listen: false).getNavList();
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
                              ? Icon(Iconfont.site)
                              : index == 1
                                  ? Icon(Iconfont.language)
                                  : Icon(Iconfont.currency),
                          title: data?.item2[index]['title'],
                          subTitle: Text(data?.item2[index]['subTitle'],
                              style: TextStyle(
                                  color: AppColor.primaryLightSubTitle)),
                          subList: data?.item2[index]['subList'],
                          isConfig: true,
                          configType: data?.item2[index]['type'],
                        );
                      }, childCount: data?.item2?.length)),
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
                                list: arr[index].data,
                                title: arr[index].title));
                      }, childCount: arr.length)),
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
