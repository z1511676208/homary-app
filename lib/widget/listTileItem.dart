/*
 * @Author       : zhhjie
 * @Date         : 2021-08-23 13:59:48
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-26 14:09:26
 */
import 'package:flutter/cupertino.dart';
import 'package:homary/common/utils/main.dart';

class ListTileItem extends StatelessWidget {
  final Widget title;
  final Widget desc;
  final Function onTap;
  const ListTileItem({this.title, this.desc, this.onTap, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ListTile(
            title: title,
            trailing: desc,
            contentPadding: EdgeInsets.only(left: 16.w, right: 30.w),
            onTap: this.onTap),
        Positioned(
            right: 16.w,
            child: Icon(
              Iconfont.ArrowRight,
              size: 12.w,
              color: AppColor.primaryBorderLight,
            ))
      ],
    );
  }
}
