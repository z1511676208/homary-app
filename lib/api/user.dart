import 'package:homary/entity/main.dart';
import 'package:homary/common/request/request.dart';

class UserApi {
  static Future<UserEmailLoginRes> emailLogin(
      {UserEmailLoginReq params}) async {
    var res = await Request().post('/user/login/email', params: params);
    return UserEmailLoginRes.fromJson(res);
  }
}
