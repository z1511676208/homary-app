import 'package:flutter/gestures.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/common/utils/validator.dart';
import 'package:homary/components/formInput/main.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/signIn/components/head.dart';
import 'package:homary/pages/signIn/components/signInTabBar.dart';
import 'components/emailPattens.dart';
import 'controller.dart';

class SignInView extends StatefulWidget {
  final String redirect;

  SignInView({this.redirect, Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  int _currentTab = 0;
  String email;
  String password;
  bool subscribe = true;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController pwdEditingController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  void _switchTab(ctx, int idx) {
    emailEditingController.clear();
    pwdEditingController.clear();
    this.setState(() {
      this._currentTab = idx;
    });
    Provider.of<SignInCtrl>(context, listen: false).closeEmailTipPopup();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('redirect=> ${widget.redirect}');
      Provider.of<SignInCtrl>(context, listen: false)
          .setRedirect(widget.redirect);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(
        showBorder: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        color: Colors.white,
        child: Column(
          children: [
            SignInHead(),
            Consumer<SignInCtrl>(
              builder: (context, SignInCtrl controller, child) => Form(
                  child: Stack(
                children: [
                  Column(
                    children: [
                      SignInTabBar(
                        switchTab: (ctx, idx) {
                          _switchTab(ctx, idx);
                        },
                        currentTab: _currentTab,
                      ),
                      Offstage(
                        offstage: this._currentTab != 1,
                        child: Container(
                            // decoration: BoxDecoration(
                            //   border:Border.all(color: ),
                            //   )
                            // ),
                            ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Input(
                              innerText: S.of(context).login_email,
                              autoValidator: true,
                              textController: emailEditingController,
                              focusNode: emailFocusNode,
                              validator: (val) => checkEmail(
                                  val, S.of(context).login_emailError),
                              onSaved: (val, error) {
                                email = error == null ? val : null;
                              },
                              onChange: (val) {
                                controller.reseteEailPatterns(val);
                                if (controller.loginInEmailErr != null) {
                                  controller.setLoginInEmailErrNull();
                                }
                              },
                              onClear: () {
                                email = null;
                                controller.reseteEailPatterns('');
                              }),
                          Positioned(
                            bottom: -20.w,
                            left: 0,
                            child: Offstage(
                                offstage: controller.loginInEmailErr == null ||
                                    controller.loginInEmailErr == '',
                                child: Container(
                                  margin: EdgeInsets.only(top: 6.w),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    controller.loginInEmailErr ?? '',
                                    style: TextStyle(
                                        color: AppColor.primaryErrorTip),
                                  ),
                                )),
                          )
                        ],
                      ),
                      SizedBox(height: 28.w),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Input(
                            innerText: S.of(context).login_password,
                            autoValidator: true,
                            textController: pwdEditingController,
                            isPwd: true,
                            validator: (val) => checkPassWord(val,
                                '${this._currentTab == 0 ? S.of(context).login_passwordError : S.of(context).register_passwordError}'),
                            onSaved: (val, error) {
                              password = error == null ? val : null;
                            },
                            onChange: (val) {
                              if (controller.loginInPassErr != null) {
                                controller.setloginInPassErrNull();
                              }
                            },
                          ),
                          Positioned(
                            bottom: -20.w,
                            left: 0,
                            child: Offstage(
                                offstage: controller.loginInPassErr == null ||
                                    controller.loginInPassErr == '',
                                child: Container(
                                  margin: EdgeInsets.only(top: 6.w),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    controller.loginInPassErr ?? '',
                                    style: TextStyle(
                                        color: AppColor.primaryErrorTip),
                                  ),
                                )),
                          )
                        ],
                      ),
                      SizedBox(height: 36.w),
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
                                      })),
                            ),
                            Container(
                              width: 290.w,
                              child: Text(S.of(context).register_followTips,
                                  maxLines: 3,
                                  style:
                                      TextStyle(color: AppColor.primaryText)),
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
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36.0.w),
                                  ))),
                              onPressed: () async {
                                var _form = Form.of(ctx);
                                _form.save();
                                if (email != '' &&
                                    email != null &&
                                    password != '' &&
                                    password != null) {
                                  _currentTab == 0
                                      ? await controller.signIn(
                                          ctx, email, password)
                                      : await controller.userRegister(
                                          ctx, email, password, subscribe);
                                }
                              },
                              icon: Icon(Icons.lock_sharp),
                              label: Text(
                                  '${this._currentTab == 0 ? S.of(context).login_signIn : S.of(context).register_btn}',
                                  style: TextStyle(fontSize: 16.sp)),
                            );
                          })),
                      Offstage(
                          offstage: this._currentTab != 1,
                          child: Container(
                              margin: EdgeInsets.only(top: 28.h),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                          text:
                                              S.of(context).register_agreeTips),
                                      TextSpan(
                                        text: S.of(context).register_privacy,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                      ),
                                      TextSpan(
                                          text: S
                                              .of(context)
                                              .register_agreeTipsAnd),
                                      TextSpan(
                                        text: S.of(context).register_terms,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                      ),
                                    ]),
                              ))),
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
                                        S.of(context).login_forget,
                                        style: TextStyle(
                                            color: AppColor.primaryText,
                                            fontSize: 15.sp,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )),
                              ),
                              Offstage(
                                offstage: this._currentTab == 1,
                                child: SizedBox(
                                  height: 28.w,
                                ),
                              ),
                              Text(S.of(context).login_quickAccessWith,
                                  style:
                                      TextStyle(color: AppColor.primaryText)),
                              SizedBox(
                                height: 16.5.h,
                              ),
                              Wrap(
                                spacing: 21.5.w,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.signInWithGoogle(context);
                                    },
                                    child: Image.asset(
                                      'assets/images/signIn/gg.png',
                                      width: 38.w,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.signInFacebook(context);
                                    },
                                    child: Image.asset(
                                      'assets/images/signIn/fb.png',
                                      width: 38.w,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.signWithTwitter(context);
                                    },
                                    child: Image.asset(
                                      'assets/images/signIn/tt.png',
                                      width: 38.w,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                  Positioned(
                      top: 132.w,
                      left: 0,
                      child: Offstage(
                        offstage: !controller.showEmailTip,
                        child: EmailPattens(onSelect: (val) {
                          emailEditingController.text = val;
                          emailFocusNode.unfocus();
                        }),
                      ))
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  final String redirect;
  const SignInPage({this.redirect, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SignInCtrl>(
            create: (context) => SignInCtrl(),
          )
        ],
        child: SignInView(
          redirect: redirect,
        ));
  }
}
