import 'package:homary/common/utils/main.dart';
import 'package:homary/api/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/common/utils/validator.dart';
import 'package:homary/components/formInput/main.dart';
import 'tabItem/main.dart'; // TabBar 部件
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:twitter_login/twitter_login.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  int _currentTab = 0;
  String _email;
  String _pwd;
  bool _markState = false;

  // methods
  _userLogin() async {
    UserEmailLoginReq params = UserEmailLoginReq(email: _email, password: _pwd);
    UserEmailLoginRes res = await UserApi.emailLogin(params: params);
    print('res--- ${res.toJson()}');
  }

  _switchTab(ctx, int idx) {
    var _form = Form.of(ctx);
    _form.reset();
    this.setState(() {
      this._currentTab = idx;
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  //google登陆
  void signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ]);
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print('googleUser---$googleUser');
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final User user = (await _auth.signInWithCredential(credential)).user;
        print(user);
        assert(user.email != null);
        assert(user.displayName != null);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        IdTokenResult idTokenResult = await user.getIdTokenResult(true);
        print(idTokenResult);
      }
    } catch (e) {
      print(e);
    }
  }

  //Facebook登陆
  Future<Null> signInFacebook() async {
    try {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
      print('facebook-----$result');
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          final AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);
          final User user = (await _auth.signInWithCredential(credential)).user;
          IdTokenResult idTokenResult = await user.getIdTokenResult(true);
          print(idTokenResult);
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

  // widget
  Widget _head() {
    // 头部logo
    return Container(
      margin: EdgeInsets.only(top: 13.h, bottom: 20.5.h),
      child: Center(
        child: Image.asset('assets/logo.png', width: 140.w, height: 46.h),
      ),
    );
  }

  Widget _tabBar() {
    // tabBar 部件
    return Container(
      height: 40.h,
      margin: EdgeInsets.only(bottom: 16.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(builder: (ctx) {
            return GestureDetector(
                child: TabItem('LOG IN', 0, this._currentTab),
                onTap: () => _switchTab(ctx, 0));
          }),
          Builder(builder: (ctx) {
            return GestureDetector(
                child: TabItem('SIGN UP', 1, this._currentTab),
                onTap: () => _switchTab(ctx, 1));
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        color: Colors.white,
        child: Column(
          children: [
            _head(),
            Form(
                child: Column(
              children: [
                _tabBar(),
                Input(
                  innerText: 'Email Address',
                  validator: (val) => checkEmail(val),
                  onSaved: (val) => _email = val,
                ),
                SizedBox(height: 28.h),
                Input(
                  innerText: 'password',
                  isPwd: true,
                  validator: (val) => checkPassWord(val),
                  onSaved: (val) => _pwd = val,
                ),
                SizedBox(height: 24.h),
                Offstage(
                    offstage: this._currentTab != 1,
                    child: Row(children: [
                      Container(
                        width: 15.w,
                        height: 15.h,
                        margin: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: Checkbox(
                            value: _markState,
                            onChanged: (val) => this.setState(() {
                                  this._markState = val;
                                })),
                      ),
                      Container(
                        width: 290.w,
                        child: Text(
                            'Follow us to receive exclusive offers and our latest news.',
                            maxLines: 3,
                            style: TextStyle(color: AppColor.primaryText)),
                      ),
                    ])),
                SizedBox(height: 12.h),
                Container(
                    width: 335.w,
                    height: 48.h,
                    child: Builder(builder: (ctx) {
                      return ElevatedButton.icon(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          var _form = Form.of(ctx);
                          if (_form.validate()) {
                            _form.save();
                            _userLogin();
                          }
                        },
                        icon: Icon(Icons.lock_sharp),
                        label: Text(
                            '${this._currentTab == 0 ? "LOG IN" : "CREATE AN ACCOUNT"}',
                            style: TextStyle(fontSize: 16.sp)),
                      );
                    })),
                Offstage(
                    offstage: this._currentTab != 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 28.h),
                      child: Text(
                        'By registering, you agree to our Privacy & Cookie Policy. and Terms & Conditions. ',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ))
              ],
            )),
            Row(
              children: [
                TextButton(onPressed: signInWithGoogle, child: Text('google')),
                TextButton(onPressed: signInFacebook, child: Text('facebook')),
                TextButton(onPressed: signInFacebook, child: Text('twitter'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
