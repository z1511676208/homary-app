/*
 * @Author       : JHao
 * @Date         : 2021-09-27 16:39:09
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-30 14:25:19
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/pages/coupons/components/copons_emtpy.dart';
import 'package:homary/pages/shoppingCart/components/coupons_item.dart';

class CouponsUnavailable extends StatelessWidget {
  final List<Coupon> diabledList;

  const CouponsUnavailable({Key key, @required this.diabledList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
      child: this.diabledList.length > 0
          ? ListView.builder(
              clipBehavior: Clip.none,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext ctx, int index) {
                return CouponsItem(
                    available: false, coupon: this.diabledList[index]);
              },
              itemCount: this.diabledList.length,
            )
          : CouponsEmpty(),
    );
  }
}
