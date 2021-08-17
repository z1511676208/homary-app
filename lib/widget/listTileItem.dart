/*
 * @Author       : zhhjie
 * @Date         : 2021-08-23 13:59:48
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-23 14:05:22
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
          contentPadding: EdgeInsets.only(left: 10.w, right: 30.w),
          shape: Border(
              bottom: BorderSide(color: AppColor.primaryBorderBottomLine)),
          onTap: () {},
        ),
        Positioned(
            right: 10.w,
            child: Icon(
              Iconfont.ArrowRight,
              size: 14.w,
            ))
      ],
    );
  }
}
