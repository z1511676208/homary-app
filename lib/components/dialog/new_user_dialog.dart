import 'package:auto_size_text/auto_size_text.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/home_pop_up.dart';

class NewUserDialog extends StatelessWidget {
  const NewUserDialog({Key key, this.datum, this.isLogin, this.onTap})
      : super(key: key);
  final HomePopUpDatum datum;
  final bool isLogin;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 450.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home/popup_couple.png'),
        ),
      ),
      child: Column(
        children: [
          buildClose(context),
          ...buildTitle(context),
          ...buildCenter(context),
          buildButton(context),
          buildBottom(context),
        ],
      ),
    );
  }

  Widget buildClose(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.maybePop(context, false),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Image.asset(
              'assets/images/home/popup_close.png',
              width: 15.w,
              height: 15.w,
            ),
          )),
    );
  }

  List<Widget> buildTitle(BuildContext context) {
    return [
      Text(
        S.of(context).new_user_welcome,
        style: TextStyle(
          fontSize: 18.sp,
          color: AppColor.primaryText,
          fontWeight: FontWeight.bold,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 6.w),
        child: Text(
          S.of(context).new_user_exclusive,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.primaryText,
          ),
        ),
      ),
    ];
  }

  List<Widget> buildCenter(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.only(
          top: 23.w,
          bottom: 12.w,
        ),
        child: Text(
          '${datum.content.totalAmountStr}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 32.sp,
          ),
        ),
      ),
      Container(
        height: 101.5.w,
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: RawScrollbar(
          isAlwaysShown: true,
          radius: Radius.zero,
          thickness: 2.w,
          thumbColor: Color(0xFFFED65E),
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            itemCount: datum.content.couponList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 7.w,
              crossAxisSpacing: 7.w,
              childAspectRatio: 131 / 55,
            ),
            itemBuilder: (context, index) {
              return buildItem(context, datum.content.couponList[index]);
            },
          ),
        ),
      ),
    ];
  }

  Widget buildItem(BuildContext context, CouponList coupon) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home/popup_coupon.png'),
        ),
      ),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(
          vertical: 3.w,
          horizontal: 5.w,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 3.w,
          horizontal: 6.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '${coupon.couponAmountStr} OFF',
              maxFontSize: 20,
              minFontSize: 8,
              maxLines: 1,
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Text(
              '${S.of(context).new_user_orders_over} ${coupon.thresholdAmount}',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 10.sp,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Container(
      width: 256.w,
      height: 44.w,
      margin: EdgeInsets.only(top: 21.w),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: StadiumBorder(),
        ),
        child: Text(
          isLogin
              ? S.of(context).new_user_get_all
              : S.of(context).new_user_sign_get_all,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.5.w, vertical: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              S.of(context).new_user_free_shipping,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 10.sp,
              ),
            ),
          ),
          Container(
            width: 0.5.w,
            height: 8.w,
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            color: AppColor.primaryText,
          ),
          Expanded(
            child: Text(
              S.of(context).new_user_no_hassle_returns,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 10.sp,
              ),
            ),
          ),
          Container(
            width: 0.5.w,
            height: 8.w,
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            color: AppColor.primaryText,
          ),
          Expanded(
            child: Text(
              S.of(context).new_user_724,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
