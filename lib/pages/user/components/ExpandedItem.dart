/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 16:10:53
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-06 15:17:08
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';

class ExpandedItem extends StatelessWidget {
  final int num;
  final String title;
  final String url;
  final String appBarTitle;
  const ExpandedItem(this.num, this.title,
      {Key key, this.url, this.appBarTitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        flex: 1,
        child: Container(
            height: 90.w,
            // color: Colors.red,
            child: InkWell(
                onTap: () {
                  bool isLogin = Localstorage().getBool(StorageKey.IS_LOGIN);
                  if (this.url != null && isLogin) {
                    if (url.startsWith('https://')) {
                      Routes.push(context, '/webview', params: {
                        "appBarTitle": this.appBarTitle,
                        "showAppLoading":
                            this.url.indexOf('/usercenter/coupons') != -1
                                ? '1'
                                : '0',
                        "content": '{"url":"https://m.homary.com${this.url}"}'
                      });
                    } else {
                      if (url == '/') {
                        Routes.goHome();
                      } else {
                        Routes.push(context, url);
                      }
                    }
                  } else {
                    Routes.push(context, '/signIn');
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(this.num.toString(),
                          style: TextStyle(
                              fontSize: 18.w, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                        child:
                            Text(this.title, style: TextStyle(fontSize: 12.w)))
                  ],
                ))),
      ),
    );
  }
}
