/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 16:10:53
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-16 20:36:56
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
  final bool needLogin;
  const FlexItem(this.text, this.icon,
      {Key key, this.count, this.url, this.title = '', this.needLogin = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          bool isLogin = Localstorage().getBool('isLogin');
          if (this.url != null && isLogin || !this.needLogin) {
            Routes.push(context, '/webview', params: {
              "appBarTitle": this.title,
              "showAppLoading": '0',
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
                  top: -8.w,
                  right: -8.w,
                  child: Offstage(
                      offstage: this.count == null || this.count == 0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 20.w,
                        width: 20.w,
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
