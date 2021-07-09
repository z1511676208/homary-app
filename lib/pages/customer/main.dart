/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:27:34
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-06 10:29:43
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/webView/customer.dart';

// 客服页面
class CustomerPage extends StatelessWidget {
  const CustomerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white, child: SafeArea(child: CustomerServiceWebview()));
  }
}
