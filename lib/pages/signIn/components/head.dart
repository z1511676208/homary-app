/*
 * @Author       : zhhjie
 * @Date         : 2021-07-23 14:41:16
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-23 14:42:16
 */
import 'package:homary/common/utils/main.dart';

class SignInHead extends StatelessWidget {
  const SignInHead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 13.h, bottom: 20.5.h),
      child: Center(
        child: Image.asset('assets/logo.png', width: 140.w, height: 46.h),
      ),
    );
  }
}
