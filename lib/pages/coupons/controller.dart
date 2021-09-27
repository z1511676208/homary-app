import 'package:homary/api/usercenter.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/coupon.dart';
import 'package:homary/main.dart';

class CouponsPageCtrl extends ChangeNotifier {
  int availableCount = 0;
  int unavailableCount = 0;

  List<Coupon> availableList = [];
  List<Coupon> unavailableList = [];

  CouponsPageCtrl() {
    init();
  }

  void init() async {
    Toast.loading();
    await getAvailableCoupons(true);
    await getAvailableCoupons(false);
    Toast.clear();
  }

  Future<void> getAvailableCoupons(bool available) async {
    final result =
        await UserCenterApi.getCouponsList(params: {'type': available ? 1 : 0});
    if (result.error == null) {
      CouponList couponList = CouponList.fromJson(result.result);
      if (available) {
        availableCount = couponList.data.list.length;
        availableList = [...couponList.data.list];
      } else {
        unavailableCount = couponList.data.list.length;
        unavailableList = [...couponList.data.list];
      }
      notifyListeners();
    }
  }

  Future<bool> applyCoupon(String code) async {
    Toast.loading();
    final result = await UserCenterApi.drawCoupons(
        params: {'draw_type': 2, 'coupon_alias': code});
    if (result.error == null) {
      await getAvailableCoupons(true);
      Toast.success(S.of(navigatorKey.currentContext).success);
      return true;
    }
    // error != null 时，拦截器会自动弹出错误toast
    return false;
  }
}
