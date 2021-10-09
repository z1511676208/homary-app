import 'package:homary/common/request/request.dart';

class AccountSettingApi {
  static Future<DioResult> getCloseAccountInfo(
      {Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .get('/user/close-account/info', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> cancelClose({Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/user/close-account/cancel', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> verifyPassword({Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/user/auth/verify-password', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> getApplyList({Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .get('/user/close-account/apply-list', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> closeAccount({Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .post('/user/close-account/apply', params: params, isRequire: true);
    return res;
  }

  static Future<DioResult> getSubscribeList({Map<String, dynamic> params}) async {
    DioResult res = await Request()
        .get('/user/subscribe/list', params: params, isRequire: true);
    return res;
  }
}
