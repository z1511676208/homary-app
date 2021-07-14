/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 11:36:43
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 19:29:48
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/api/main.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:twitter_login/twitter_login.dart';

class SignInCtrl {
  FirebaseAuth _auth = FirebaseAuth.instance;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String password;
  String email;
  int subscribe = 1;

  void setEmail(val) {
    this.email = val;
  }

  void setPassword(val) {
    this.password = val;
  }

  void setSubscribe(val) {
    this.subscribe = val ? 1 : 0;
  }

  //登录
  void signIn(ctx) async {
    UserEmailLoginReq params =
        UserEmailLoginReq(email: this.email, password: this.password);
    DioResult res = await UserApi.emailLogin(params: params);
    if (res.error == null) {
      UserEmailLoginRes result = UserEmailLoginRes.fromJson(res.result);
      this.successCb(result);
    }
  }

  //注册
  void userRegister(ctx) async {
    UserRegisterReq params = UserRegisterReq(
        email: this.email, password: this.password, subscribe: this.subscribe);
    UserEmailLoginRes res = await UserApi.userRegister(params: params);
    this.successCb(res);
  }

  //谷歌登录
  void signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ]);
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final User user = (await _auth.signInWithCredential(credential)).user;
        IdTokenResult idTokenResult = await user.getIdTokenResult(true);
        print('google res ===>  ${idTokenResult.token}');
        UserThirdLoginReq params =
            UserThirdLoginReq(idToken: idTokenResult.token);
        UserEmailLoginRes res = await UserApi.googleLogin(params: params);
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
          IdTokenResult idTokenResult = await user.getIdTokenResult(true);
          print('fb-----${idTokenResult.token}');
          UserThirdLoginReq params =
              UserThirdLoginReq(idToken: idTokenResult.token);
          UserEmailLoginRes res = await UserApi.fbLogin(params);
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
    final TwitterLogin twitterLogin = new TwitterLogin(
        apiKey: 'twmeqdH1DOZJxRFUDpjaSj9iP',
        apiSecretKey: '8Zu6Sxup0f0KRvYiNiIhhT8Zo36tnxrR9jnERXmjGlY7WaAYKJ',
        redirectURI: 'homary://');
    print('twitterLogin-----$twitterLogin');
    final authResult = await twitterLogin.login();
    // final TwitterLoginResult result = await twitterLogin.authorize();
    print('result------${authResult.toString()}');
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        AuthCredential credential = TwitterAuthProvider.credential(
            accessToken: authResult.authToken ?? '',
            secret: authResult.authTokenSecret ?? '');
        final User user = (await _auth.signInWithCredential(credential)).user;

        print('twitter----$user');
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('twitter----cancel');
        break;
      case TwitterLoginStatus.error:
        print('twitter----error${authResult.errorMessage}');
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
    Routes.goHome();
  }
}
