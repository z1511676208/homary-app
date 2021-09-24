import 'package:flutter/cupertino.dart';
import 'package:homary/common/utils/main.dart';

class OrderCancelSelect extends StatefulWidget {
  const OrderCancelSelect({Key key}) : super(key: key);

  @override
  _OrderCancelSelectState createState() => _OrderCancelSelectState();
}

class _OrderCancelSelectState extends State<OrderCancelSelect> {
  List<String> list = [];
  int _selectIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        list.addAll([
          S.of(context).my_orders_order_cancel_reason_1,
          S.of(context).my_orders_order_cancel_reason_2,
          S.of(context).my_orders_order_cancel_reason_3,
          S.of(context).my_orders_order_cancel_reason_4,
          S.of(context).my_orders_order_cancel_reason_5,
        ]);
      });
    });
  }

  void _onSelect(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50.w,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      S.of(context).my_orders_order_cancel_title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/images/order/order_windows_close.png',
                        width: 19.w,
                        height: 19.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 10.w,
              bottom: 15.w,
            ),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColor.primaryBackground,
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Text(
              S.of(context).my_orders_order_cancel_hint,
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onSelect(index),
                child: Container(
                  height: 44.w,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: Radio(
                          value: index,
                          groupValue: _selectIndex,
                          onChanged: (value) {
                            _onSelect(value);
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          list[index],
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: _selectIndex == index
                                ? AppColor.primaryColor
                                : AppColor.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            height: 0.5.w,
            margin: EdgeInsets.only(top: 40.w),
            width: double.infinity,
            color: Color(0xFFE8E8E8),
          ),
          Container(
            width: double.infinity,
            height: 34.w,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16.w,
            ),
            child: ElevatedButton(
              onPressed: _selectIndex == -1
                  ? null
                  : () {
                Navigator.pop(context, list[_selectIndex]);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                onSurface: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.w),
                ),
              ),
              child: Text(
                S.of(context).submit,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
