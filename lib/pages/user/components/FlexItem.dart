/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 16:10:53
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-17 15:40:21
 */
import 'package:auto_size_text/auto_size_text.dart';
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
    return Expanded(
      child: InkWell(
        onTap: () {
          bool isLogin = Localstorage().getBool('isLogin');
          if (this.url != null && isLogin || !this.needLogin) {
            Routes.push(context, '/webview', params: {
              "appBarTitle": this.title,
              "content": '{"url":"https://m.homary.com${this.url}"}'
            });
          } else {
            Routes.push(context, '/signIn');
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: 16.w,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
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
                      child: AutoSizeText(
                        this.count.toString(),
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                        maxLines: 1,
                        minFontSize: 10,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 30.w,
              margin: EdgeInsets.only(top: 14.w),
              alignment: Alignment.topCenter,
              child: Text(
                this.text,
                style: TextStyle(
                  fontSize: 12.w,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
