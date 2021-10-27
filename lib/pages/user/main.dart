import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/provider/auth_ctrl.dart';
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

    var isLoginConfig = Provider.of<AuthCtrl>(context).isLogin;
    if (isLoginConfig != null && this.isLogin != isLoginConfig) {
      this.isLogin = isLoginConfig;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (mounted) {
          if (this.isLogin) {
            Toast.loading();
            await Provider.of<UserCtrl>(context, listen: false).userCenter();
            Toast.clear();
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
    UserCtrl data = context.watch<UserCtrl>();
    return SafeArea(
      child: PullToRefresh(
        controller: data.refreshController,
        enablePullUp: this.isLogin && data.recentlyList.length > 0,
        onLoading: () async {
          await data.handleGetMoreProduct();
        },
        onRefresh: () async {
          if (this.isLogin) {
            await data.userCenter();
            await data.getRecentlyBrowsed();
          }
          data.refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      children: <Widget>[WishIconButton(), CartAndNumber()],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Routes.push(context, '/setting', params: {
                          "userID": data.userCenterInfo?.userIdentification
                        });
                      },
                      icon: Icon(
                        Iconfont.Setting,
                        size: 21.w,
                        color: AppColor.primaryText,
                      ))
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16.w),
                  child: isLogin ?? false
                      ? Text(
                          "Hi, ${data.userCenterInfo?.userIdentification ?? ''}",
                          style: TextStyle(
                              fontSize: 20.w, fontWeight: FontWeight.bold),
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
                    data.userCenterInfo?.goodsCollectionCount ?? 0,
                    S.of(context).usercenter_wishlists,
                    url: '/usercenter/wishlists',
                  ),
                  ExpandedItem(data.userCenterInfo?.userViewCount ?? 0,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).usercenter_myOrder,
                      style: TextStyle(
                          fontSize: 16.w, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {
                          bool isLogin =
                              Localstorage().getBool(StorageKey.IS_LOGIN);
                          if (isLogin) {
                            Routes.push(context, Routes.myOrders);
                          } else {
                            Routes.push(context, '/signIn');
                          }
                        },
                        child: Text(
                          '${S.of(context).usercenter_viewAll} >',
                          style: TextStyle(
                              fontSize: 12.w,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                        ))
                  ],
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    count: data.userCenterInfo?.processingOrderCount,
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
                padding: EdgeInsets.fromLTRB(12.0, 18.w, 12.0, 8.w),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).usercenter_moreServices,
                      style: TextStyle(
                          fontSize: 16.w, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlexItem(
                    S.of(context).usercenter_customer,
                    Icon(Iconfont.Customer, size: 34.w),
                    url: 'https://m.homary.com/appPages/customerService',
                    needLogin: false,
                  ),
                  FlexItem(
                    S.of(context).usercenter_about,
                    Icon(Iconfont.About, size: 34.w),
                    url: 'https://m.homary.com/help-center/article-detail/64',
                    title: S.of(context).help_center,
                    needLogin: false,
                  ),
                  FlexItem(
                    S.of(context).usercenter_address,
                    Icon(Iconfont.Address, size: 34.w),
                    url: 'https://m.homary.com/address',
                    title: S.of(context).address_book,
                  ),
                  FlexItem(
                    S.of(context).usercenter_account_setting,
                    Icon(Iconfont.Personal, size: 34.w),
                    url: '/usercenter/account-setting',
                    title: '',
                  ),
                ],
              ),
              PadingItem(),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(12, 18.w, 12.0, 4.w),
                child: Text(
                  S.of(context).usercenter_recentlyBrowsed,
                  style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w600),
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
                              color: Color.fromRGBO(153, 153, 153, 1)),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        TextButton(
                          child: Text(
                            isLogin
                                ? S.of(context).usercenter_goShopping
                                : S.of(context).login_signIn,
                            style: TextStyle(color: AppColor.primaryText),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(30.w, 12.w, 30.w, 12.w)),
                              overlayColor: MaterialStateProperty.all(
                                  AppColor.primaryPressed),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Color.fromRGBO(34, 34, 34, 1),
                                width: 1,
                              )),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36.w),
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
                          showDelete: true,
                          productList: data.recentlyList,
                          onDelete: (id) async {
                            bool res = await AppDialog.showMessage(
                                context: context,
                                message: S.of(context).user_viewed_del_tips);
                            if (res ?? false) {
                              data.handleDelFootPrint(params: {"sku_id": id});
                            }
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
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
