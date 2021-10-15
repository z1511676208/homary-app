import 'package:homary/api/common.dart';
import 'package:homary/api/home.dart';
import 'package:homary/common/config/packageInfo.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/dialog/new_user_dialog.dart';
import 'package:homary/components/dialog/new_user_success_dialog.dart';
import 'package:homary/components/dialog/update_dialog.dart';
import 'package:homary/entity/appUpgrade.dart' hide Data;
import 'package:homary/entity/home_pop_up.dart';
import 'package:homary/entity/user.dart';

/// 首页弹窗
class HomeDialog {
  static HomeDialog instance = HomeDialog._internal();

  factory HomeDialog() => instance;

  HomeDialog._internal();

  BuildContext context;

  /// 新人弹窗显示次数
  int _count;

  /// 新人弹窗上次显示时间
  int _lastTime;

  /// 是否登录
  bool _isLogin;

  void _init() {
    _isLogin = Localstorage().getBool(StorageKey.IS_LOGIN) ?? false;
    String str = Localstorage().getString(StorageKey.NEW_USER_COUPON);
    if (str == null || str.isEmpty) {
      _count = 0;
      _lastTime = 0;
      return;
    }
    List<String> list = str.split(',');
    _count = int.parse(list[0]);
    _lastTime = int.parse(list[1]);
  }

  void dispose() {
    context = null;
  }

  /// 获取首页弹窗
  Future<void> getAppPopUp(BuildContext context) async {
    if (this.context != null) {
      return;
    }

    this.context = context;
    _init();

    // 优先弹出APP升级弹窗
    await getAppUpgrade();

    // 再弹出首页弹窗
    DioResult res = await HomeApi.getAppPopUp();
    HomePopUpRes result;
    if (res.error == null) {
      result = HomePopUpRes.fromJson(res.result);
      if (result.data != null && result.data.isNotEmpty) {
        process(result.data);
      }
    }
  }

  /// 获取app升级信息，判断是否弹出升级提示框
  /// [isFromSetting] 是否来自设置页，设置页调起会有 Loading 和 Toast，同时弹出不受时间限制
  Future<void> getAppUpgrade({
    bool isFromSetting = false,
  }) async {
    if (isFromSetting) {
      Toast.loading();
    }
    DioResult upgradeRes = await CommonApi.appUpgrade(
      params: UpgradeReq(
          version: packageInfo.version,
          language: getCurrentConfig() != null
              ? getCurrentConfig()['language']
              : 'en'),
    );
    if (isFromSetting) {
      Toast.clear();
    }
    if (upgradeRes.error != null) {
      return;
    }

    UpgradeRes result = UpgradeRes.fromJson(upgradeRes.result);

    if ((result == null || result.data.isUpgrade == 0)) {
      // 无需升级
      if (isFromSetting) {
        Toast.message(S.of(context).setting_upgrade);
      }
      return;
    }

    if (result.data.isUpgrade == 2 && !isFromSetting && !_canPopUpgrade()) {
      // 在首页时，非强制更新，会判断弹窗打开时间,在设定的时间内，不再弹出
      return;
    }

    await AppDialog.show(
      context: context,
      widget: Container(
        width: 0.76.sw,
        height: 280.w,
        child: UpdateDialog(upGradeInfo: result),
      ),
      canCancel: result.data.isUpgrade == 2,
    );
    await Localstorage().setInt(
        StorageKey.UPGRADE_POP_TIME, DateTime.now().millisecondsSinceEpoch);
  }

  /// 判断能否弹出更新弹窗
  bool _canPopUpgrade() {
    int popTime = Localstorage().getInt(StorageKey.UPGRADE_POP_TIME);
    if (popTime == 0) {
      return true;
    }

    // 是否超过一天
    bool isADay =
        (DateTime.now().millisecondsSinceEpoch - popTime) > 1000 * 60 * 60 * 24;

    if (isADay) {
      return true;
    }
    return false;
  }

  /// 处理弹窗逻辑
  void process(List<HomePopUpDatum> list) {
    bool isNeedShowNewUser = false; //是否需要显示新人弹窗

    // 检查是否需要显示新人弹窗
    for (int i = 0; i < list.length; i++) {
      HomePopUpDatum datum = list[i];
      if (datum.type == 1) {
        if (_processCoupon(datum)) {
          _showCouponDialog(datum);
          isNeedShowNewUser = true;
          break;
        }
      }
    }

    if (isNeedShowNewUser) {
      // 已展示了新人购物券弹窗，则其他弹窗不需要再显示
      return;
    }

    // 显示其他类型弹窗
    // ...
  }

  /// 判断是否需要需要显示新人弹窗
  bool _processCoupon(HomePopUpDatum datum) {
    // 是否超过一天
    bool isADay = (DateTime.now().millisecondsSinceEpoch - _lastTime) >
        1000 * 60 * 60 * 24;

    if (_count > 6 || !isADay) {
      // 弹窗出现超过7次，或者距离上次出现不足一天，则不予展示
      return false;
    }

    if (_isLogin) {
      // 如果已登陆，判断是否符合新人条件
      final userInfoStr = Localstorage().getJSON(StorageKey.USER_INFO);
      UserInfo userInfo = UserInfo.fromJson(userInfoStr);
      if (userInfo.isOldUser != '0' || userInfo.drawNewUserCoupon != '0') {
        //如果非新人 或者 已领取了新人券，则不予显示
        return false;
      }
    }

    return true;
  }

  /// 显示新人购物券弹窗
  void _showCouponDialog(HomePopUpDatum datum) async {
    AppDialog.show(
      context: context,
      widget: NewUserDialog(
        isLogin: _isLogin,
        datum: datum,
        onTap: () {
          if (_isLogin) {
            // 已登陆，直接领取
            getAllNewCoupon(datum.content.totalAmountStr);
          } else {
            // 未登陆，跳转登陆页
            Navigator.pop(context, true);
            Routes.push(
              context,
              Routes.signIn,
              params: {'page_from': 'newUserModal'},
            );
          }
        },
      ),
    );

    // 保存关闭状态，次数+1
    Localstorage().setString(StorageKey.NEW_USER_COUPON,
        '${_count + 1},${DateTime.now().millisecondsSinceEpoch}');
  }

  /// 新人弹窗领取全部购物券
  Future<void> getAllNewCoupon(String total) async {
    Toast.loading();
    DioResult res = await HomeApi.getAllNewCoupons();
    if (res.error == null) {
      Toast.clear();
      Navigator.pop(context, true);

      // 显示领取成功弹窗
      AppDialog.show(
        context: context,
        widget: NewUserSuccessDialog(
          totalAmountStr: total,
        ),
      );
    }
  }
}
