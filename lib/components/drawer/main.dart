/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-31 17:46:39
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/signIn/controller.dart';
import 'package:homary/pages/user/controller.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<GlobalConfig>(context, listen: false).getNavList();
      Provider.of<SlideNavCtrl>(context, listen: false).initBottomLink(context);
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
                            showArrow: data?.item1[index]?.subList != null &&
                                data?.item1[index].subList.length > 0,
                            jumpUrl: data?.item1[index]?.jumpUrl,
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
                                horizontal: 16.w, vertical: 16.w),
                            child: InkWell(
                              onTap: () {
                                Routes.push(context, '/webview', params: {
                                  "content":
                                      '{"url":"https://m.homary.com/appPages/customerService"}'
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(Iconfont.Customer),
                                  SizedBox(width: 17.5.w),
                                  Expanded(
                                      child: Text(
                                    'Customer Service',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  Icon(
                                    Icons.chevron_right,
                                    color: AppColor.primaryBorderLight,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: Offstage(
                            offstage: !Localstorage().getBool('isLogin'),
                            child: Container(
                              height: 40.w,
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              margin: EdgeInsets.only(top: 16.w, bottom: 16.w),
                              child: OutlinedButton(
                                onPressed: () async {
                                  await Provider.of<GlobalConfig>(context,
                                          listen: false)
                                      .signOut(context);
                                  Provider.of<SignInCtrl>(context,
                                          listen: false)
                                      .thirdLogout();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  S.of(context).sign_out_btn,
                                  style: TextStyle(color: AppColor.primaryText),
                                ),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))))),
                              ),
                            )),
                      ),
                      Selector<SlideNavCtrl, List>(
                        builder: (context, List bottomLinkList, child) =>
                            SliverList(
                                delegate:
                                    SliverChildBuilderDelegate((contex, index) {
                          return Container(
                              color: AppColor.primaryBackground,
                              child: ExpansionItem(
                                  list: bottomLinkList[index].data,
                                  title: bottomLinkList[index].title));
                        }, childCount: bottomLinkList?.length ?? 0)),
                        selector: (context, SlideNavCtrl slideNavCtrl) {
                          return slideNavCtrl.bottomLinkList;
                        },
                      ),
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
        ),
        ChangeNotifierProvider<SignInCtrl>(
          create: (context) => SignInCtrl(),
        ),
      ],
      child: GlobalDrawerView(),
    );
  }
}
