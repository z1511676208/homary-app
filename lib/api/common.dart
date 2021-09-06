/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-01 17:32:46
 */
import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var requestUrl = Localstorage().getJSON(StorageKey.REQUEST_URL);

class CommonApi {
  static Future<DioResult> getInitConfig({dynamic params}) async {
    DioResult res = await Request().get('/api/app/init-config', params: params);
    return res;
  }

  static Future<DioResult> getServiceTime({dynamic params}) async {
    DioResult res = await Request().get(
        requestUrl['getServiceTime'] ?? baseRequestUrl['getServiceTime'],
        params: params);
    return res;
  }

  // 上报装机设备号
  static Future<DioResult> pushDeviceInfo({dynamic params}) async {
    DioResult res = await Request().post(
        requestUrl['pushInfo'] ?? baseRequestUrl['pushInfo'],
        params: params);
    return res;
  }

  //获取升级信息
  static Future<DioResult> appUpgrade({dynamic params}) async {
    DioResult res = await Request().post(
        requestUrl['upgrade'] ?? baseRequestUrl['upgrade'],
        params: params);
    return res;
  }

  // 获取用户IP对应的地区信息
  static Future<DioResult> getAreaByIp({dynamic params}) async {
    DioResult res = await Request().post(
        requestUrl['getAreaByIp'] ?? baseRequestUrl['getAreaByIp'],
        params: params);
    return res;
  }
}
