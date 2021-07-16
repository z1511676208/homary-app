/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 10:59:39
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 19:28:40
 */
import 'package:homary/common/utils/main.dart';

import 'components/checkEmail.dart';
import 'components/inputEmail.dart';

class ResetPasswordCtrl with ChangeNotifier {
  final List<Widget> viewList = [
    InputEmail(),
    CheckEmail(),
  ];

  String email;

  void setEmail(val) {
    this.email = val;
  }

  int currentView = 0;

  nextView() {
    this.currentView++;
    notifyListeners();
  }

  previousView() {
    if (this.currentView != 0) {
      this.currentView--;
      notifyListeners();
    } else {
      Routes.pop();
    }
  }
}
