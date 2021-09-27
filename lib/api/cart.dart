/*
 * @Author       : zhhjie
 * @Date         : 2021-08-13 11:07:38
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-29 11:27:10
 */

import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var urlMapList = Localstorage().getJSON(StorageKey.REQUEST_URL);

class CartApi {
  static Future<DioResult> getShoppingCartNumber({dynamic params}) async {
    DioResult res = await Request().post(
        urlMapList['getCartNums'] ?? baseRequestUrl['getCartNums'],
        params: params,
        isRequire: true);
    return res;
  }

  static Future<DioResult> getShoppingCart({dynamic params}) async {
    DioResult res = await Request()
        .get('/order/cart/list', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> searchCoupon({dynamic params}) async {
    DioResult res = await Request()
        .post('/market/coupon-search/search', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> getAreaByZip({dynamic params}) async {
    DioResult res = await Request().get('/user/user-no-auth/get-area-by-zip',
        params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> change({dynamic params}) async {
    DioResult res = await Request()
        .post('/order/cart/change', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> getMethodList({dynamic params}) async {
    DioResult res = await Request()
        .get('/pay/pay/get-method-icon-list', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> touristGoosListCheck({dynamic params}) async {
    DioResult res = await Request().post('/order/tourist/goods-list-check',
        params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> goosListCheck({dynamic params}) async {
    DioResult res = await Request()
        .post('/order/order/cart-goods-check', params: params, isRequire: true);
    return res;
  }
}
