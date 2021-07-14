/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 10:42:03
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 13:42:06
 */
import 'package:homary/common/utils/main.dart';
import 'controller.dart';
import 'package:homary/components/header/main.dart';

class ResetPasswordView extends StatefulWidget {
  ResetPasswordView({Key key}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResetPasswordCtrl>(
        builder: (BuildContext context, ResetPasswordCtrl data, child) =>
            Scaffold(
              appBar: PreferredSize(
                child: Header(
                  'Reset Password',
                  backEvent: data.previousView,
                ),
                preferredSize: Size.fromHeight(95.h),
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
                child: (data.viewList[data.currentView]),
              ),
            ));
  }
}

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ResetPasswordCtrl>(
          create: (context) => ResetPasswordCtrl(),
        )
      ],
      child: ResetPasswordView(),
    );
  }
}
