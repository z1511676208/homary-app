import 'package:homary/common/utils/main.dart';

class BubbleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..blendMode = BlendMode.src;

    double x = size.width - 30;
    Path path = Path() // 绘制三角形
      ..moveTo(x, 12)
      ..lineTo(x + 20, 12)
      ..lineTo(x + 10, 0)
      ..lineTo(x, 12) // 绘制圆角矩形
      ..addRRect(RRect.fromLTRBR(
          0, 12, size.width, size.height + 12, Radius.circular(5.w)));

    // 绘制阴影
    canvas.drawShadow(path, Color(0xBF000000), 4.w, true);

    // 绘制路径
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
