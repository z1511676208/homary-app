import 'package:homary/common/utils/main.dart';

class CouponsEmpty extends StatelessWidget {
  const CouponsEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 60.w,
        ),
        Image.asset(
          'assets/images/user/user_coupon_empty.png',
          width: 90.w,
          height: 90.w,
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.w),
          child: Text(
            S.of(context).coupons_empty,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
