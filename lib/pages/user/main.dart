import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
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
  bool isLogin;

  @override
  void didChangeDependencies() {
    setState(() {
      this.isLogin = Localstorage().getBool('isLogin') ?? false;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (this.isLogin) {
        Provider.of<UserCtrl>(context, listen: false).userCenter();
        Provider.of<UserCtrl>(context, listen: false).getRecentlyBrowsed();
      }
    });
    super.didChangeDependencies();
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
                                      Routes.push(context, '/setting');
                                    },
                                    icon: Icon(Icons.settings))
                              ],
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16.w),
                                child: isLogin
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
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 16.0, 12.0, 16.0),
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
                                                "showAppLoading": '0',
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
                                  Icon(Iconfont.Unpaid, size: 30.0),
                                  count: data.userCenterInfo?.unpaidOrderCount,
                                  url: '/usercenter/order?active=unpaid',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_processing,
                                  Icon(Iconfont.Processing, size: 30.0),
                                  count:
                                      data.userCenterInfo?.processingOrderCount,
                                  url: '/usercenter/order?active=undelivery',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_shipped,
                                  Icon(Iconfont.Shipped, size: 30.0),
                                  count: data.userCenterInfo?.shippedOrderCount,
                                  url: '/usercenter/order?active=shipped',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_returns,
                                  Icon(Iconfont.Returns, size: 30.0),
                                  count: data.userCenterInfo?.returnOrderCount,
                                  url: '/usercenter/order?active=returns',
                                  title: S.of(context).usercenter_myOrder,
                                ),
                              ],
                            ),
                            PadingItem(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 16.0, 12.0, 16.0),
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
                                  Icon(Iconfont.Customer, size: 30.0),
                                  url: '/appPages/customerService',
                                  needLogin: false,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_about,
                                  Icon(Iconfont.About, size: 30.0),
                                  url: '/help-center/article-detail/64',
                                  title: S.of(context).help_center,
                                  needLogin: false,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_address,
                                  Icon(Iconfont.Address, size: 30.0),
                                  url: '/address',
                                  title: S.of(context).help_center,
                                ),
                                FlexItem(
                                  S.of(context).usercenter_personal,
                                  Icon(Iconfont.Personal, size: 30.0),
                                  url: '/usercenter/personal',
                                  title: 'Info',
                                ),
                              ],
                            ),
                            PadingItem(),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 16.0, 12.0, 16.0),
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
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w)),
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
                                                  BorderRadius.circular(20.0),
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
                                : Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.w, 0, 10.w, 10.w),
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      clipBehavior: Clip.none,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8.w,
                                        crossAxisSpacing: 8.w,
                                        childAspectRatio:
                                            ((1.sw - 24.w) / 2) / 268.w,
                                      ),
                                      itemBuilder: (context, index) {
                                        return GoodsCard(
                                          key: UniqueKey(),
                                          width: (1.sw - 24.w) / 2,
                                          data: data.recentlyList[index],
                                          showCorner: false,
                                          showSkuList: false,
                                          showFreeShipping: false,
                                          showRating: false,
                                        );
                                      },
                                      itemCount: data.recentlyList.length,
                                    ),
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
                            PadingItem()
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
