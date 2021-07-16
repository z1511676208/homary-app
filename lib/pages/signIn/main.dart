import 'package:homary/api/main.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/common/utils/validator.dart';
import 'package:homary/components/formInput/main.dart';
import 'tabItem/main.dart'; // TabBar 部件
import 'controller.dart';

class SignInPage extends StatefulWidget {
  final String redirect;

  SignInPage({this.redirect, Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  int _currentTab = 0;
  String _email;
  String _pwd;
  bool _markState = false;
  bool subscribe = true;
  SignInCtrl signInCtrl = new SignInCtrl();
  // methods
  _userLogin() async {
    UserEmailLoginReq params = UserEmailLoginReq(email: _email, password: _pwd);
    DioResult res = await UserApi.emailLogin(params: params);
    if (res.result != null) {
      UserEmailLoginRes result = UserEmailLoginRes.fromJson(res.result);
      print('res--- ${result.toJson()}');
    } else {
      print('err--- ${res.error}');
    }
  }

  _switchTab(ctx, int idx) {
    var _form = Form.of(ctx);
    _form.reset();
    this.setState(() {
      this._currentTab = idx;
    });
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
                Offstage(
                  offstage: this._currentTab != 1,
                  child: Container(
                      // decoration: BoxDecoration(
                      //   border:Border.all(color: ),
                      //   )
                      // ),
                      ),
                ),
                Input(
                  innerText: 'Email Address',
                  validator: (val) => checkEmail(val),
                  onSaved: (val) => signInCtrl.setEmail(val),
                ),
                SizedBox(height: 28.w),
                Input(
                  innerText: 'password',
                  isPwd: true,
                  validator: (val) => checkPassWord(val),
                  onSaved: (val) => signInCtrl.setPassword(val),
                ),
                SizedBox(height: 24.w),
                Offstage(
                    offstage: this._currentTab != 1,
                    child: Row(children: [
                      Container(
                        width: 15.w,
                        height: 15.h,
                        margin: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: Checkbox(
                            value: subscribe,
                            onChanged: (val) => this.setState(() {
                                  subscribe = val;
                                  signInCtrl.setSubscribe(val);
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
                            overlayColor: MaterialStateProperty.all(
                                AppColor.primaryPressed),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0.w),
                            ))),
                        onPressed: () {
                          var _form = Form.of(ctx);
                          if (_form.validate()) {
                            _form.save();
                            _currentTab == 0
                                ? signInCtrl.signIn(context)
                                : signInCtrl.userRegister(context);
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
                    )),
                Container(
                    margin: EdgeInsets.only(top: 32.w),
                    child: Column(
                      children: [
                        Offstage(
                          offstage: this._currentTab == 1,
                          child: TextButton(
                              onPressed: () {
                                Routes.push(context, '/resetPassword');
                              },
                              child: Container(
                                child: Text(
                                  'Forgot Your Password?',
                                  style: TextStyle(
                                      color: AppColor.primaryText,
                                      fontSize: 15.sp,
                                      decoration: TextDecoration.underline),
                                ),
                              )),
                        ),
                        Offstage(
                          offstage: this._currentTab == 1,
                          child: SizedBox(
                            height: 28.w,
                          ),
                        ),
                        Text('Quick Access With',
                            style: TextStyle(color: AppColor.primaryText)),
                        SizedBox(
                          height: 16.5.h,
                        ),
                        Wrap(
                          spacing: 21.5.w,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInCtrl.signInWithGoogle();
                              },
                              child: Image.asset(
                                'assets/images/signIn/gg.png',
                                width: 38.w,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                signInCtrl.signInFacebook();
                              },
                              child: Image.asset(
                                'assets/images/signIn/fb.png',
                                width: 38.w,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                signInCtrl.signWithTwitter();
                              },
                              child: Image.asset(
                                'assets/images/signIn/tt.png',
                                width: 38.w,
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
