/*
 * @Author       : zhhjie
 * @Date         : 2021-08-13 10:44:42
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-29 18:16:48
 */
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/provider/auth_ctrl.dart';

class CartAndNumber extends StatelessWidget {
  const CartAndNumber({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        IconButton(
            color: Colors.black,
            icon: Icon(
              Iconfont.Cart,
            ),
            onPressed: () {
              Localstorage().setGaTicketList(TicketList.cart);
              Routes.push(context, '/shoppingcart');
            }),
        Selector(
            builder: (BuildContext context, int cartNum, child) => Positioned(
                top: 1.w,
                right: 0,
                child: Offstage(
                    offstage: cartNum == 0,
                    child: Container(
                        padding: EdgeInsets.all(4.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: GestureDetector(
                          onTap: () {
                            Localstorage().setGaTicketList(TicketList.cart);
                            Routes.push(context, '/shoppingcart');
                          },
                          child: Text(
                            cartNum.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )))),
            selector: (BuildContext context, AuthCtrl authCtrl) {
              return authCtrl.shopCartNumber;
            })
      ],
    );
  }
}
