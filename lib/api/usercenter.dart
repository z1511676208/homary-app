/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 09:48:32
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 17:54:12
 */
import 'package:homary/common/request/request.dart';

class UserCenterApi {
  Map<String, int> recommendParams = {"page": 1, "page_size": 10};

  static Future<DioResult> userCenter() async {
    DioResult res =
        await Request().post('/user/user/user-center', isRequire: true);
    return res;
  }

  static Future<DioResult> getRecentlyBrowsed(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request().post('/user/browse-footprint/get-list',
        params: params, isRequire: true);
    return res;
  }
}
