import 'package:auto_size_text/auto_size_text.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/coupon.dart';

class CouponsItem extends StatelessWidget {
  const CouponsItem({Key key, this.available = true, @required this.coupon}) : super(key: key);

  final bool available;
  final Coupon coupon;

  Color getTextColor() {
    return available ? AppColor.primaryText : AppColor.primaryLightSubTitle;
  }

  Widget buildUseButton(BuildContext context) {
    return SizedBox(
      width: 64.w,
      height: 20.w,
      child: available
          ? OutlinedButton(
              onPressed: () {
                Routes.goHome();
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: AppColor.couponsButtonColor,
                side: BorderSide(
                  width: 1.w,
                  color: AppColor.couponsButtonColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.w),
                  ),
                ),
              ),
              child: Text(
                S.of(context).coupons_use_now,
                maxLines: 1,
                style: TextStyle(
                  color: AppColor.couponsButtonColor,
                  fontSize: 12.sp,
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.primaryBorderOutline,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Text(
                S.of(context).coupons_expired,
                style: TextStyle(
                  color: getTextColor(),
                  fontSize: 12.sp,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 86.w,
      margin: EdgeInsets.only(bottom: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(3.5.w),
          bottomRight: Radius.circular(3.5.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 105.w,
            height: 86.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(available
                    ? 'assets/images/user/user_coupons_ava.png'
                    : 'assets/images/user/user_coupons_unava.png'),
              ),
            ),
            alignment: Alignment.center,
            child: AutoSizeText(
              '${coupon.couponAmountStr} Off',
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CODE:${coupon.couponAlias}',
                    style: TextStyle(
                      color: getTextColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${S.of(context).coupons_orders_over} ${coupon.thresholdAmount}',
                        style: TextStyle(
                          color: getTextColor(),
                          fontSize: 12.sp,
                        ),
                      ),
                      buildUseButton(context),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 6.w,
                      bottom: 5.w,
                    ),
                    width: double.infinity,
                    child: CustomPaint(painter: DashedLinePainter()),
                  ),

                  Text(
                    '${coupon.startTime}-${coupon.endTime}',
                    style: TextStyle(
                      color: getTextColor(),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Color(0xFFE8E8E8)
      ..strokeWidth = 0.5.w;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}