import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/cart_change_res.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/pages/shoppingCart/components/count_select.dart';
import 'package:homary/pages/shoppingCart/components/product/product_detail_sheet.dart';
import 'package:homary/pages/shoppingCart/controller.dart';
import 'package:homary/widget/networkImg.dart';

class ShoppingCartItem extends StatefulWidget {
  final ShoppingCart data;
  final bool isFromCart;

  const ShoppingCartItem({Key key, this.data, this.isFromCart})
      : super(key: key);

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  /// 数量错误提示，当请求接口修改数量后接口返回错误后改变
  String qtyError;

  ShoppingCart get data => widget.data;

  Color get textColor =>
      isCanQty ? AppColor.primaryText : AppColor.primaryLightSubTitle;

  Color get priceColor => AppColor.offPriceColor;

  /// 是否可修改数量
  bool get isCanQty =>
      data.checkStatus == 1 ||
      (data.checkStatus == 3 && data.activityStock > 0);

  /// 是否显示发货时间
  bool get isShowDeliveryTime =>
      data.checkStatus == 1 &&
      data.deliveryTime != null &&
      data.deliveryTime.isNotEmpty;

  String get attr => data.attrGroup.entries
      .map((e) => '${e.key}:${e.value}')
      .toList()
      .join('  ');

  void showProductDetail(BuildContext context) {
    sendGTMData({
      "event": "click_item_from_cart",
      "ecommerce": {
        "non_interaction": false,
        "sku_id": data.skuId,
      }
    }, isCustomEvent: true);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.w),
          topRight: Radius.circular(8.w),
        ),
      ),
      builder: (BuildContext _) {
        return ProductDetailSheet(
          item: data,
          shoppingCartCount:
              context.read<ShoppingCartCtrl>().shoppingCart.length,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 16.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => showProductDetail(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 124.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 商品图片
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              ClipRRect(
                                borderRadius: AppStyle.primaryBorderRaduis,
                                child: CustomNetworkImage(
                                  data.img,
                                  width: 124.w,
                                  height: 124.w,
                                ),
                              ),
                              if (!isCanQty)
                                Container(
                                  height: 82.w,
                                  width: 82.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0x99000000),
                                    borderRadius: BorderRadius.circular(41.w),
                                  ),
                                  child: AutoSizeText(
                                    S.of(context).shopping_cart_sold_out,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(
                            height: 16.w,
                          ),
                          // 数量选择
                          buildQty(context),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 标题
                          Text(
                            data.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 8.w),
                          // 规格
                          Text(
                            attr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 8.w),
                          // 评分
                          Opacity(
                            opacity: ((data.reviewNum != null
                                        ? data.reviewNum.toString()
                                        : '0') !=
                                    '0')
                                ? 1
                                : 0,
                            child: Row(
                              children: [
                                RatingBarIndicator(
                                  rating: data.reviewScore is int ||
                                          data.reviewScore is double
                                      ? data.reviewScore.toDouble()
                                      : data.reviewScore is String
                                          ? double.parse(data.reviewScore)
                                          : 0,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Color(0xFFFFB400),
                                  ),
                                  unratedColor: Color(0xFFE3E3E3),
                                  itemCount: 5,
                                  itemSize: 15.w,
                                  direction: Axis.horizontal,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  data.reviewNum != null
                                      ? data.reviewNum.toString()
                                      : '0',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.w),
                          // 价格
                          Row(
                            children: [
                              if (data.priceTextLabel != null &&
                                  data.priceTextLabel.isNotEmpty) ...[
                                Text(
                                  data.priceTextLabel,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: priceColor,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                              ],
                              Text(
                                data.price,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: data.activityStatus == 1 ||
                                          (data.tagPrice != null &&
                                              data.tagPrice.isNotEmpty)
                                      ? priceColor
                                      : textColor,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                data.tagPrice ?? '',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColor.primarySubTitle,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.5.w),
                          if (data.priceOffDesc != null &&
                              data.priceOffDesc.isNotEmpty)
                            Text(
                              data.priceOffDesc,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: priceColor,
                              ),
                            ),
                          SizedBox(height: 30.w),
                          //功能区
                          Align(
                            alignment: Alignment.centerRight,
                            child: Wrap(
                              spacing: 16.w,
                              alignment: WrapAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: saveOrMove,
                                  child: Text(
                                    widget.isFromCart
                                        ? S
                                        .of(context)
                                        .shopping_cart_save_for_later
                                        : S
                                        .of(context)
                                        .shopping_cart_move_to_cart,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColor.primaryText,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: remove,
                                  child: Text(
                                    S.of(context).shopping_cart_remove,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColor.primaryText,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 发货时间
              if (isShowDeliveryTime)
                Container(
                  height: 33.w,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 8.w),
                  margin: EdgeInsets.only(top: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.5.w),
                    color: AppColor.primaryBackground,
                  ),
                  child: Text(
                      '${S.of(context).shopping_cart_delivery_time} ${data.deliveryTime}'),
                ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16.w),
          height: 1.w,
          color: AppColor.primaryBorderBottomLine,
        ),
      ],
    );
  }

  Widget buildQty(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: isCanQty ? () => showSelectQty() : () {},
          child: Container(
            width: 124.w,
            height: 45.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                border: Border.all(
                  color: (isCanQty && qtyError == null && data.qtyError == null)
                      ? AppColor.primaryBorderOutline
                      : AppColor.primaryErrorTip,
                  width: 1.w,
                )),
            child: Row(
              children: [
                Text(
                  S.of(context).shopping_cart_qty,
                  style: TextStyle(
                    color: AppColor.primarySubTitle,
                    fontSize: 13.sp,
                  ),
                ),
                Expanded(
                    child: Text(
                  data.qty,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                )),
                Icon(
                  Iconfont.More2,
                  size: 14.w,
                ),
              ],
            ),
          ),
        ),
        if (qtyError != null || data.qtyError != null || !isCanQty)
          Padding(
            padding: EdgeInsets.only(top: 6.w),
            child: Text(
              qtyError ?? data.qtyError ?? data.checkStatusName,
              style: TextStyle(
                color: AppColor.primaryErrorTip,
                fontSize: 12.sp,
              ),
            ),
          )
      ],
    );
  }

  /// 移动购物车列表商品
  void saveOrMove() async {
    var currentConfig = Localstorage().getJSON(StorageKey.CURRENT_CONFIG) ?? {};
    sendProductItemGTM(
        data: [data.toJson()],
        itemListName: 'Shopping Cart',
        eventName: widget.isFromCart
            ? 'shippingcart_saveforlater_click'
            : 'shippingcart_movetocart_click',
        extraParms: {
          'currency': currentConfig['currency'] ?? 'usd',
          'value': data.price,
        });
    await context.read<ShoppingCartCtrl>().changeItem(params: {
      'cart_id': data.cartId,
      'is_shopping': widget.isFromCart ? 0 : 1,
      'type': 'selected_change',
    });
    Provider.of<GlobalConfig>(context, listen: false).getShoppingCartNumber();
  }

  /// 移除商品
  void remove() async {
    await context.read<ShoppingCartCtrl>().changeItem(params: {
      'cart_id': data.cartId,
      'type': 'delete',
    });
    Provider.of<GlobalConfig>(context, listen: false).getShoppingCartNumber();
  }

  void showSelectQty() async {
    int qty = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.w),
          topRight: Radius.circular(8.w),
        ),
      ),
      builder: (BuildContext context) {
        return CountSelect(value: int.parse(data.qty));
      },
    );
    int originQty = int.parse(data.qty);
    setState(() {
      qtyError = null;
    });
    if (qty != null && qty != originQty) {
      CartChangeDatum datum =
          await context.read<ShoppingCartCtrl>().changeItem(params: {
        'cart_id': data.cartId,
        'qty': qty,
        'is_selected': 1,
        'type': qty > originQty ? 'num_add' : 'num_subtract',
      });
      if (datum != null) {
        setState(() {
          qtyError = datum.checkStatusName;
        });
      }
    }
  }
}
