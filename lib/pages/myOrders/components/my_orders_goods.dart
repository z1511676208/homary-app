import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/myOrders/components/my_orders_item.dart';
import 'package:homary/widget/networkImg.dart';

class MyOrdersGoods extends StatelessWidget {
  const MyOrdersGoods(
      {Key key,
      this.imageUrl,
      this.goodsName,
      this.spec,
      this.price,
      this.count,
      this.afterSaleNo,
      this.orderStatus,
      this.orderNo})
      : super(key: key);
  final String imageUrl;
  final String goodsName;
  final List<String> spec;
  final String price;
  final String count;
  final String afterSaleNo;
  final String orderNo;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (afterSaleNo != null) {
              Routes.push(context, Routes.webView, params: {
                "appBarTitle": S.of(context).my_orders_after_sales,
                "content":
                    '{"url":"https://m.homary.com/usercenter/aftersaledetail?after_sale_no=$afterSaleNo"}'
              });
            } else if (orderNo != null) {
              Routes.push(context, Routes.webView, params: {
                "appBarTitle":
                    OrderStatusParser.orderStatus(context, orderStatus),
                "content":
                    '{"url":"https://m.homary.com/usercenter/orderdetail?id=$orderNo"}'
              });
            }
          },
          child: SizedBox(
            height: 80.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  imageUrl ?? '',
                  width: 80.w,
                  height: 80.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goodsName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            // 商品属性
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                spec.join('\n'),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 1.3,
                                  color: AppColor.primaryLightSubTitle,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            // 价格
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      price,
                                      style: TextStyle(
                                        color: AppColor.primaryLightSubTitle,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.w,
                                    ),
                                    Text(
                                      'x$count',
                                      style: TextStyle(
                                        color: AppColor.primaryLightSubTitle,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5.w,
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 15.w,
            bottom: 14.w,
          ),
          color: AppColor.primaryBorderBottomLine,
        ),
      ],
    );
  }
}
