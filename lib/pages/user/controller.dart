/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 10:05:06
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-06 18:15:34
 */
import 'dart:async';

import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/recentlyBrowsed.dart' hide Data;
import 'package:homary/entity/userCenter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserCtrl with ChangeNotifier {
  Data userCenterInfo;
  bool isLoading = false;
  int hasMorePage = 0;
  Map<String, int> recentlyBrowsedParams = {"page": 1, "page_size": 10};
  List<ModuleDataProductList> recentlyList = [];
  bool _isDispose = false;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    super.dispose();
    _isDispose = true;
  }

  void _safeNotifyListeners() {
    if (_isDispose) {
      return;
    }
    notifyListeners();
  }

  void init() {
    this.userCenterInfo = null;
    this.isLoading = false;
    this.hasMorePage = 0;
    this.recentlyBrowsedParams = {"page": 1, "page_size": 10};
    this.recentlyList = [];
    _safeNotifyListeners();
  }

  Future userCenter() async {
    Toast.loading();
    DioResult res = await UserCenterApi.userCenter();
    Toast.clear();
    if (res.error == null) {
      UserCenterRes result = UserCenterRes.fromJson(res.result);
      this.userCenterInfo = result.data;
      _safeNotifyListeners();
    }
  }

  Future<void> getRecentlyBrowsed({params}) async {
    isLoading = true;
    if (params == null) {
      recentlyBrowsedParams = {"page": 1, "page_size": 10};
    }
    _safeNotifyListeners();
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
      if (hasMorePage == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _safeNotifyListeners();
    }
  }

  Future handleGetMoreProduct() async {
    recentlyBrowsedParams['page'] += 1;
    await getRecentlyBrowsed(params: recentlyBrowsedParams);
  }

  Future handleDelFootPrint({params}) async {
    DioResult res = await UserCenterApi.delFootPrintItem(params: params);
    if (res.error == null) {
      Toast.success('Cancel Success');
      getRecentlyBrowsed();
    }
  }
}
