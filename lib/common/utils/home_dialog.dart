import 'package:homary/api/home.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/dialog/new_user_dialog.dart';
import 'package:homary/components/dialog/new_user_success_dialog.dart';
import 'package:homary/entity/home_pop_up.dart';
import 'package:homary/entity/user.dart';

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

    DioResult res = await HomeApi.getAppPopUp();
    HomePopUpRes result;
    if (res.error == null) {
      result = HomePopUpRes.fromJson(res.result);
      if (result.data != null && result.data.isNotEmpty) {
        process(result.data);
      }
    }
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
      Data userInfo = Data.fromJson(userInfoStr);
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
