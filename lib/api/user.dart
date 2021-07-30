/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 11:39:47
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homary/entity/main.dart';
import 'package:homary/common/request/request.dart';

class UserApi {
  static Future<DioResult> emailLogin({UserEmailLoginReq params}) async {
    DioResult res = await Request().post('/user/login/email', params: params);
    return res;
  }

  //注册
  static Future<DioResult> userRegister({UserRegisterReq params}) async {
    DioResult res = await Request().post('/user/user/register', params: params);
    return res;
  }

  //谷歌登录
  static Future<UserEmailLoginRes> thirdLogin(
      {UserThirdLoginReq params}) async {
    var res =
        await Request().post('/user/login/fire-base-login', params: params);
    return UserEmailLoginRes.fromJson(res);
  }

  //Facebook登录
  static Future<UserEmailLoginRes> fbLogin(UserThirdLoginReq params) async {
    var res =
        await Request().post('/user/login/facebook-login', params: params);
    return UserEmailLoginRes.fromJson(res);
  }

  //Twitter登录
  static Future<UserEmailLoginRes> twLogin(UserThirdLoginReq params) async {
    var res = await Request().post('/user/login/twitter-login', params: params);
    return UserEmailLoginRes.fromJson(res);
  }

  //登出
  static Future<DioResult> signOut() async {
    DioResult res =
        await Request().post('/user/login/log-out', isRequire: true);
    return res;
  }

  //给用户发送邮件
  static Future<DioResult> userSendEmail(UserSendEmailReq params) async {
    DioResult res =
        await Request().post('/user/login/send-email', params: params);
    return res;
  }
}
