/*
 * @Author       : JHao
 * @Date         : 2021-09-27 16:36:21
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-27 20:02:03
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/pages/home/components/tabBar/CustomUnderlineTabIndicator.dart';

class CouponTabbar extends StatelessWidget {
  final CouponList couponList;
  const CouponTabbar({Key key, @required this.couponList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PhysicalModel(
          color: Colors.white,
          shadowColor: Color(0x30000000),
          elevation: 6.w,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: TabBar(
              tabs: [
                Tab(
                  text: S.of(context).coupons_available(
                      this.couponList.useableList?.length ?? 0),
                ),
                Tab(
                  text: S.of(context).coupons_unavailable(
                      this.couponList.diabledList?.length ?? 0),
                ),
              ],
              labelColor: AppColor.primaryColor,
              unselectedLabelColor: AppColor.primarySubTitle,
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp),
              indicator: CustomUnderlineTabIndicator(
                  width: 72.w,
                  insets: EdgeInsets.fromLTRB(0, 0, 0, 4.w),
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                    width: 3.h,
                  ),
                  strokeCap: StrokeCap.round),
            ),
          ),
        );
      },
    );
  }
}
