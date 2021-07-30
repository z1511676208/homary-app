/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 17:42:09
 */

import 'package:flutter/material.dart';
import 'package:homary/common/style/main.dart';
import 'package:homary/widget/goBackIconBtn.dart';

import 'moreButton.dart';

class GoBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCollet;
  final bool showCart;
  final bool showMore;
  final bool showBorder;
  const GoBackAppBar(
      {Key key,
      this.title = "",
      this.showCart = false,
      this.showCollet = false,
      this.showMore = false,
      this.showBorder = true})
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
          title: Text(this.title,
              style: TextStyle(
                color: AppColor.primaryText,
              )),
          backgroundColor: Colors.white,
          leading: GobackIconBtn(),
          actions: [
            Offstage(
              offstage: !this.showCollet,
              child: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {}),
            ),
            Offstage(
              offstage: !this.showCart,
              child: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {}),
            ),
            Offstage(
              offstage: !this.showMore,
              child: MoreButton(),
            ),
          ],
        ));
  }
}
