/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:46:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 16:00:28
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

  // 获取服务条款
  static Future<DioResult> getTermsSingle({dynamic params}) async {
    DioResult res = await Request()
        .post('/product/product/get-product-terms-simple', params: params);
    return res;
  }

  // 获取服务条款详情
  static Future<DioResult> getTermsDetail({dynamic params}) async {
    DioResult res = await Request()
        .post('/product/product/get-product-terms-of-service', params: params);
    return res;
  }
}
