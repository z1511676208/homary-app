/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-03 11:20:13
 */

import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var urlMapList = Localstorage().getJSON(REQUEST_URL);

class HomeApi {
  static Future<DioResult> getProductModule(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().get(
        urlMapList['homeProductModule'] ?? baseRequestUrl['homeProductModule'],
        params: params);
    return res;
  }

  static Future<DioResult> getReviewModule(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().get(
        urlMapList['homeReviewModule'] ?? baseRequestUrl['homeReviewModule'],
        params: params);
    return res;
  }

  static Future<DioResult> getRecommendList(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().get(
        urlMapList['homeRecommendProduct'] ??
            baseRequestUrl['homeRecommendProduct'],
        params: params);
    return res;
  }

  static Future<DioResult> getAdvInfo({Map<String, dynamic> params}) async {
    DioResult res = await Request().get(
        urlMapList['indexAdvInfo'] ?? baseRequestUrl['indexAdvInfo'],
        params: params);
    return res;
  }

  static Future<DioResult> getAppPopUp({Map<String, dynamic> params}) async {
    DioResult res = await Request().get(
        urlMapList['indexPopUp'] ?? baseRequestUrl['indexPopUp'],
        params: params);
    return res;
  }

  static Future<DioResult> getAllNewCoupons(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().post(
        urlMapList['batchGetCoupon'] ?? baseRequestUrl['batchGetCoupon'],
        params: params,
        isRequire: true);
    return res;
  }

  static Future<DioResult> getFlashSaleModule(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().get(
      '/product/product/get-home-flash-sale-module',
      params: params,
    );
    return res;
  }
}
