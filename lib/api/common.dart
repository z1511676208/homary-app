/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-29 13:57:28
 */

import 'package:homary/common/request/request.dart';

class CommonApi {
  static Future<DioResult> getInitConfig({dynamic params}) async {
    DioResult res = await Request().get('/api/app/init-config', params: params);
    return res;
  }

  static Future<DioResult> getServiceTime({dynamic params}) async {
    DioResult res =
        await Request().get('/common/site/get-service-time', params: params);
    return res;
  }
}
