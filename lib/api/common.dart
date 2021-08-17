/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-25 09:51:58
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

  // 上报装机设备号
  static Future<DioResult> pushDeviceInfo({dynamic params}) async {
    DioResult res =
        await Request().post('/common/device/push-info', params: params);
    return res;
  }

  //获取升级信息
  static Future<DioResult> appUpgrade({dynamic params}) async {
    DioResult res = await Request().post('/api/app/upgrade', params: params);
    return res;
  }
}
