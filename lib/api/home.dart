/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 10:38:02
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
}
