/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-03 18:06:20
 */

import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/entity/main.dart';
import 'package:homary/common/request/request.dart';

var requestUrl = Localstorage().getJSON(StorageKey.REQUEST_URL);

class UserApi {
  static Future<DioResult> emailLogin({UserEmailLoginReq params}) async {
    DioResult res = await Request().post(
        requestUrl['emailLogin'] ?? baseRequestUrl['emailLogin'],
        params: params);
    return res;
  }

  //注册
  static Future<DioResult> userRegister({UserRegisterReq params}) async {
    DioResult res = await Request().post(
        requestUrl['emailRegister'] ?? baseRequestUrl['emailRegister'],
        params: params);
    return res;
  }

  //第三方登录
  static Future<DioResult> thirdLogin({UserThirdLoginReq params}) async {
    DioResult res = await Request().post(
        requestUrl['fireBaseLogin'] ?? baseRequestUrl['fireBaseLogin'],
        params: params);
    return res;
  }

  //登出
  static Future<DioResult> signOut() async {
    DioResult res = await Request().post(
        requestUrl['loginLogOut'] ?? baseRequestUrl['loginLogOut'],
        isRequire: true);
    return res;
  }

  //给用户发送邮件
  static Future<DioResult> userSendEmail(UserSendEmailReq params) async {
    DioResult res = await Request().post(
        requestUrl['sendEmail'] ?? baseRequestUrl['sendEmail'],
        params: params);
    return res;
  }

  // 用户信息
  static Future<DioResult> userInfo() async {
    DioResult res = await Request().get(
        requestUrl['userInfo'] ?? baseRequestUrl['userInfo'],
        isRequire: true);
    return res;
  }
}
