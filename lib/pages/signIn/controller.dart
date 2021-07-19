/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 11:36:43
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-27 17:11:52
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/api/main.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
// import 'package:twitter_login/twitter_login.dart';

class SignInCtrl with ChangeNotifier {
  bool showEmailTip = false;
  String loginInEmailErr;
  String loginInPassErr;
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
  final FacebookLogin facebookSignIn = new FacebookLogin();

  //登录
  Future signIn(email, password) async {
    Toast.loading();
    UserEmailLoginReq params =
        UserEmailLoginReq(email: email, password: password);
    DioResult res = await UserApi.emailLogin(params: params);
    Toast.clear();
    if (res.error == null) {
      UserEmailLoginRes result = UserEmailLoginRes.fromJson(res.result);
      this.successCb(result);
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
  Future userRegister(email, password, subscribeParam) async {
    Toast.loading();
    int subscribe = subscribeParam ? 1 : 0;
    UserRegisterReq params =
        UserRegisterReq(email: email, password: password, subscribe: subscribe);
    DioResult res = await UserApi.userRegister(params: params);
    Toast.clear();
    if (res.error == null) {
      UserEmailLoginRes result = UserEmailLoginRes.fromJson(res.result);

      this.successCb(result);
    } else {
      if (res.error['code'] == 70018) {
        this.loginInEmailErr = res.error['message'];
      }
      notifyListeners();
    }
  }

  //谷歌登录
  void signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final User user = (await _auth.signInWithCredential(credential)).user;
        String idTokenResult = await user.getIdToken();
        print('google res ===>  $idTokenResult');
        UserThirdLoginReq params =
            UserThirdLoginReq(idToken: idTokenResult, oauthVerifier: 'google');
        UserEmailLoginRes res = await UserApi.thirdLogin(params: params);
        this.successCb(res);
      }
    } catch (e) {
      print(e);
    }
  }

  //facebook 登录
  Future<Null> signInFacebook() async {
    try {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          final AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);
          final User user = (await _auth.signInWithCredential(credential)).user;
          String idTokenResult = await user.getIdToken(true);
          print('fb-----$idTokenResult');
          UserThirdLoginReq params = UserThirdLoginReq(
              idToken: idTokenResult, oauthVerifier: 'facebook');
          UserEmailLoginRes res = await UserApi.thirdLogin(params: params);
          this.successCb(res);
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  //Twitter登录
  Future signWithTwitter() async {
    // final TwitterLogin twitterLogin = new TwitterLogin(
    //     apiKey: 'twmeqdH1DOZJxRFUDpjaSj9iP',
    //     apiSecretKey: '8Zu6Sxup0f0KRvYiNiIhhT8Zo36tnxrR9jnERXmjGlY7WaAYKJ',
    //     redirectURI: 'homary://');
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'twmeqdH1DOZJxRFUDpjaSj9iP',
      consumerSecret: '8Zu6Sxup0f0KRvYiNiIhhT8Zo36tnxrR9jnERXmjGlY7WaAYKJ',
    );
    print('twitterLogin-----$twitterLogin');
    // final authResult = await twitterLogin.login();
    final TwitterLoginResult result = await twitterLogin.authorize();
    print('status------${result.status}');
    print('errorMessage------${result.errorMessage}');
    print('result------${result.session}');
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        AuthCredential credential = TwitterAuthProvider.credential(
            accessToken: result.session.token ?? '',
            secret: result.session.secret ?? '');
        final User user = (await _auth.signInWithCredential(credential)).user;
        String idTokenResult = await user.getIdToken(true);
        print('fb-----$idTokenResult');
        UserThirdLoginReq params =
            UserThirdLoginReq(idToken: idTokenResult, oauthVerifier: 'twitter');
        UserEmailLoginRes res = await UserApi.thirdLogin(params: params);
        this.successCb(res);
        print('twitter----$user');
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('twitter----cancel');
        break;
      case TwitterLoginStatus.error:
        // print('twitter----error${authResult.errorMessage}');
        break;
    }
  }

  //登录成功之后的回调
  void successCb(res) {
    print('res-------${res.data.toJson()}');
    var userInfo = res.data;
    setToken(userInfo.token);
    Localstorage().setBool('isLogin', true);
    userInfo.token = null;
    setUserInfo(userInfo.toJson());
    setWebviewCookies();
    Routes.goHome();
  }
}
