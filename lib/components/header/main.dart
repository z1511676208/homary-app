/*
 * @Author       : zhhjie
 * @Date         : 2021-07-15 09:48:00
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 19:37:04
 */

import 'package:homary/common/utils/main.dart';

class Header extends StatelessWidget {
  final String title;
  final Function backEvent;
  const Header(this.title, {Key key, this.backEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5.h, color: AppColor.primaryBorderOutline))),
          height: 44.h,
          child: Row(
            children: [
              Container(
                width: 100.w,
                child: Row(
                  children: [
                    IconButton(
                        color: Colors.black,
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        onPressed: () =>
                            backEvent != null ? backEvent() : Routes.pop())
                  ],
                ),
              ),
              Flexible(
                child: Center(
                  child: Text(
                    title,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 100.w,
              )
            ],
          ),
        ));
  }
}
