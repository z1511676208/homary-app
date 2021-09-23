import 'package:homary/common/request/request.dart';

class OrderApi {
  static Future<DioResult> getOrdersList({Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/order/order/list', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> getAfterSaleOrdersList(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/order/after-sale/list', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> confirmReceipt(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/order/order/order-receive', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> cancelOrder(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/order/order/cancel', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> addCart(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/order/cart/add', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> refundOrder(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/order/order/order-refund', params: params, isRequire: true);
    return res;
  }
}
