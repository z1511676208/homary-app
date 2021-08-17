/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 10:05:06
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-26 15:40:28
 */
import 'dart:async';

import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/recentlyBrowsed.dart' hide Data;
import 'package:homary/entity/userCenter.dart';

class UserCtrl with ChangeNotifier {
  Data userCenterInfo;
  bool isLoading = false;
  int hasMorePage = 0;
  Map<String, int> recentlyBrowsedParams = {"page": 1, "page_size": 10};
  List<ModuleDataProductList> recentlyList = [];

  void init() {
    this.userCenterInfo = null;
    this.isLoading = false;
    this.hasMorePage = 0;
    this.recentlyBrowsedParams = {"page": 1, "page_size": 10};
    this.recentlyList = [];
    notifyListeners();
  }

  Future userCenter() async {
    DioResult res = await UserCenterApi.userCenter();
    if (res.error == null) {
      UserCenterRes result = UserCenterRes.fromJson(res.result);
      this.userCenterInfo = result.data;
      Localstorage().setString('userID', result.data.userIdentification);
      notifyListeners();
    }
  }

  Future<void> getRecentlyBrowsed({params}) async {
    isLoading = true;
    notifyListeners();
    DioResult res = await UserCenterApi.getRecentlyBrowsed(
        params: params ?? recentlyBrowsedParams);
    isLoading = false;
    if (res.error == null) {
      RecentlyBrowsedRes result = RecentlyBrowsedRes.fromJson(res.result);
      List<ModuleDataProductList> newResilt = result?.data?.skuList ?? [];
      if (recentlyBrowsedParams['page'] == 1) {
        recentlyList = [...newResilt];
      } else {
        recentlyList = [...recentlyList, ...newResilt];
      }
      hasMorePage = result?.data?.hasMorePage ?? 1;
      notifyListeners();
    }
  }

  handleGetMoreProduct() {
    recentlyBrowsedParams['page'] += 1;
    getRecentlyBrowsed(params: recentlyBrowsedParams);
  }
}
