/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 10:05:06
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 17:48:07
 */
import 'dart:async';

import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/userCenter.dart';

class UserCtrl with ChangeNotifier {
  Data userCenterInfo;
  Map<String, int> recentlyBrowsedParams = {"page": 1, "page_size": 10};

  Future userCenter() async {
    DioResult res = await UserCenterApi.userCenter();
    if (res.error == null) {
      UserCenterRes result = UserCenterRes.fromJson(res.result);
      this.userCenterInfo = result.data;
      notifyListeners();
    }
  }

  Future getRecentlyBrowsed({params}) async {
    DioResult res = await UserCenterApi.getRecentlyBrowsed(
        params: params ?? recentlyBrowsedParams);
  }
}
