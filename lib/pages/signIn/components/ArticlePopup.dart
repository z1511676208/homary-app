/*
 * @Author       : zhhjie
 * @Date         : 2021-08-17 17:53:01
 * @LastEditors  : zhhjie
<<<<<<< HEAD
 * @LastEditTime : 2021-09-08 17:14:15
=======
 * @LastEditTime : 2021-09-08 17:08:18
>>>>>>> ad1a99c (bugfix:收藏页面排序多语言翻译,注册页弹窗圆角切割)
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
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
          child: Container(
            height: 0.85.sh,
            padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 12.5.w),
            child: WebviewCtrl(
              isInWebviewPage: false,
              content: {
                'url':
                    'https://m.homary.com/appPages/loginArticle?id=${this.id}'
              },
            ),
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
