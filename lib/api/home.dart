/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 18:17:04
 */

import 'package:homary/common/request/request.dart';

class HomeApi {
  static Future<DioResult> getIndexData({dynamic params}) async {
    DioResult res = await Request().get('/home/index', params: params);
    return res;
  }

  static Future<DioResult> getRecommendList(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .get('/home/index/get-recommend-product', params: params);
    return res;
  }
}
