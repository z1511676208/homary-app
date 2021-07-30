/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 17:43:26
 */
import 'package:homary/common/utils/bus.dart';
import 'package:homary/common/utils/main.dart';

var busEvent = BusProvider();

class GobackIconBtn extends StatelessWidget {
  final Color color;
  final double size;
  const GobackIconBtn(
      {Key key, this.color = AppColor.primaryText, this.size = 30.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          busEvent.pubWebViewCtrl('goback');
        },
        icon: Icon(Icons.chevron_left, color: this.color, size: this.size.sp));
  }
}
