import 'package:homary/common/utils/main.dart';

/// 展示一段文字信息的弹窗
class MessageDialog extends StatelessWidget {
  const MessageDialog({
    Key key,
    this.title,
    this.message,
    this.noStr = 'No',
    this.yesStr = 'Yes',
  }) : super(key: key);

  /// 标题
  final String title;

  /// 显示的文字信息
  final String message;

  /// 取消选择的文字，默认为No
  final String noStr;

  /// 选择的文字，默认为Yes
  final String yesStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 26.w),
          if (title != null)
            Padding(
              padding: EdgeInsets.only(
                  left: 24.w, right: 24.w, top: 12.w, bottom: 12.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 12.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.primaryText,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.w,
              horizontal: 26.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (noStr != null) ...[
                  Expanded(child: buildNo(context)),
                  SizedBox(
                    width: 16.w,
                  ),
                ],
                Expanded(child: buildYes(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNo(BuildContext context) {
    return SizedBox(
      width: 116.w,
      height: 36.w,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context, false),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(AppColor.whiteBtnPressed),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0.w),
              side: BorderSide(
                width: 1.w,
                color: AppColor.primaryColor,
              ),
            ))),
        child: Text(
          noStr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.primaryColor,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  Widget buildYes(BuildContext context) {
    return SizedBox(
      width: 116.w,
      height: 36.w,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context, true),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColor.primaryColor),
            elevation: MaterialStateProperty.all(0),
            overlayColor: MaterialStateProperty.all(AppColor.primaryPressed),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0.w),
            ))),
        child: Text(
          yesStr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
