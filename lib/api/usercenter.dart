/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 09:48:32
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-06 18:09:39
 */
import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var requestUrl = Localstorage().getJSON(StorageKey.REQUEST_URL);

class UserCenterApi {
  Map<String, int> recommendParams = {"page": 1, "page_size": 10};

  static Future<DioResult> userCenter() async {
    DioResult res = await Request().post(
        requestUrl['userCenter'] ?? baseRequestUrl['userCenter'],
        isRequire: true);
    return res;
  }

  static Future<DioResult> getRecentlyBrowsed(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().post(
        requestUrl['getList'] ?? baseRequestUrl['getList'],
        params: params,
        isRequire: true);
    return res;
  }

  static Future<DioResult> delFootPrintItem(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().post(
        "/user/browse-footprint/delete-footprint",
        params: params,
        isRequire: true);
    return res;
  }
}
