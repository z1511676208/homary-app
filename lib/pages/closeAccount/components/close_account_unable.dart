import 'package:homary/common/utils/main.dart';
import 'package:homary/components/button/button.dart';

class CloseAccountUnable extends StatelessWidget {
  const CloseAccountUnable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).account_setting_cancel_unable,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 8.w),
        Text(
          S.of(context).account_setting_cancel_unable_msg,
          style: TextStyle(
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 12.w),
        GestureDetector(
          onTap: () => Routes.push(context, Routes.myOrders),
          child: Container(
            height: 54.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(
                  S.of(context).account_setting_order_progress,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),),
                Icon(
                  Iconfont.ArrowRight,
                  size: 12.w,
                  color: AppColor.primaryBorderLight,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1.w,
          color: Color(0xFFEBEBEB),
        ),
        GestureDetector(
          onTap: () => Routes.push(context, '/usercenter/order?active=returns'),
          child: Container(
            height: 54.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(
                  S.of(context).account_setting_after_sale_progress,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),),
                Icon(
                  Iconfont.ArrowRight,
                  size: 12.w,
                  color: AppColor.primaryBorderLight,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1.w,
          color: Color(0xFFEBEBEB),
        ),
        SizedBox(height: 24.w),
        Text(
          S.of(context).account_setting_cancel_unable_tips,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.primarySubTitle,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 8.w),
        AppRoundedButton(
          width: double.infinity,
          height: 44.w,
          type: AppRoundedButtonType.StrokeBlack,
          onTap: () => Routes.goHome(pageIndex: 3),
          child: Text(
            S.of(context).account_setting_want_stay,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColor.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}
