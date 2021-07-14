/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 18:12:08
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 19:52:33
 */
import 'package:homary/api/user.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/validator.dart';
import 'package:homary/components/formInput/main.dart';
import 'package:homary/entity/user.dart';

import '../controller.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ResetPasswordCtrl>(
        builder: (BuildContext context, ResetPasswordCtrl data, child) => Form(
                child: Container(
                    child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot Password',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                  width: double.infinity,
                ),
                Text('Enter your email address and we will send you a link.'),
                SizedBox(
                  height: 24.h,
                  width: double.infinity,
                ),
                Input(
                  innerText: 'Email',
                  validator: (val) => checkEmail(val),
                  onSaved: (val) {
                    data.setEmail(val);
                  },
                ),
                SizedBox(
                  height: 24.h,
                  width: double.infinity,
                ),
                Container(
                    height: 48.h,
                    width: double.infinity,
                    child: Builder(
                      builder: (context) => ElevatedButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                AppColor.primaryPressed),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0),
                            ))),
                        onPressed: () {
                          var _form = Form.of(context);
                          if (_form.validate()) {
                            _form.save();
                            UserSendEmailReq params =
                                UserSendEmailReq(type: 2, email: data.email);
                            UserApi.userSendEmail(params);
                            data.nextView();
                          }
                        },
                        child:
                            Text('Continue', style: TextStyle(fontSize: 16.sp)),
                      ),
                    )),
              ],
            ))));
  }
}
