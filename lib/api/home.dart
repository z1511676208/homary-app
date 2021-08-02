/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-02 14:13:13
 */

import 'package:homary/common/request/request.dart';

class HomeApi {
  static Future<DioResult> getIndexData({dynamic params}) async {
    DioResult res = await Request().get('/home/index', params: params);
    return res;
  }

  static Future<DioResult> getProductModule(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .get('/home/index/get-home-product-module', params: params);
    return res;
  }

  static Future<DioResult> getReviewModule(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .get('/home/index/get-home-review-module', params: params);
    return res;
  }

  static Future<DioResult> getRecommendList(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .get('/home/index/get-recommend-product', params: params);
    return res;
  }

  static Future<DioResult> getAdvInfo({Map<String, dynamic> params}) async {
    DioResult res =
        await Request().get('/home/index/app-adv-info', params: params);
    return res;
  }
}
