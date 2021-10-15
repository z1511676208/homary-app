import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homary/api/cart.dart';
import 'package:homary/api/user.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/cartNumber.dart';
import 'package:homary/entity/user.dart';
import 'package:homary/main.dart';

/// 用于管理用户状态
class AuthCtrl extends ChangeNotifier {
  /// 是否已登录
  bool get isLogin => _isLogin;
  bool _isLogin;

  /// 购物车有效商品数量
  int get shopCartNumber => _shopCartNumber;
  int _shopCartNumber = 0;

  /// 用户信息
  UserInfo get userInfo => _userInfo;
  UserInfo _userInfo;

  AuthCtrl() {
    _isLogin = Localstorage().getBool(StorageKey.IS_LOGIN) ?? false;
    _init();
  }

  void _init() async {
    Future.wait(
        [getShoppingCartNumber(notify: false), getUserInfo(notify: false)]);
    notifyListeners();
  }

  /// 用户登录
  void userSignIn(UserInfo userInfo) {
    this._isLogin = true;
    this._userInfo = userInfo;
    notifyListeners();

    getShoppingCartNumber();
  }

  Future<void> getUserInfo({bool notify = true}) async {
    if (isLogin == false) {
      return;
    }
    final result = await UserApi.userInfo();
    if (result.error == null) {
      this._userInfo = UserEmailLoginRes.fromJson(result.result).data;
      if (notify) {
        notifyListeners();
      }
    }
  }

  /// 获取购物车有效商品数量
  Future<void> getShoppingCartNumber({bool notify = true}) async {
    DioResult res = await CartApi.getShoppingCartNumber();
    if (res.error == null) {
      this._shopCartNumber = CartNumberRes.fromJson(res.result).data.num ?? 0;
      if (notify) {
        notifyListeners();
      }
    }
  }

  /// 用户主动退出登录
  Future<void> userSignOut() async {
    Toast.loading();
    DioResult res = await UserApi.signOut();
    if (res.error == null) {
      await logOut();
      Toast.message(S.of(navigatorKey.currentContext).logout_successful,
          duration: const Duration(milliseconds: 1000));
    }
  }

  /// 被动退出登录，如401,4001,400112等状态码
  Future<void> logOut() async {
    Localstorage().remove(StorageKey.TOKEN);
    Localstorage().setBool(StorageKey.IS_LOGIN, false);
    setWebviewCookies();
    getShoppingCartNumber();
    _isLogin = false;
    _userInfo = null;
    notifyListeners();
    _thirdLogout();
  }

  /// 第三方登出
  void _thirdLogout() {
    GoogleSignIn().signOut();
    FacebookAuth.instance.logOut();
  }

  /// 弹出用户已注销的弹窗，用于400112状态码
  void showCloseAccountDialog() async {
    final result = await AppDialog.showMessage(
      context: navigatorKey.currentContext,
      message: 'Your account has been closed and you cannot place an order.',
      noStr: null,
      yesStr: 'OK',
      canCancel: false,
    );
    if (result ?? false) {
      Routes.replace(navigatorKey.currentContext, Routes.signIn);
    }
  }
}
