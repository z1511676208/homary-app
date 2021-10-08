import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/components/button/button.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/pages/shoppingCart/components/product/product_detail_content.dart';
import 'package:homary/pages/shoppingCart/components/product/product_detail_controller.dart';
import 'package:homary/pages/shoppingCart/components/product/product_detail_skeletons.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class ProductDetailSheet extends StatelessWidget {
  const ProductDetailSheet({
    Key key,
    this.shoppingCartCount,
    this.item,
  }) : super(key: key);
  final int shoppingCartCount;
  final ShoppingCart item;

  void fullDetail(BuildContext context) {
    sendGTMData({
      "event": "full_details_from_quickview",
      "ecommerce": {"non_interaction": false, "sku_id": item.skuId}
    }, isCustomEvent: true);
    handleSchema(context, item.jumpUrl);
  }

  void checkOut(BuildContext context) {
    sendGTMData({
      "event": "cart_checkout_from_quickview",
      "ecommerce": {"non_interaction": false, "sku_id": item.skuId}
    }, isCustomEvent: true);
    context.read<ShoppingCartCtrl>().handleCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailCtrl(item,context),
      child: SafeArea(
        child: Container(
          height: 0.8.sh,
          child: Column(
            children: [
              buildSheetTitle(context),
              Selector<ProductDetailCtrl, bool>(
                builder: (context, bool isLoading, child) {
                  return isLoading
                      ? ProductDetailSkeletons()
                      : Expanded(
                          child: Column(
                          children: [
                            Expanded(child: ProductDetailContent()),
                            buildSheetBottom(context),
                          ],
                        ));
                },
                selector: (context, ProductDetailCtrl ctrl) {
                  return ctrl.isLoading;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheetTitle(BuildContext context) {
    return Container(
      height: 50.w,
      child: Stack(
        children: [
          Center(
            child: Text(
              S.of(context).product_detail,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: Image.asset(
                  'assets/images/home/popup_close.png',
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSheetBottom(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x10000000),
              offset: Offset(0, -1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10.5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppRoundedButton(
              width: 171.w,
              height: 44.w,
              type: AppRoundedButtonType.Stroke,
              onTap: () => fullDetail(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).product_detail_full_detail,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Image.asset(
                    'assets/images/cart/cart_tabbar_details.png',
                    width: 12.w,
                    height: 12.w,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.5.w),
            AppRoundedButton(
              width: 171.w,
              height: 44.w,
              onTap: () => checkOut(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).product_detail_items(shoppingCartCount ?? 0),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    S.of(context).product_detail_cart_checkout,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
