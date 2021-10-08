/*
 * @Author       : JHao
 * @Date         : 2021-09-27 18:25:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-30 14:10:38
 */
import 'package:homary/common/utils/main.dart';
import 'package:flutter/material.dart';
import 'package:homary/pages/shoppingCart/components/CouponsAvailable.dart';
import 'package:homary/pages/shoppingCart/components/CouponsUnavailable.dart';
import 'package:homary/pages/shoppingCart/components/tabbar.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class CouponBottomSheet extends StatelessWidget {
  final ShoppingCartCtrl data;
  const CouponBottomSheet({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.6.sh,
        // color: Colors.white,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                height: 50.w,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        S.of(context).my_coupon,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
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
                            'assets/images/home/popup_close.png',
                            width: 18.w,
                            height: 18.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CouponTabbar(
                couponList: data.couponList,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    CouponsAvailable(
                        useableList: data.couponList.useableList ?? []),
                    CouponsUnavailable(
                      diabledList: data.couponList.diabledList ?? [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
