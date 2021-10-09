import 'package:homary/common/utils/main.dart';
import 'package:homary/components/bottomSheet/keep_alive_bottom_sheet.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/pages/closeAccount/components/close_account_default.dart';
import 'package:homary/pages/closeAccount/components/close_account_password.dart';
import 'package:homary/pages/closeAccount/components/close_account_reason.dart';
import 'package:homary/pages/closeAccount/components/close_account_unable.dart';
import 'package:homary/pages/closeAccount/controller.dart';
import 'package:homary/pages/signIn/components/ArticlePopup.dart';

class CloseAccountPage extends StatelessWidget {
  const CloseAccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CloseAccountCtrl(),
      child: KeepAliveBottomSheet(
        bottomSheet: [ArticlePopup('57')],
        child: Consumer<CloseAccountCtrl>(
          builder: (context, ctrl, __) {
            return WillPopScope(
              onWillPop: ctrl.status != 0
                  ? () {
                      ctrl.showDefault();
                      return Future.value(false);
                    }
                  : null,
              child: Scaffold(
                backgroundColor: AppColor.primaryBackground,
                appBar: GoBackAppBar(
                  title: S.of(context).account_setting_close_account,
                ),
                body: ctrl.data == null
                    ? Container()
                    : SingleChildScrollView(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 10.w,
                          bottom: 10.w + MediaQuery.of(context).padding.bottom,
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 18.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: ctrl.status == 0
                              ? CloseAccountDefault()
                              : ctrl.status == 1
                                  ? CloseAccountPassword()
                                  : ctrl.status == 2
                                      ? CloseAccountReason()
                                      : CloseAccountUnable(),
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
