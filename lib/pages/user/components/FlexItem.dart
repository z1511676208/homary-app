/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 16:10:53
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 11:46:12
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';

class FlexItem extends StatelessWidget {
  final String text;
  final Widget icon;
  final String count;
  final String url;
  const FlexItem(this.text, this.icon, {Key key, this.count = '', this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          if (this.url != null) {
            Routes.push(context, '/webview',
                params: {"content": '{"url":${this.url}}'});
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 16.w,
            ),
            Stack(clipBehavior: Clip.none, children: [
              this.icon,
              Positioned(
                  top: -10.w,
                  right: -10.w,
                  child: Offstage(
                      offstage: this.count == '',
                      child: Container(
                        alignment: Alignment.center,
                        height: 18.w,
                        width: 18.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Text(
                          this.count,
                          style: TextStyle(color: Colors.white),
                        ),
                      )))
            ]),
            SizedBox(
              height: 14.w,
            ),
            Container(child: Text(this.text, style: TextStyle(fontSize: 12.w))),
            SizedBox(
              height: 16.w,
            ),
          ],
        ),
      ),
    ));
  }
}
