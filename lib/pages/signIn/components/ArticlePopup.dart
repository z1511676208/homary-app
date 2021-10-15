import 'package:homary/common/utils/main.dart';
import 'package:homary/components/bottomSheet/keep_alive_bottom_sheet.dart';
import 'package:homary/webView/webviewController.dart';

class ArticlePopup extends StatelessWidget {
  final String id;
  const ArticlePopup(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 0.85.sh,
          padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 4.w),
          child: WebviewCtrl(
            isInWebviewPage: false,
            content: {
              'url':
              'https://m.homary.com/appPages/loginArticle?id=${this.id}'
            },
          ),
        ),
        Positioned(
            right: 16.w,
            top: 12.5.w,
            child: IconButton(
              splashRadius:11,
              onPressed: () {
                KeepAliveBottomSheetManager.of(context).hide();
              },
              iconSize: 22,
              icon: Icon(Iconfont.PopupClose),
            ))
      ],
    );
  }
}
