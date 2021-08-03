/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 16:10:53
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-03 10:15:24
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';

class ExpandedItem extends StatelessWidget {
  final String num;
  final String title;
  final String url;
  const ExpandedItem(this.num, this.title, {Key key, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        flex: 1,
        child: Container(
            height: 100.h,
            // color: Colors.red,
            child: InkWell(
                onTap: () {
                  if (this.url != null) {
                    Routes.push(context, '/webview', params: {
                      "showAppLoading": '0',
                      "content": '{"url":"https://m.homary.com${this.url}"}'
                    });
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(this.num,
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
