/*
 * @Author       : zhhjie
 * @Date         : 2021-08-13 10:44:42
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-14 16:51:47
 */
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/provider/auth_ctrl.dart';

class CartAndNumber extends StatelessWidget {
  final Color backgroundColor;
  const CartAndNumber({Key key, this.backgroundColor = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        IconButton(
            color: AppColor.primaryText,
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
                        padding: EdgeInsets.all(5.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: this.backgroundColor),
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
