/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 09:48:32
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 10:03:11
 */
import 'package:homary/common/request/request.dart';
import 'package:homary/entity/main.dart';

class UserCenterApi {
  static Future<DioResult> userCenter({UserCenterRes params}) async {
    DioResult res = await Request()
        .post('/user/user/user-center', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> userGetList({UserEmailLoginReq params}) async {
    DioResult res = await Request().post('user/browse-footprint/get-list',
        params: params, isRequire: true);
    return res;
  }
}
