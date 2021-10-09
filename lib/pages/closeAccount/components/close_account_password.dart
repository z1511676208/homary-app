import 'package:homary/common/utils/main.dart';
import 'package:homary/components/button/button.dart';
import 'package:homary/pages/closeAccount/controller.dart';

class CloseAccountPassword extends StatelessWidget {
  CloseAccountPassword({Key key}) : super(key: key);

  final OutlineInputBorder _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.w),
    borderSide: BorderSide(color: AppColor.primaryText, width: 1.w),
  );

  final OutlineInputBorder _errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.w),
    borderSide: BorderSide(color: AppColor.primaryErrorTip, width: 1.w),
  );

  @override
  Widget build(BuildContext context) {
    CloseAccountCtrl ctrl = context.watch<CloseAccountCtrl>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).account_setting_re_enter_password,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 8.w),
        Text(
          S.of(context).account_setting_re_enter_password_msg,
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        SizedBox(height: 19.w),
        Text(
          S.of(context).account_setting_my_password,
          style: TextStyle(
            fontSize: 13.sp,
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10.w),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            cursorColor: AppColor.primaryText,
            maxLines: 1,
            obscureText: ctrl.isShowPassword,
            onChanged: (s) => ctrl.password = s,
            textInputAction: TextInputAction.done,
            onSubmitted: (s) => ctrl.verifyPassword(),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              errorText: ctrl.isPasswordError
                  ? S.of(context).login_passwordError
                  : null,
              errorStyle: TextStyle(
                fontSize: 12.sp,
                color: AppColor.primaryErrorTip,
              ),
              suffixIcon: GestureDetector(
                onTap: ctrl.togglePassword,
                child: Icon(
                  ctrl.isShowPassword ? Iconfont.PwdClose : Iconfont.PwdOpen,
                  size: 15.w,
                  color: AppColor.primaryBorderLight,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 13.w,
              ),
              enabledBorder: _defaultInputBorder,
              focusedBorder: _defaultInputBorder,
              errorBorder: _errorInputBorder,
              focusedErrorBorder: _errorInputBorder,
            ),
          ),
        ),
        SizedBox(height: 17.5.w),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Routes.push(context, Routes.resetPassword),
            child: Text(
              S.of(context).account_setting_forget_password,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14.sp,
                color: AppColor.primaryLightSubTitle,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppRoundedButton(
              width: 158.w,
              height: 44.w,
              type: AppRoundedButtonType.StrokeBlack,
              onTap: ctrl.showDefault,
              child: Text(
                S.of(context).account_setting_cancel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.primaryText,
                  fontSize: 15.sp,
                ),
              ),
            ),
            AppRoundedButton(
              width: 158.w,
              height: 44.w,
              type: AppRoundedButtonType.DefaultBlack,
              onTap: () => ctrl.verifyPassword(),
              child: Text(
                S.of(context).account_setting_continue,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
