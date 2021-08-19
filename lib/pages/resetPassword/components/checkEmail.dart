/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 18:20:33
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-19 17:26:56
 */
import 'package:flutter/gestures.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/generated/l10n.dart';

import '../controller.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResetPasswordCtrl>(
        builder: (BuildContext context, ResetPasswordCtrl data, child) =>
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).resetpassword_check,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 8.h,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColor.primaryText),
                          children: <InlineSpan>[
                        TextSpan(text: S.of(context).resetpassword_checkTip1),
                        TextSpan(
                            text: data.email,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: S.of(context).resetpassword_checkTip2)
                      ])),
                  SizedBox(
                    height: 28.h,
                  ),
                  Text(S.of(context).resetpassword_remind1,
                      style: TextStyle(
                          color: AppColor.primaryText, fontSize: 14.sp)),
                  Text(S.of(context).resetpassword_remind2,
                      style: TextStyle(
                          color: AppColor.primaryText, fontSize: 14.sp)),
                  // RichText(
                  //     text: TextSpan(
                  //   style:
                  //       TextStyle(color: AppColor.primaryText, fontSize: 14.sp),
                  //   children: [
                  //     TextSpan(text: S.of(context).resetpassword_remind3),
                  //     TextSpan(
                  //         text: S.of(context).resetpassword_supportCenter,
                  //         style:
                  //             TextStyle(decoration: TextDecoration.underline),
                  //         recognizer: TapGestureRecognizer()
                  //           ..onTap = () {
                  //             // print('object');
                  //           }),
                  //     TextSpan(text: S.of(context).resetpassword_remind4)
                  //   ],
                  // )),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              AppColor.primaryPressed),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ))),
                      onPressed: () {
                        Routes.goHome();
                      },
                      child: Text(S.of(context).resetpassword_Home,
                          style: TextStyle(fontSize: 16.sp)),
                    ),
                  ),
                ],
              ),
            ));
  }
}
