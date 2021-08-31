import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/widget/cartAndNumber.dart';
import 'package:homary/widget/wishIconButton.dart';
import 'components/FlexItem.dart';
import 'components/ExpandedItem.dart';
import 'components/PaddingItem.dart';
import 'controller.dart';

class UserPageView extends StatefulWidget {
  UserPageView({Key key}) : super(key: key);

  @override
  _UserPageViewState createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView> {
  bool isLogin = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var isLoginConfig = Provider.of<GlobalConfig>(context).isLogin;
    if (isLoginConfig != null && this.isLogin != isLoginConfig) {
      this.isLogin = isLoginConfig;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          if (this.isLogin) {
            Provider.of<UserCtrl>(context, listen: false).userCenter();
            Provider.of<UserCtrl>(context, listen: false).getRecentlyBrowsed();
          } else {
            Provider.of<UserCtrl>(context, listen: false).init();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          if (this.isLogin) {
            await Provider.of<UserCtrl>(context, listen: false).userCenter();
            await Provider.of<UserCtrl>(context, listen: false)
                .getRecentlyBrowsed();
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
                child: Consumer<UserCtrl>(
                    builder: (context, data, child) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 100,
                                  child: Row(
                                    children: <Widget>[
                                      WishIconButton(),
                                      CartAndNumber()
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Routes.push(context, '/setting', params: {
                                        "userID": data
                                            .userCenterInfo?.userIdentification
                                      });
                                    },
                                    icon: Icon(
                                      Iconfont.Setting,
                                      size: 20.w,
                                    ))
                              ],
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16.w),
                                child: isLogin && isLogin != null
                                    ? Text(
                                        "Hi, ${data.userCenterInfo?.userIdentification ?? ''}",
                                        style: TextStyle(
                                            fontSize: 20.w,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          Routes.push(context, '/signIn');
                                        },
                                        child: Text(
                                          '${S.of(context).usercenter_SignInAndRegister} >',
                                          style: TextStyle(
                                              fontSize: 20.w,
                                              color: AppColor.primaryText,
                                              fontWeight: FontWeight.bold),
                                        ))),
                            Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                ExpandedItem(
                                  data.userCenterInfo?.couponCount ?? 0,
                                  S.of(context).usercenter_coupons,
                                  url: '/usercenter/coupons',
                                  appBarTitle: S.of(context).usercenter_coupons,
                                ),
                                ExpandedItem(
                                  data.userCenterInfo?.goodsCollectionCount ??
                                      0,
                                  S.of(context).usercenter_wishlists,
                                  url: '/usercenter/wishlists',
                                ),
                                ExpandedItem(
                                    data.userCenterInfo?.userViewCount ?? 0,
                                    S.of(context).usercenter_views,
                                    appBarTitle: S.of(context).usercenter_views,
                                    url: '/usercenter/viewed')
                              ],
                            ),
                            PadingItem(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12.0, 12.w, 12.0, 0),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).usercenter_myOrder,
                                    style: TextStyle(
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        bool isLogin =
                                            Localstorage().getBool('isLogin');
                                        if (isLogin) {
                                          Routes.push(context, '/webview',
                                              params: {
                                                "appBarTitle": 'My Orders',
                                                "content":
                                                    '{"url":"https://m.homary.com/usercenter/order"}'
                                              });
                                        } else {
                                          Routes.push(context, '/signIn');
                                        }
                                      },
                                      child: Text(
                                        '${S.of(context).usercenter_viewAll} >',
                                        style: TextStyle(
                                            fontSize: 12.w,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1)),
                                      ))
                                ],
                              ),
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                FlexItem(
                                  S.of(context).usercenter_unpaid,
                                  Image.asset(
                                    'assets/images/user/user_unpaid.png',
                                    width: 34.w,
                                    height: 34.w,
                                  ),
                                  count: data.userCenterInfo?.unpaidOrderCount,
                                  url: '/usercenter/order?active=unpaid',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_processing,
                                  Image.asset(
                                    'assets/images/user/user_processing.png',
                                    width: 34.w,
                                    height: 34.w,
                                  ),
                                  count:
                                      data.userCenterInfo?.processingOrderCount,
                                  url: '/usercenter/order?active=undelivery',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_shipped,
                                  Image.asset(
                                    'assets/images/user/user_shipped.png',
                                    width: 34.w,
                                    height: 34.w,
                                  ),
                                  count: data.userCenterInfo?.shippedOrderCount,
                                  url: '/usercenter/order?active=shipped',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_returns,
                                  Image.asset(
                                    'assets/images/user/user_returns.png',
                                    width: 34.w,
                                    height: 34.w,
                                  ),
                                  count: data.userCenterInfo?.returnOrderCount,
                                  url: '/usercenter/order?active=returns',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                              ],
                            ),
                            PadingItem(),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(12.0, 18.w, 12.0, 8.w),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).usercenter_moreServices,
                                    style: TextStyle(
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                FlexItem(
                                  S.of(context).usercenter_customer,
                                  Icon(Iconfont.Customer, size: 34.w),
                                  url: '/appPages/customerService',
                                  needLogin: false,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_about,
                                  Icon(Iconfont.About, size: 34.w),
                                  url: '/help-center/article-detail/64',
                                  title: S.of(context).help_center,
                                  needLogin: false,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_address,
                                  Icon(Iconfont.Address, size: 34.w),
                                  url: '/address',
                                  title: S.of(context).address_book,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_personal,
                                  Icon(Iconfont.Personal, size: 34.w),
                                  url: '/usercenter/personal',
                                  title: 'Info',
                                ),
                              ],
                            ),
                            PadingItem(),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(12, 18.w, 12.0, 4.w),
                              child: Text(
                                S.of(context).usercenter_recentlyBrowsed,
                                style: TextStyle(
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            data.recentlyList.length == 0
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 24.w,
                                      ),
                                      Text(
                                        S.of(context).usercenter_noRecently,
                                        style: TextStyle(
                                            fontSize: 12.w,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1)),
                                      ),
                                      SizedBox(
                                        height: 16.w,
                                      ),
                                      TextButton(
                                        child: Text(
                                          isLogin
                                              ? S
                                                  .of(context)
                                                  .usercenter_goShopping
                                              : S.of(context).login_signIn,
                                          style: TextStyle(
                                              color: AppColor.primaryText),
                                        ),
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.fromLTRB(
                                                    30.w, 12.w, 30.w, 12.w)),
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    AppColor.primaryPressed),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                              color:
                                                  Color.fromRGBO(34, 34, 34, 1),
                                              width: 1,
                                            )),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(36.w),
                                            ))),
                                        onPressed: () {
                                          if (isLogin) {
                                            Routes.goHome();
                                          } else {
                                            Routes.push(context, '/signIn');
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 40.w,
                                      ),
                                    ],
                                  )
                                : CustomScrollView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    slivers: [
                                      GoodsCartSliverGrid(
                                        productList: data.recentlyList,
                                      ),
                                    ],
                                  ),
                            data.hasMorePage == 1
                                ? Container(
                                    width: 100.w,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20.w),
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                vertical: 10.w)),
                                        side: MaterialStateProperty.all(
                                            BorderSide(
                                                color:
                                                    AppColor.primaryBorderHard,
                                                width: 1.w)),
                                      ),
                                      child: data.isLoading == false
                                          ? Text(
                                              S.of(context).home_viewMore,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColor.primaryText),
                                            )
                                          : SizedBox(
                                              width: 20.w,
                                              height: 20.w,
                                              child: CircularProgressIndicator(
                                                color: AppColor.primaryText,
                                                strokeWidth: 2.w,
                                              ),
                                            ),
                                      onPressed: () {
                                        data.handleGetMoreProduct();
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        )))));
  }
}

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserCtrl>(
          create: (context) => UserCtrl(),
        )
      ],
      child: UserPageView(),
    );
  }
}
