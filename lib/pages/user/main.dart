import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
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
        // Provider.of<UserCtrl>(context, listen: false).userCenter();
        Provider.of<UserCtrl>(context, listen: false).getRecentlyBrowsed();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: new Container(
                width: double.infinity,
                // height: double.infinity,
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                //测试Row对齐方式，排除Column默认居中对齐的干扰
                child: Consumer<UserCtrl>(
                    builder: (context, data, child) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new Container(
                                  width: 46.w,
                                  height: 46.h,
                                  padding: EdgeInsets.only(right: 15.w),
                                  child: IconButton(
                                      color: Colors.black,
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {
                                        Routes.push(context, '/webview',
                                            params: {
                                              "content":
                                                  '{"url":"http://m.homary.com/usercenter/wishlists"}'
                                            });
                                      }),
                                ),
                                IconButton(
                                    color: Colors.black,
                                    icon: Icon(Iconfont.Cart),
                                    onPressed: () async {
                                      Routes.push(context, '/webview', params: {
                                        "showAppLoading": '0',
                                        "content":
                                            '{"url":"https://m.homary.com/shoppingcart"}'
                                      });
                                    })
                              ],
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16.w),
                                child: isLogin
                                    ? Text(
                                        "Hi, ${data.userCenterInfo?.userIdentification}",
                                        style: TextStyle(
                                            fontSize: 20.w,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          Routes.push(context, '/signIn');
                                        },
                                        child: Text(
                                          'SIGN IN / REGISTER >',
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
                                    'Coupons',
                                    appBarTitle: 'My Coupons',
                                    url: '/usercenter/coupons'),
                                ExpandedItem(
                                    data.userCenterInfo?.goodsCollectionCount ??
                                        0,
                                    'Wishlist',
                                    url: '/usercenter/wishlists'),
                                ExpandedItem(
                                    data.userCenterInfo?.pointCount ?? 0,
                                    'Views',
                                    appBarTitle: 'My Viewed',
                                    url: '/usercenter/viewed')
                              ],
                            ),
                            PadingItem(),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 16.0, 12.0, 16.0),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'My Order',
                                        style: TextStyle(
                                            fontSize: 16.w,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Routes.push(context, '/webview',
                                                params: {
                                                  "appBarTitle": "My Orders",
                                                  "content":
                                                      '{"url":"https://m.homary.com/usercenter/order"}'
                                                });
                                          },
                                          child: Text(
                                            'View All >',
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
                                      'Unpaid',
                                      Icon(Iconfont.Unpaid, size: 30.0),
                                      count:
                                          data.userCenterInfo?.unpaidOrderCount,
                                      url: '/usercenter/order?active=unpaid',
                                      title: 'My Orders',
                                    ),
                                    FlexItem(
                                      'Processing',
                                      Icon(Iconfont.Processing, size: 30.0),
                                      count: data
                                          .userCenterInfo?.processingOrderCount,
                                      url:
                                          '/usercenter/order?active=undelivery',
                                      title: 'My Orders',
                                    ),
                                    FlexItem(
                                      'Shipped',
                                      Icon(Iconfont.Shipped, size: 30.0),
                                      count: data
                                          .userCenterInfo?.shippedOrderCount,
                                      url: '/usercenter/order?active=shipped',
                                      title: 'My Orders',
                                    ),
                                    FlexItem(
                                      'Returns',
                                      Icon(Iconfont.Returns, size: 30.0),
                                      count:
                                          data.userCenterInfo?.returnOrderCount,
                                      url: '/usercenter/order?active=returns',
                                      title: 'My Orders',
                                    ),
                                  ],
                                )
                              ],
                            ),
                            PadingItem(),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 16.0, 12.0, 16.0),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'More Services',
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
                                      'Customer',
                                      Icon(Iconfont.Customer, size: 30.0),
                                      url: '/AppCustomerService',
                                    ),
                                    FlexItem(
                                      'About',
                                      Icon(Iconfont.About, size: 30.0),
                                      url: '/help-center/article-detail/64',
                                      title: "Help Center",
                                    ),
                                    FlexItem(
                                      'Address',
                                      Icon(Iconfont.Address, size: 30.0),
                                      url: '/address',
                                      title: 'Address Book',
                                    ),
                                    FlexItem(
                                      'Personal',
                                      Icon(Iconfont.Personal, size: 30.0),
                                      url: '/usercenter/personal',
                                      title: 'Info',
                                    ),
                                  ],
                                )
                              ],
                            ),
                            PadingItem(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 16.0, 12.0, 16.0),
                                      child: Text(
                                        "Recently Browsed",
                                        style: TextStyle(
                                            fontSize: 16.w,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "You have not saved anything recently.",
                                        style: TextStyle(
                                            fontSize: 12.w,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1)),
                                      )
                                    ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 16.h,
                                    ),
                                    FlatButton(
                                      child: Text("Go Shopping"),
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color:
                                                Color.fromRGBO(34, 34, 34, 1),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      onPressed: () {},
                                    ),
                                    Container(
                                      height: 40.h,
                                    ),
                                  ],
                                ),
                                PadingItem()
                              ],
                            )
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
