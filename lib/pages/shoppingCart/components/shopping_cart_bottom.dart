import 'package:homary/common/utils/main.dart';
import 'package:homary/components/button/button.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class ShoppingCartBottom extends StatelessWidget {
  const ShoppingCartBottom({Key key, this.parentContext}) : super(key: key);
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartCtrl>(
      builder: (_, ctrl, __) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: ctrl.isShowBottomCheckout &&
                  ctrl.shoppingCart != null &&
                  ctrl.shoppingCart.isNotEmpty
              ? 117.w + MediaQuery.of(parentContext).padding.bottom
              : 0.w,
          padding: EdgeInsets.only(
            top: 8.w,
            left: 12.w,
            right: 12.w,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryBorderShadow,
                blurRadius: 4.w,
                spreadRadius: 1.w,
                offset: Offset(1.w, 1.w),
              )
            ],
          ),
          child: ListView(
            children: [
              Text(
                S.of(context).shopping_cart_order_ships_free,
                style: TextStyle(
                  color: AppColor.cartHintColor,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 4.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).shopping_cart_subtotal,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${ctrl.summary?.subtotal}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.w),
              AppRoundedButton(
                width: double.infinity,
                height: 44.w,
                onTap: () => ctrl.handleCheckout(
                    eventName: "shippingcart_bottom_checkout_click"),
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
            ],
          ),
        );
      },
    );
  }
}
