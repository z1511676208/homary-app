import 'package:homary/common/utils/main.dart';

class OrdersEmpty extends StatelessWidget {
  const OrdersEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7.5.w,
            color: AppColor.primaryBackground,
          ),
          SizedBox(
            height: 30.w,
          ),
          Image.asset(
            'assets/images/order/default_no_order.png',
            width: 80.w,
            height: 80.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.w),
            child: Text(
              S.of(context).my_orders_empty,
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
