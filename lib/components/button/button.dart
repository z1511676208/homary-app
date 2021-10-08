import 'package:homary/common/utils/main.dart';

enum AppRoundedButtonType {
  /// 默认黄底
  Default,

  /// 白底带边框
  Stroke,
}

class AppRoundedButton extends StatelessWidget {
  const AppRoundedButton({
    Key key,
    this.width,
    this.height,
    this.type = AppRoundedButtonType.Default,
    this.onTap,
    this.child,
  }) : super(key: key);
  final double width;
  final double height;
  final AppRoundedButtonType type;
  final Function onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isDefault = type == AppRoundedButtonType.Default;
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isDefault ? AppColor.primaryColor : Colors.white),
          elevation: MaterialStateProperty.all(0),
          overlayColor: MaterialStateProperty.all(
              isDefault ? AppColor.primaryPressed : AppColor.whiteBtnPressed),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((height ?? 0) / 2),
              side: isDefault
                  ? BorderSide.none
                  : BorderSide(
                      width: 1.w,
                      color: AppColor.primaryColor,
                    ),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
