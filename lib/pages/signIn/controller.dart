/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 11:36:43
 * @LastEditors  : JHao
 * @LastEditTime : 2021-11-03 15:25:18
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/api/main.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/dialog/new_user_success_dialog.dart';
import 'package:homary/provider/auth_ctrl.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

class SignInCtrl with ChangeNotifier {
  bool showEmailTip = false;
  String loginInEmailErr;
  String loginInPassErr;
  String redirect;
  String pageFrom;
  String adp;

  List emailPatterns = [
    '@gmail.com',
    '@hotmail.com',
    '@yahoo.com',
    '@aol.com',
    '@live.com',
    '@bigpond.com',
    '@outlook.com',
    '@icloud.com',
    '@mac.com',
    '@msn.com'
  ];
  List emailPatternList = [];

  //获取设置URL参数
  getQuery({redirect, pageFrom, adp}) {
    this.redirect = redirect;
    this.pageFrom = pageFrom;
    this.adp = adp;
  }

  //邮箱填写提示
  void reseteEailPatterns(String val) {
    if (val == '' || (val.indexOf('@') != -1 && val[val.length - 1] != '@')) {
      this.emailPatternList = [];
      this.showEmailTip = false;
    } else {
      this.emailPatternList = emailPatterns.map((e) {
        if (val.indexOf('@') != -1) {
          return '${val.substring(0, val.length - 1)}$e';
        }
        return '$val$e';
      }).toList();
      this.showEmailTip = true;
    }
    notifyListeners();
  }

  void setLoginInEmailErrNull() {
    this.loginInEmailErr = null;
    notifyListeners();
  }

  void setloginInPassErrNull() {
    this.loginInPassErr = null;
    notifyListeners();
  }

  void closeEmailTipPopup() {
    this.showEmailTip = false;
    notifyListeners();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  //登录
  Future signIn(context, email, password) async {
    Toast.loading();
    String firebaseMessageToken = "";
    try {
      firebaseMessageToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print(e);
    }
    UserEmailLoginReq params = UserEmailLoginReq(
        email: email, password: password, deviceNumber: firebaseMessageToken);
    DioResult res = await UserApi.emailLogin(params: params);
    Toast.clear();
    if (res.error == null) {
      UserEmailLoginRes result = UserEmailLoginRes.fromJson(res.result);
      this.successCb(context, result, 'homary');
    } else {
      if (res.error['code'] == 30011) {
        this.loginInEmailErr = res.error['message'];
        print(loginInEmailErr);
      } else if (res.error['code'] == 30012) {
        this.loginInPassErr = res.error['message'];
      } else {
        Toast.error(res.error['message']);
      }
      notifyListeners();
    }
  }

  //注册
  Future userRegister(context, email, password, subscribeParam) async {
    Toast.loading();
    int subscribe = subscribeParam ? 1 : 0;
    String firebaseMessageToken = "";
    try {
      firebaseMessageToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print(e);
    }
    UserRegisterReq params = UserRegisterReq(
        email: email,
        password: password,
        subscribe: subscribe,
        deviceNumber: firebaseMessageToken);
    DioResult res = await UserApi.userRegister(params: params);
    Toast.clear();
    if (res.error == null) {
      if (subscribe == 1) {
        //订阅成功
        sendGTMData({'event': 'generate_lead'});
      }
      UserEmailLoginRes result = UserEmailLoginRes.fromJson(res.result);
      this.successCb(context, result, 'homary', event: 'sign_up');
    } else {
      if (res.error['code'] == 70018) {
        this.loginInEmailErr = res.error['message'];
      } else {
        Toast.error(res.error['message']);
      }
      notifyListeners();
    }
  }

  // Apple 登录
  void signInWidthApple(context) async {
    try {
      AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
      );
      Toast.loading();
      UserCredential authResult =
          await _auth.signInWithCredential(oauthCredential);
      String idTokenResult = await authResult.user.getIdToken();
      this.thridLogin(context, idTokenResult, 'apple');
    } catch (e) {
      Toast.clear();
      print("Apple SignIn Error $e");
    }
  }

  //谷歌登录
  GoogleSignIn _googleSignIn = GoogleSignIn();
  void signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        Toast.loading();
        try {
          final User user = (await _auth.signInWithCredential(credential)).user;
          String idTokenResult = await user.getIdToken();
          this.thridLogin(context, idTokenResult, 'google');
        } catch (e) {
          Toast.clear();
          FirebaseAuthException error = e;
          Toast.message(error.message);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //facebook 登录
  Future<Null> signInFacebook(context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        Toast.loading();
        try {
          final User user = (await _auth.signInWithCredential(credential)).user;
          String idTokenResult = await user.getIdToken(true);
          this.thridLogin(context, idTokenResult, 'facebook');
        } catch (e) {
          Toast.clear();
          FirebaseAuthException error = e;
          Toast.message(error.message);
        }
      } else {
        print(result.status);
        print(result.message);
      }
    } catch (e) {
      print(e);
    }
  }

  //Twitter登录
  final TwitterLogin twitterLogin = TwitterLogin(
    apiKey: 'twmeqdH1DOZJxRFUDpjaSj9iP',
    apiSecretKey: '8Zu6Sxup0f0KRvYiNiIhhT8Zo36tnxrR9jnERXmjGlY7WaAYKJ',
    redirectURI: 'twittersdk://',
  );
  Future signWithTwitter(context) async {
    final result = await twitterLogin.login();
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        AuthCredential credential = TwitterAuthProvider.credential(
            accessToken: result.authToken ?? '',
            secret: result.authTokenSecret ?? '');

        Toast.loading();
        try {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          final User user = userCredential.user;
          String idTokenResult = await user.getIdToken(true);
          this.thridLogin(context, idTokenResult, 'twitter');
        } catch (e) {
          Toast.clear();
          FirebaseAuthException error = e;
          Toast.message(error.message);
        }

        break;
      case TwitterLoginStatus.cancelledByUser:
        print('twitter----cancel');
        break;
      case TwitterLoginStatus.error:
        break;
    }
  }

  //第三方登录请求获取信息
  void thridLogin(context, idTokenResult, oauthVerifier) async {
    String firebaseMessageToken = "";
    try {
      firebaseMessageToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print(e);
    }
    UserThirdLoginReq params = UserThirdLoginReq(
        idToken: idTokenResult,
        oauthVerifier: oauthVerifier,
        deviceNumber: firebaseMessageToken);
    DioResult res = await UserApi.thirdLogin(params: params);
    if (res.error == null) {
      Toast.clear();
      UserEmailLoginRes result = UserEmailLoginRes.fromJson(res.result);
      this.successCb(context, result, oauthVerifier);
    }
  }

  //登录成功之后的回调
  void successCb(context, UserEmailLoginRes res, String method,
      {String event = 'login'}) async {
    Toast.message(S.of(context).login_successful,
        duration: const Duration(milliseconds: 1000));
    deleteCookie('isGuest');
    var userInfo = res.data;
    setToken(userInfo.token);
    Localstorage().setBool(StorageKey.IS_LOGIN, true);
    Provider.of<AuthCtrl>(context, listen: false).userSignIn(userInfo);
    setWebviewCookies();
    //登录发送GA
    sendGTMData({
      'event': event,
      "method": method,
      'data': {'method': method},
      'user_propertys': userInfo.toJson()
    });
    Provider.of<HomeCtrl>(context, listen: false).getShoppingCartData();

    bool isGot = userInfo.drawNewUserCoupon != null &&
        double.parse(userInfo?.drawNewUserCoupon) != 0; //是否领过券
    if (goNewComerLanding(context)) return;
    if (event == 'sign_up' && isGot) {
      String totalAmountStr = Provider.of<GlobalConfig>(context, listen: false)
          .commonAmountList
          .couponNewuserAmountStr;
      await AppDialog.show(
          context: context,
          widget: NewUserSuccessDialog(totalAmountStr: totalAmountStr));
    }

    if (this.redirect != null) {
      Navigator.maybePop(context, true);
    } else {
      Routes.goHome();
    }
  }

// 如果从新人弹窗(NewUserModal)登录点进来，登陆成功之后跳转新人落地页
  goNewComerLanding(context) {
    if (this.pageFrom == 'newUserModal') {
      sendGTMData({'event': 'view_new_from_popup'});
      Routes.replace(context, '/webview', params: {
        "content":
            '{"url":"https://m.homary.com/activity-list/newcomer-landing-page?adp=${this.adp}"}'
      });
      return true;
    }
    return false;
  }
}
