/*
 * @Author       : zhhjie
 * @Date         : 2021-08-19 10:27:07
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-19 10:29:00
 */
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';

class WishIconButton extends StatelessWidget {
  const WishIconButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.black,
        icon: Icon(Icons.favorite_border),
        onPressed: () {
          bool isLogin = Localstorage().getBool('isLogin');
          if (isLogin) {
            Routes.push(context, '/webview', params: {
              "content": '{"url":"http://m.homary.com/usercenter/wishlists"}'
            });
          } else {
            Routes.push(context, '/signIn');
          }
        });
  }
}
