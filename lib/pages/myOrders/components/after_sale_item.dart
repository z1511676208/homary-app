import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/after_order_orders_res.dart';
import 'package:homary/pages/myOrders/components/my_orders_goods.dart';

class AfterSaleItem extends StatelessWidget {
  const AfterSaleItem({Key key, this.res}) : super(key: key);

  final AfterSaleOrdersResElement res;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10.w,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 14.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 订单号及订单状态
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    res.typeStr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.primarySubTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    res.overviewTitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.w,
              ),
              // 商品列表
              ...res.afterSaleGoodsList.map((e) {
                return MyOrdersGoods(
                  imageUrl: e.img,
                  goodsName: e.name,
                  spec: (e.attrGroup ?? {})
                      .entries
                      .map((e) => '${e.key}:${e.value}')
                      .toList(),
                  price: '',
                  count: e.qty,
                  afterSaleNo: e.afterSaleNo,
                );
              }).toList(),
              // 底部功能区 超过3个则变成滚动模式
              buildButton1(S.of(context).my_orders_view_detail, () {
                Routes.push(context, Routes.webView, params: {
                  "appBarTitle": S.of(context).my_orders_after_sales,
                  "content":
                      '{"url":"https://m.homary.com/usercenter/aftersaledetail?after_sale_no=${res.afterSaleNo}"}'
                });
              }),
            ],
          ),
        ),
      ],
    );
  }

  // 橙色底白色文字
  Widget buildButton1(String text, Function onTap) {
    return Container(
      height: 30.w,
      margin: EdgeInsets.only(left: 10.w),
      child: ElevatedButton(
        onPressed: onTap,
        style: _buttonStyle,
        child: Text(
          text,
          style: _textStyle,
        ),
      ),
    );
  }

  // 圆角 + 去阴影
  static ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.w),
    ),
  );

  // 白色加粗
  static TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
  );
}

class OrderStatusParser {
  ///   0 待付款（Pending）
  ///   1 支付待审核（Payment Review)
  ///   7 已支付（Paid）
  ///   2 待发货（Processing）
  ///   8 部分发货（Partially Shipped）
  ///   9 全部发货（Shipped）
  ///   6 已完成（Complete）
  ///   4 已取消(Cancel)
  static String orderStatus(BuildContext context, String status) {
    switch (status) {
      case '0':
        return S.of(context).my_orders_pending;
      case '1':
        return S.of(context).my_orders_payment_review;
      case '2':
        return S.of(context).my_orders_processing;
      case '4':
        return S.of(context).my_orders_cancel;
      case '6':
        return S.of(context).my_orders_complete;
      case '7':
        return S.of(context).my_orders_paid;
      case '8':
        return S.of(context).my_orders_partially_shipped;
      case '9':
        return S.of(context).my_orders_shipped;
      default:
        return '';
    }
  }
}
