/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 11:33:10
 */

import 'package:homary/common/request/request.dart';

class CommonApi {
  static Future<DioResult> getServiceTime({dynamic params}) async {
    DioResult res =
        await Request().get('/common/site/get-service-time', params: params);
    return res;
  }
}
