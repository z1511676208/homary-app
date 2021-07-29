/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 10:05:06
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 11:17:10
 */
import 'dart:async';

import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';

class UserCtrl with ChangeNotifier {
  var userCenterInfo;
  Future userCenter() async {
    DioResult res = await UserCenterApi.userCenter();
    if (res.error == null) {
      UserCenterRes result = UserCenterRes.fromJson(res.result);
      this.userCenterInfo = result.data;
      notifyListeners();
    }
  }

  Future userGetList() async {
    DioResult res = await UserCenterApi.userGetList();
  }
}
