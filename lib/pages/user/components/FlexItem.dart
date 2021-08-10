/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 16:10:53
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-10 17:04:29
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';

class FlexItem extends StatelessWidget {
  final String text;
  final Widget icon;
  final int count;
  final String url;
  final String title;
  const FlexItem(this.text, this.icon,
      {Key key, this.count, this.url, this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          bool isLogin = Localstorage().getBool('isLogin');
          if (this.url != null && isLogin) {
            Routes.push(context, '/webview', params: {
              "appBarTitle": this.title,
              "content": '{"url":"https://m.homary.com${this.url}"}'
            });
          } else {
            Routes.push(context, '/signIn');
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
                      offstage: this.count == null || this.count == 0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 18.w,
                        width: 18.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Text(
                          this.count.toString(),
                          maxLines: 1,
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
