/*
 * @Author       : zhhjie
 * @Date         : 2021-08-23 10:55:22
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-14 11:35:34
 */
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:homary/common/config/packageInfo.dart';
import 'package:homary/common/utils/cache_clean.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/home_dialog.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/drawer/components/contactUs.dart';
import 'package:homary/components/drawer/components/navItem.dart';
import 'package:homary/components/drawer/components/slideNav/expansionItem.dart';
import 'package:homary/components/drawer/components/slideNav/main.dart';
import 'package:homary/components/drawer/controller.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/pages/signIn/controller.dart';
import 'package:homary/widget/listTileItem.dart';

class SettingView extends StatefulWidget {
  final String userID;
  SettingView({Key key, this.userID}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool subListToggle = false;
  String title = 'Setting';
  bool isLogin = Localstorage().getBool(StorageKey.IS_LOGIN);
  String user;
  String cacheSize = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<SlideNavCtrl>(context, listen: false).initBottomLink(context);
      String size = await CacheCleanUtil.getCacheSize();
      setState(() {
        user = isLogin ? widget.userID ?? '' : 'Login in/Sign up';
        cacheSize = size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GoBackAppBar(
            title: title,
            handleGoBackFn: () {
              if (this.subListToggle) {
                Provider.of<SlideNavCtrl>(context, listen: false)
                    .subListToggle();
                this.subListToggle = false;
                setState(() {
                  this.title = 'Setting';
                });
              } else {
                Routes.pop();
              }
            }),
        body: Stack(
          children: [
            CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                child: ListTileItem(
                  title: Text(user ?? '',
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    if (this.isLogin) {
                      Routes.push(context, '/webview', params: {
                        "appBarTitle": 'info',
                        "content":
                            '{"url":"https://m.homary.com/usercenter/personal"}'
                      });
                    } else {
                      Routes.push(context, '/signIn');
                    }
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                color: AppColor.primaryBackground,
                child: SizedBox(
                  height: 12.w,
                  width: double.infinity,
                ),
              )),
              Selector<GlobalConfig, List>(
                selector: (context, GlobalConfig globalConfig) {
                  return globalConfig.currentConfigList;
                },
                builder: (context, List data, child) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate((contex, index) {
                    return NavItem(
                      title: data[index]['title'],
                      subTitle: Text(data[index]['subTitle'] ?? '',
                          style:
                              TextStyle(color: AppColor.primaryLightSubTitle)),
                      padding:
                          EdgeInsets.only(left: 16.w, top: 18.w, bottom: 18.w),
                      margin: EdgeInsets.zero,
                      showArrow: true,
                      onTap: () {
                        this.subListToggle = true;
                        setState(() {
                          this.title = data[index]['title'];
                        });
                        Provider.of<SlideNavCtrl>(context, listen: false)
                            .setSubList(
                                data[index]['subList'], data[index]['title']);
                        Provider.of<SlideNavCtrl>(context, listen: false)
                            .subListToggle();
                        Provider.of<SlideNavCtrl>(context, listen: false)
                            .setConfig(data[index]['type']);
                      },
                    );
                  }, childCount: data?.length));
                },
              ),
              SliverToBoxAdapter(
                  child: Container(
                color: AppColor.primaryBackground,
                child: SizedBox(
                  height: 12.w,
                  width: double.infinity,
                ),
              )),
              Selector<SlideNavCtrl, List>(
                builder: (context, List bottomLinkList, child) => SliverList(
                    delegate: SliverChildBuilderDelegate((contex, index) {
                  return ExpansionItem(
                      icon: Icon(
                        Iconfont.ArrowRight,
                        size: 12.w,
                        color: AppColor.primaryBorderLight,
                      ),
                      showTickerModeBottomBorder: true,
                      childrenPadding: EdgeInsets.symmetric(vertical: 10.w),
                      // childrenStyle: TextStyle(
                      //     color: AppColor.primaryText,
                      //     fontWeight: FontWeight.bold),
                      childBorder: Border(),
                      needPop: false,
                      padding: EdgeInsets.only(
                          left: 16.w, bottom: 18.w, top: 18.w, right: 16.w),
                      margin: EdgeInsets.zero,
                      iconColor: AppColor.primaryBorderLight,
                      list: bottomLinkList[index].data,
                      title: bottomLinkList[index].title);
                }, childCount: bottomLinkList?.length ?? 0)),
                selector: (context, SlideNavCtrl slideNavCtrl) {
                  return slideNavCtrl.bottomLinkList;
                },
              ),
              ContactUs(
                backgroud: Colors.white,
                padding: EdgeInsets.fromLTRB(16.w, 18.w, 16.w, 18.w),
                margin: EdgeInsets.zero,
                icon: Icon(
                  Iconfont.ArrowRight,
                  size: 12.w,
                  color: AppColor.primaryBorderLight,
                ),
                iconColor: AppColor.primaryBorderLight,
              ),
              SliverToBoxAdapter(
                  child: Container(
                color: AppColor.primaryBackground,
                child: SizedBox(
                  height: 12.w,
                  width: double.infinity,
                ),
              )),
              SliverToBoxAdapter(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColor.primaryBorderBottomLine))),
                child: ListTileItem(
                  title: Text(S.of(context).setting_clearCache,
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontWeight: FontWeight.bold)),
                  desc: Text('$cacheSize'),
                  onTap: () async {
                    bool result = await AppDialog.showMessage(
                        context: context,
                        message: S.of(context).setting_cleanCacheTip);
                    if (result) {
                      await CacheCleanUtil.cleanCache();
                      String size = await CacheCleanUtil.getCacheSize();
                      setState(() {
                        this.cacheSize = size;
                      });
                    }
                  },
                ),
              )),
              SliverToBoxAdapter(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColor.primaryBorderBottomLine))),
                child: ListTileItem(
                  title: Text(S.of(context).setting_version,
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontWeight: FontWeight.bold)),
                  desc: Text('v${packageInfo.version}'),
                  onTap: () async {
                    HomeDialog.instance.getAppUpgrade(isFromSetting: true);
                  },
                ),
              )),
              SliverToBoxAdapter(
                  child: Offstage(
                offstage: !this.isLogin,
                child: Container(
                  margin: EdgeInsets.fromLTRB(60.w, 12.w, 60.w, 12.w),
                  child: OutlinedButton(
                      onPressed: () async {
                        await Provider.of<GlobalConfig>(context, listen: false)
                            .signOut(context);
                        Provider.of<SignInCtrl>(context, listen: false)
                            .thirdLogout();
                        setState(() {
                          this.isLogin = false;
                          this.user = 'Login in/Sign up';
                        });
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 16.w)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0.w),
                          )),
                          side: MaterialStateProperty.all(
                              BorderSide(color: AppColor.primaryColor))),
                      child: Text(
                        S.of(context).sign_out_btn,
                        style: TextStyle(fontSize: 14.sp),
                      )),
                ),
              )),
            ]),
            Selector<SlideNavCtrl, List>(
              selector: (context, SlideNavCtrl slideNavCtrl) {
                return slideNavCtrl.subNavList;
              },
              shouldRebuild: (pre, next) {
                return pre != next;
              },
              builder: (context, List data, child) {
                return SlideNav(
                  width: MediaQuery.of(context).size.width,
                  showHead: false,
                );
              },
            ),
          ],
        ));
  }
}

class Setting extends StatelessWidget {
  final String userID;
  const Setting({Key key, this.userID}) : super(key: key);

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
      child: SettingView(userID: userID),
    );
  }
}
