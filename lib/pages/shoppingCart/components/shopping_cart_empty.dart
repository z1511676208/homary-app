import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/button/button.dart';

class ShoppingCartEmpty extends StatelessWidget {
  const ShoppingCartEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 39.w),
          Image.asset(
            'assets/images/cart/default_no_activity.png',
            width: 90.w,
            height: 90.w,
          ),
          SizedBox(height: 12.w),
          Text(
            S.of(context).shopping_cart_empty,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.w),
          Text(
            S.of(context).shopping_cart_empty_hint,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryLightSubTitle,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.w),
          if (!Localstorage().getBool(StorageKey.IS_LOGIN))
            AppRoundedButton(
              width: 160.w,
              height: 44.w,
              onTap: () => Routes.push(context, Routes.signIn),
              child: Text(
                S.of(context).sign_in,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                ),
              ),
            ),
          SizedBox(height: 12.w),
          AppRoundedButton(
            width: 160.w,
            height: 44.w,
            type: AppRoundedButtonType.Stroke,
            onTap: () => Routes.goHome(),
            child: Text(
              S.of(context).channel_returnHome,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 13.sp,
              ),
            ),
          ),
          SizedBox(height: 40.w),
        ],
      ),
    );
  }
}
