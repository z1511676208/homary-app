import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/orders_res.dart';
import 'package:homary/pages/myOrders/components/my_orders_goods.dart';
import 'package:homary/pages/myOrders/components/my_orders_tab_controller.dart';
import 'package:homary/pages/myOrders/components/order_cancel_select.dart';
import 'package:url_launcher/url_launcher.dart';

class MyOrderItem extends StatelessWidget {
  const MyOrderItem({Key key, this.res}) : super(key: key);

  final OrdersResElement res;

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomList = buildBottomButton(context);
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
            children: [
              // 订单号及订单状态
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    S.of(context).my_orders_order_no(res.orderNo),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.primarySubTitle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      OrderStatusParser.orderStatus(context, res.orderStatus),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.w,
              ),
              // 商品列表
              ...res.goodsList.map((e) {
                return MyOrdersGoods(
                  imageUrl: e.img,
                  goodsName: e.name,
                  spec: (e.attrGroup ?? {})
                      .entries
                      .map((e) => '${e.key}:${e.value}')
                      .toList(),
                  price: e.priceStr,
                  count: e.qty,
                  orderNo: res.orderNo,
                );
              }).toList(),
              // 底部功能区 超过3个则变成滚动模式
              bottomList.length < 3
                  ? Row(
                      children: [
                        Text(
                          S.of(context).my_orders_total(res.payAmountStr),
                          style: _textStyle2,
                        ),
                        Expanded(child: Container()),
                        ...bottomList,
                      ],
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            S.of(context).my_orders_total(res.payAmountStr),
                            style: _textStyle2,
                          ),
                          ...bottomList,
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildBottomButton(BuildContext context) {
    List<Widget> bottomList = [];

    // CheckOut
    if (['0'].contains(res.orderStatus)) {
      bottomList.add(buildButton1(S.of(context).my_orders_checkout, () {
        Routes.push(context, Routes.webView, params: {
          "content":
              '{"url":"https://m.homary.com/order/place?order_no=${res.orderNo}&source=3"}'
        });
      }));
    }

    // Download
    if (['2', '8', '9', '6', '4', '7'].contains(res.orderStatus)) {
      bottomList.add(buildButton1(S.of(context).my_orders_download, () async {
        if (await canLaunch(res.fileLink)) {
          launch(res.fileLink);
        }
      }));
    }

    // ConfirmReceipt
    if (['9'].contains(res.orderStatus)) {
      bottomList
          .add(buildButton1(S.of(context).my_orders_confirm_receipt, () async {
        bool result = await AppDialog.showMessage(
          context: context,
          title: S.of(context).my_orders_confirm_title,
          message: S.of(context).my_orders_confirm_message,
          yesStr: S.of(context).my_orders_confirm_receipt,
          noStr: S.of(context).my_orders_confirm_no,
        );
        if (result ?? false) {
          bool success =
              await context.read<MyOrdersTabCtrl>().confirmReceipt(res.orderNo);
          if (success) {
            context.read<MyOrdersTabCtrl>().refresh();
          }
        }
      }));
    }

    // Cancel
    if (['0'].contains(res.orderStatus) ||
        (res.orderStatus == '1' && res.paymentMethod == 'bank_transfer')) {
      bottomList.add(buildButton2(S.of(context).my_orders_cancel, () async {
        String reason = await showModalBottomSheet(
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
            return OrderCancelSelect();
          },
        );
        if (reason != null) {
          bool success = await context
              .read<MyOrdersTabCtrl>()
              .cancelOrder(res.orderNo, reason);
          if (success) {
            Toast.success(S.of(context).my_orders_order_cancel_success);
            context.read<MyOrdersTabCtrl>().refresh();
          }
        }
      }));
    }

    // Refund
    if (['7'].contains(res.orderStatus)) {
      bottomList.add(buildButton2(S.of(context).my_orders_refund, () async {
        String reason = await showModalBottomSheet(
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
            return OrderCancelSelect();
          },
        );
        if (reason != null) {
          bool success = await context
              .read<MyOrdersTabCtrl>()
              .refundOrder(res.orderNo, reason);
          if (success) {
            context.read<MyOrdersTabCtrl>().refresh();
          }
        }
      }));
    }

    // Reorder
    if (['8', '9', '6', '4'].contains(res.orderStatus)) {
      bottomList.add(buildButton2(S.of(context).my_orders_reorder, () async {
        await context.read<MyOrdersTabCtrl>().addCart(res.goodsList.map((e) {
              return {'qty': e.qty, 'sku_id': e.skuId};
            }).toList());
        Routes.push(context, '/webview', params: {
          "showAppLoading": '0',
          "content": '{"url":"https://m.homary.com/shoppingcart"}'
        });
      }));
    }

    return bottomList;
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

  // 白底黑色文字
  Widget buildButton2(String text, Function onTap) {
    return Container(
      height: 30.w,
      margin: EdgeInsets.only(left: 10.w),
      child: ElevatedButton(
        onPressed: onTap,
        style: _buttonStyle2,
        child: Text(
          text,
          style: _textStyle2,
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

  // 白底描边 + 圆角 + 去阴影
  static ButtonStyle _buttonStyle2 = ElevatedButton.styleFrom(
    elevation: 0,
    primary: Colors.white,
    side: BorderSide(color: AppColor.primaryBorderOutline, width: 0.5.w),
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

  // 13黑色加粗
  static TextStyle _textStyle2 = TextStyle(
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
        return S.of(context).my_orders_processing2;
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
