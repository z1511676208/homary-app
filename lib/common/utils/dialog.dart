/*
 * @Author       : JHao
 * @Date         : 2021-08-23 14:39:51
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-06 18:24:16
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/dialog/message_dialog.dart';

/// App弹窗管理类
class AppDialog {
  /// 自定义弹窗
  /// [context] context
  /// [widget] 自定义弹窗widget
  /// [canCancel] 点击弹窗外部区域或返回键，是否可取消弹窗。默认可以
  static Future<T> show<T>({
    @required BuildContext context,
    @required Widget widget,
    bool canCancel = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: canCancel,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return Future.value(canCancel);
          },
          child: Center(child: widget),
        );
      },
    );
  }

  /// 展示一段文字信息的弹窗
  /// [context] context
  /// [message] 需要显示的文字信息
  /// [canCancel] 点击弹窗外部区域或返回键，是否可取消弹窗。默认可以
  static Future<bool> showMessage({
    @required BuildContext context,
    String title,
    String message,
    String noStr = "No",
    String yesStr = "Yes",
    bool canCancel = true,
  }) {
    return show<bool>(
      context: context,
      canCancel: canCancel,
      widget: MessageDialog(
        title: title,
        message: message,
        noStr: noStr,
        yesStr: yesStr,
      ),
    );
  }
}
