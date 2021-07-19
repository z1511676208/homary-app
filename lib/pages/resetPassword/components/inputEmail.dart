/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 18:12:08
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 13:51:46
 */
import 'package:homary/api/user.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/common/utils/validator.dart';
import 'package:homary/components/formInput/main.dart';
import 'package:homary/entity/user.dart';
import 'package:homary/generated/l10n.dart';

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
                    S.of(context).resetpassword_forget,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                  width: double.infinity,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).resetpassword_tip),
                ),
                SizedBox(
                  height: 24.h,
                  width: double.infinity,
                ),
                Input(
                  innerText: S.of(context).login_email,
                  autoValidator: true,
                  validator: (val) =>
                      checkEmail(val, S.of(context).login_emailError),
                  onSaved: (val, error) {
                    String value = error == null ? val : null;
                    data.setEmail(value);
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
                      builder: (ctx) => ElevatedButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                AppColor.primaryPressed),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0),
                            ))),
                        onPressed: () async {
                          var _form = Form.of(ctx);
                          _form.save();

                          if (data.email != null) {
                            Toast.loading();
                            UserSendEmailReq params =
                                UserSendEmailReq(type: 2, email: data.email);
                            DioResult res = await UserApi.userSendEmail(params);
                            if (res.error == null) {
                              Toast.clear();
                              data.nextView();
                            }
                          }
                        },
                        child: Text(S.of(context).resetpassword_continue,
                            style: TextStyle(fontSize: 16.sp)),
                      ),
                    )),
              ],
            ))));
  }
}
