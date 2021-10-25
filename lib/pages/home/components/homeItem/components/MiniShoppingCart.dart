/*
 * @Author       : JHao
 * @Date         : 2021-10-13 17:38:00
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-20 18:41:20
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/cartAndNumber.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:tuple/tuple.dart';

class MiniShoppingCart extends StatefulWidget {
  MiniShoppingCart({Key key}) : super(key: key);

  @override
  _MiniShoppingCartState createState() => _MiniShoppingCartState();
}

class _MiniShoppingCartState extends State<MiniShoppingCart> {
  double _alignmentX = 0;
  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;

    setState(() {
      _alignmentX = (metrics.pixels / metrics.maxScrollExtent) * (32.w - 16.w);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, Tuple3<List<ShoppingCart>, int, Summary>>(
      builder: (BuildContext context,
          Tuple3<List<ShoppingCart>, int, Summary> data, child) {
        return data.item1 != null && data.item1.length > 0
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 16.w, 12.w, 0),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppStyle.borderRaduis8,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryBorderShadow,
                        blurRadius: 6.w,
                        spreadRadius: 1.w,
                        offset: Offset(0.w, 2.w),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NotificationListener(
                          onNotification: _handleScrollNotification,
                          child: SizedBox(
                              height: 107.w,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return index == data.item1.length
                                      ? GestureDetector(
                                          onTap: () {
                                            sendGTMData({
                                              "event": 'custom_click_cart',
                                              "ecommerce": {
                                                "event_label": 'home_cart_1_0'
                                              }
                                            });
                                            Localstorage().setGaTicketList(
                                                TicketList.cart);
                                            Routes.push(
                                                context, '/shoppingcart');
                                          },
                                          child: Container(
                                            width: 107.w,
                                            height: 107.w,
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColor.primaryBackground,
                                                borderRadius:
                                                    AppStyle.borderRaduis8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IgnorePointer(
                                                  child: CartAndNumber(
                                                    backgroundColor:
                                                        AppColor.primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  S.of(context).home_view_cart,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColor.primaryText),
                                                )
                                              ],
                                            ),
                                          ))
                                      : GestureDetector(
                                          onTap: () {
                                            sendGTMData({
                                              "event": 'custom_click_cart',
                                              "ecommerce": {
                                                "event_label":
                                                    'home_cart_1_${data.item1[index].skuId}'
                                              }
                                            });
                                            Localstorage().setGaTicketList(
                                                TicketList.cart);
                                            Routes.push(
                                                context, '/shoppingcart');
                                          },
                                          child: Container(
                                            width: 107.w,
                                            height: 107.w,
                                            margin: EdgeInsets.only(right: 8.w),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColor.primaryBackground,
                                                borderRadius:
                                                    AppStyle.borderRaduis8),
                                            child: CustomNetworkImage(
                                              data.item1[index].img,
                                              width: 107.w,
                                              height: 107.w,
                                            ),
                                          ));
                                },
                                itemCount: data.item1.length + 1,
                              ))),
                      data.item1.length >= 3
                          ? Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 32.w,
                                    height: 4.w,
                                    margin: EdgeInsets.only(top: 8.w),
                                    decoration: BoxDecoration(
                                        color: AppColor.scrollBarBgColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.w))),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: _alignmentX,
                                    child: Container(
                                      width: 16.w,
                                      height: 4.w,
                                      margin: EdgeInsets.only(top: 8.w),
                                      decoration: BoxDecoration(
                                          color: AppColor.scrollBarColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.w))),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 8.w,
                            ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            children: [
                              Icon(
                                Iconfont.Cart,
                                color: AppColor.primaryText,
                                size: 14.sp,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                '${S.of(context).home_your_cart(data.item2 ?? 0)}：',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.primaryText),
                              ),
                              Text(
                                data.item3.subtotal ?? '',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.primaryText),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    sendGTMData({
                                      "event": 'custom_click_cart',
                                      "ecommerce": {
                                        "event_label": 'home_cart_2_0'
                                      }
                                    });
                                    Localstorage()
                                        .setGaTicketList(TicketList.cart);
                                    Routes.push(context, '/shoppingcart');
                                  },
                                  child: Text(
                                    S.of(context).home_cart_checkout,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColor.primaryText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: AppColor.primaryText),
                                  ))
                            ],
                          )),
                      SizedBox(
                        height: 8.w,
                      )
                    ],
                  ),
                ))
            : SizedBox();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return Tuple3(homeData.shoppingCartData, homeData.shoppingCartNum,
            homeData.shoppingCartSummary);
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}
