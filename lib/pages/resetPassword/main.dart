/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 10:42:03
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-27 16:37:43
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'controller.dart';

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
              appBar: GoBackAppBar(
                title: 'Reset Password',
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
