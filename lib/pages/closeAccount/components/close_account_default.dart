import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/bottomSheet/keep_alive_bottom_sheet.dart';
import 'package:homary/components/button/button.dart';
import 'package:homary/pages/closeAccount/controller.dart';
import 'package:homary/provider/auth_ctrl.dart';

class CloseAccountDefault extends StatelessWidget {
  const CloseAccountDefault({Key key}) : super(key: key);

  void closeAccount(BuildContext context, CloseAccountCtrl ctrl) async {
    if (ctrl.data.applyStatus == 'ORDER_PROCESS') {
      // 订单进行中
      ctrl.showUnable();
      return;
    }

    final userInfo = context.read<AuthCtrl>().userInfo;
    if (userInfo != null &&
        userInfo.isAuth != null &&
        userInfo.isAuth is String &&
        userInfo.isAuth == 'AUTH_YES') {
      // 三方登录，不用输入密码
      await ctrl.getApplyList(showLoading: true);
      ctrl.showReason();
      return;
    }

    ctrl.showPassword();
  }

  @override
  Widget build(BuildContext context) {
    CloseAccountCtrl ctrl = context.watch<CloseAccountCtrl>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ctrl.data.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.5.w,
          color: Color(0xFFE2E2E2),
          margin: EdgeInsets.only(
            top: 12.w,
            bottom: 15.5.w,
          ),
        ),
        HtmlWidget(
          ctrl.data.info,
          onTapUrl: (String url) {
            KeepAliveBottomSheetManager.of(context).show();
          },
        ),
        // 非审核状态
        if (ctrl.data.applyStatus != 'UNDER_REVIEW')
          Padding(
            padding: EdgeInsets.only(top: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppRoundedButton(
                  width: 158.w,
                  height: 44.w,
                  type: AppRoundedButtonType.DefaultBlack,
                  onTap: () => closeAccount(context, ctrl),
                  child: Text(
                    S.of(context).account_setting_leave_homary,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                AppRoundedButton(
                  width: 158.w,
                  height: 44.w,
                  type: AppRoundedButtonType.StrokeBlack,
                  onTap: () => Routes.goHome(pageIndex: 3),
                  child: Text(
                    S.of(context).account_setting_want_stay,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primaryText,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        // 审核中
        if (ctrl.data.applyStatus == 'UNDER_REVIEW')
          Padding(
            padding: EdgeInsets.only(top: 16.w),
            child: Column(
              children: [
                AppRoundedButton(
                  width: double.infinity,
                  height: 44.w,
                  type: AppRoundedButtonType.DefaultBlack,
                  onTap: ctrl.cancel,
                  child: Text(
                    S.of(context).account_setting_cancel_closed_account,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.w),
                Text(
                  ctrl.data.reviewTips,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primarySubTitle,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
