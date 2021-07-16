/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 18:20:33
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 19:50:13
 */
import 'package:flutter/gestures.dart';
import 'package:homary/common/utils/main.dart';

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
                  Text('Check Your Email',
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
                        TextSpan(
                            text: "We've sent a message to the email address "),
                        TextSpan(
                            text: data.email,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                " you have on file with us. Please follow the instructions provided in the message to reset your password.")
                      ])),
                  SizedBox(
                    height: 28.h,
                  ),
                  Text("Didn't receive the mail from us?"),
                  Text('Check your bulk or junk email folder.'),
                  RichText(
                      text: TextSpan(
                    style:
                        TextStyle(color: AppColor.primaryText, fontSize: 16.sp),
                    children: [
                      TextSpan(text: "If you still can't find it, click "),
                      TextSpan(
                          text: "support center",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('object');
                            }),
                      TextSpan(text: ' for help')
                    ],
                  )),
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
                      child: Text('Home', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ),
                ],
              ),
            ));
  }
}
