/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 19:20:39
 */
import 'package:homary/entity/main.dart';
import 'package:homary/common/request/request.dart';

class UserApi {
  static Future<DioResult> emailLogin({UserEmailLoginReq params}) async {
    DioResult res = await Request().post('/user/login/email', params: params);
    return res;
  }

  //注册
  static Future<UserEmailLoginRes> userRegister(
      {UserRegisterReq params}) async {
    var res = await Request().post('/user/user/register', params: params);
    return UserEmailLoginRes.fromJson(res);
  }

  //谷歌登录
  static Future<UserEmailLoginRes> googleLogin(
      {UserThirdLoginReq params}) async {
    var res = await Request().post('/user/login/google-login', params: params);
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
  static Future<EmptyListRes> signOut() async {
    var res = await Request().post('/user/login/log-out');
    return EmptyListRes.fromJson(res);
  }

  //给用户发送邮件
  static Future<EmptyListRes> userSendEmail(UserSendEmailReq params) async {
    var res = await Request().post('/user/login/send-email', params: params);
    return EmptyListRes.fromJson(res);
  }
}
