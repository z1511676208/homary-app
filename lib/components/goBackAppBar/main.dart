/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-20 14:28:16
 */

import 'package:flutter/material.dart';
import 'package:homary/common/style/main.dart';
import 'package:homary/components/appBar/search/main.dart';
import 'package:homary/router/routes.dart';
import 'package:homary/widget/cartAndNumber.dart';
import 'package:homary/widget/goBackIconBtn.dart';
import 'package:homary/widget/wishIconButton.dart';

import 'moreButton.dart';

class GoBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCollet;
  final bool showCart;
  final bool showMore;
  final bool showBorder;
  final Function handleGoBackFn;
  final bool showSearch;
  const GoBackAppBar(
      {Key key,
      this.title = "",
      this.handleGoBackFn,
      this.showCart = false,
      this.showCollet = false,
      this.showMore = false,
      this.showBorder = true,
      this.showSearch = false})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.5.h,
                    color: this.showBorder
                        ? AppColor.primaryBorderOutline
                        : Colors.white))),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: !this.showSearch
              ? Text(this.title,
                  style: TextStyle(
                    color: AppColor.primaryText,
                  ))
              : AppbarSearch(),
          backgroundColor: Colors.white,
          leading: GobackIconBtn(
            handleGoBackFn: this.handleGoBackFn,
          ),
          actions: [
            Offstage(
              offstage: !this.showCollet,
              child: WishIconButton(),
            ),
            Offstage(offstage: !this.showCart, child: CartAndNumber()),
            Offstage(
              offstage: !this.showMore,
              child: MoreButton(),
            ),
          ],
        ));
  }
}
