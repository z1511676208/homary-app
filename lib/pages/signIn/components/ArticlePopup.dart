/*
 * @Author       : zhhjie
 * @Date         : 2021-08-17 17:53:01
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-08 16:10:02
 */

import 'package:homary/common/utils/main.dart';
import 'package:homary/webView/webviewController.dart';

class ArticlePopup extends StatelessWidget {
  final String id;
  const ArticlePopup(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 0.85.sh,
          padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 12.5.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
          child: WebviewCtrl(
            isInWebviewPage: false,
            content: {
              'url': 'https://m.homary.com/appPages/loginArticle?id=${this.id}'
            },
          ),
        ),
        Positioned(
            right: 16.w,
            top: 12.5.w,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 22,
              icon: Icon(Iconfont.PopupClose),
            ))
      ],
    );
  }
}
