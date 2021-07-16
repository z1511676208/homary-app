/*
 * @Author       : JHao
 * @Date         : 2021-07-16 18:39:18
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-16 19:06:19
 */
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Toast {
  static void loading({String text = 'loading...'}) {
    EasyLoading.show(status: text);
  }

  static void showProgress(double value, {String text = 'downloading...'}) {
    EasyLoading.showProgress(0.3, status: text);
  }

  static void success({String text = 'Success'}) {
    EasyLoading.showSuccess(text);
  }

  static void error({String text = 'Error'}) {
    EasyLoading.showError(text);
  }

  static void warn({String text = 'Message'}) {
    EasyLoading.showInfo(text);
  }

  static void message({String text = 'Message'}) {
    EasyLoading.showToast(text);
  }

  static void clear() {
    EasyLoading.dismiss();
  }
}
