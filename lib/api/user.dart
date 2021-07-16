import 'package:homary/entity/main.dart';
import 'package:homary/common/request/request.dart';

class UserApi {
  static Future<DioResult> emailLogin({UserEmailLoginReq params}) async {
    DioResult res = await Request().post('/user/login/email', params: params);
    return res;
  }
}
