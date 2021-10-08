import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/button/button.dart';
import 'package:homary/pages/shoppingCart/components/EtaInput.dart';
import 'package:homary/pages/shoppingCart/components/coupon.dart';
import 'package:homary/pages/shoppingCart/controller.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ShoppingCartSummary extends StatelessWidget {
  const ShoppingCartSummary({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    return Consumer<ShoppingCartCtrl>(builder: (_, ctrl, __) {
      return SliverToBoxAdapter(
        child: ctrl.total != null && ctrl.shoppingCart.length != 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CouponInput(),
                  SizedBox(height: 20.w),
                  Text(
                    S.of(context).shopping_cart_order_summary(
                        ctrl.shoppingCart?.length ?? 0),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  ...(ctrl.orderSummary ?? []).map((e) {
                    if (e.identifying == 'shipping_fee') {
                      return Container();
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            e.amount,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: HexColor(e.color),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 30.w),
                  EtaInput(),
                  Container(
                    margin: EdgeInsets.only(top: 16.w, bottom: 16.w),
                    height: 1.w,
                    color: AppColor.primaryBorderBottomLine,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${ctrl.total.name}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${ctrl.total.amount}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: HexColor(ctrl.total.color),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.w),
                  VisibilityDetector(
                    key: Key('check-out'),
                    onVisibilityChanged: (visibilityInfo) {
                      var visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage == 0) {
                        ctrl.setBottomCheckout(true);
                      } else {
                        ctrl.setBottomCheckout(false);
                      }
                    },
                    child: AppRoundedButton(
                      width: double.infinity,
                      height: 44.w,
                      onTap: () => ctrl.handleCheckout(
                          eventName: "shippingcart_block_checkout_click"),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconfont.LockSharp2,
                            size: 14.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            S.of(context).shopping_cart_check_out_now,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    S.of(context).shopping_cart_we_accept,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.5.w),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 3.w,
                    runSpacing: 6.w,
                    children: (ctrl.payMethodIconList ?? []).map((e) {
                      return CustomNetworkImage(
                        e.iconSmall,
                        width: 50.w,
                        height: 30.w,
                        fit: BoxFit.fill,
                      );
                    }).toList(),
                  ),
                ],
              )
            : Container(),
      );
    });
  }
}
