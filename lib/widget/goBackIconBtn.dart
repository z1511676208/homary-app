import 'package:homary/common/utils/main.dart';

class GobackIconBtn extends StatelessWidget {
  final Color color;
  final double size;
  const GobackIconBtn(
      {Key key, this.color = AppColor.primaryText, this.size = 30.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Routes.pop(),
        icon: Icon(Icons.chevron_left, color: this.color, size: this.size.sp));
  }
}
