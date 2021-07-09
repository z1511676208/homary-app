import 'package:flutter/material.dart';
import 'package:homary/common/style/main.dart';
import 'package:homary/widget/goBackIconBtn.dart';

class GoBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GoBackAppBar({Key key, this.title = ""}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBar(
      elevation: 0,
      title: Text(this.title,
          style: TextStyle(
            color: AppColor.primaryText,
          )),
      backgroundColor: Colors.white,
      leading: GobackIconBtn(),
    ));
  }
}
