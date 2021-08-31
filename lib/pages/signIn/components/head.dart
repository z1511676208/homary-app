/*
 * @Author       : zhhjie
 * @Date         : 2021-07-23 14:41:16
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-31 11:45:20
 */
import 'package:homary/common/utils/main.dart';

class SignInHead extends StatelessWidget {
  const SignInHead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 13.w, bottom: 20.5.w),
      child: Center(
        child: Image.asset('assets/logo.png', width: 140.w, height: 46.w),
      ),
    );
  }
}
