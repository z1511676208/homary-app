/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-18 16:55:14
 */
import 'package:homary/common/utils/bus.dart';
import 'package:homary/common/utils/main.dart';

var busEvent = BusProvider();

class GobackIconBtn extends StatelessWidget {
  final Color color;
  final double size;
  final Function handleGoBackFn;
  const GobackIconBtn(
      {Key key,
      this.color = AppColor.primaryText,
      this.size = 30.0,
      this.handleGoBackFn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (this.handleGoBackFn != null) {
            this.handleGoBackFn();
          } else {
            Routes.pop();
          }
        },
        icon: Icon(Icons.chevron_left, color: this.color, size: this.size.sp));
  }
}
