/*
 * @Author       : JHao
 * @Date         : 2021-07-16 18:39:18
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 16:15:40
 */
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Toast {
  static void loading({String text}) {
    EasyLoading.show(status: text ?? 'loading...');
  }

  static void showProgress(double value, String text) {
    EasyLoading.showProgress(0.3, status: text ?? 'downloading...');
  }

  static void success(String text) {
    EasyLoading.showSuccess(text ?? 'Success');
  }

  static void error(String text) {
    EasyLoading.showError(text ?? 'Error');
  }

  static void warn(String text) {
    EasyLoading.showInfo(text ?? 'Warning');
  }

  static void message(String text) {
    EasyLoading.showToast(text ?? 'Message');
  }

  static void clear() {
    EasyLoading.dismiss();
  }
}
