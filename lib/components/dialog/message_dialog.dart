import 'package:homary/common/utils/main.dart';

/// 展示一段文字信息的弹窗
class MessageDialog extends StatelessWidget {
  const MessageDialog({
    Key key,
    this.message,
    this.noStr = 'No',
    this.yesStr = 'Yes',
  }) : super(key: key);

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
          Padding(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 26.w, bottom: 12.w),
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
                buildNo(context),
                SizedBox(
                  width: 16.w,
                ),
                buildYes(context),
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
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: AppColor.primaryColor,
              width: 0.5.w,
            ),
          ),
        ),
        child: Text(
          noStr,
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
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: StadiumBorder(),
        ),
        child: Text(
          yesStr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
