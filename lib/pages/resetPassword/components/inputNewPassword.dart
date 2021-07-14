/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 18:32:36
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-14 18:38:20
 */
/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 18:12:08
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-14 18:23:36
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/validator.dart';
import 'package:homary/components/formInput/main.dart';

class InputNewPassword extends StatelessWidget {
  const InputNewPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(
          'Reset Password',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16.h,
          width: double.infinity,
        ),
        Input(
          innerText: 'New Password',
          isPwd: true,
          validator: (val) => checkPassWord(val),
          onSaved: (val) => {},
        ),
        SizedBox(
          height: 16.h,
          width: double.infinity,
        ),
        Input(
          innerText: 'Confirm New Password',
          isPwd: true,
          validator: (val) => checkPassWord(val),
          onSaved: (val) => {},
        ),
        SizedBox(
          height: 24.h,
          width: double.infinity,
        ),
        ElevatedButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0),
              ))),
          onPressed: () {},
          child: Text('SUbmit', style: TextStyle(fontSize: 16.sp)),
        )
      ],
    ));
  }
}
