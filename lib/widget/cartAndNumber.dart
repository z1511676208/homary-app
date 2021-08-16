/*
 * @Author       : zhhjie
 * @Date         : 2021-08-13 10:44:42
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-13 11:25:22
 */
import 'package:homary/common/utils/main.dart';

class CartAndNumber extends StatelessWidget {
  const CartAndNumber({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            color: Colors.black,
            icon: Icon(Iconfont.Cart),
            onPressed: () {
              Routes.push(context, '/webview', params: {
                "showAppLoading": '0',
                "content": '{"url":"https://m.homary.com/shoppingcart"}'
              });
            }),
        Selector(
            builder: (BuildContext context, int cartNum, child) => Positioned(
                top: 0,
                right: 0,
                child: Offstage(
                    offstage: cartNum == 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Text(
                        cartNum.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ))),
            selector: (BuildContext context, GlobalConfig globalConfig) {
              return globalConfig.shopCartNumber;
            })
      ],
    );
  }
}
