import 'package:homary/common/utils/main.dart';

class BubbleShape extends CustomPainter {
  final Color strokeColor;

  BubbleShape(this.strokeColor);

  @override
  void paint(Canvas canvas, Size size) {
    // 填充
    var paint = Paint()
      ..color = Color(0xFFF9F9F9);

    // 描边
    var strokePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = 1.w
      ..style = PaintingStyle.stroke;

    double x = 30.w;
    Path path = Path() // 绘制三角形
      ..moveTo(x, 0)
      ..lineTo(x + 20, 0)
      ..lineTo(x + 10, -10)
      ..lineTo(x, 2) // 绘制圆角矩形
      ..addRRect(RRect.fromLTRBR(
          0, 0, size.width, size.height + 10, Radius.circular(5.w)));


    // Tips: 这两个的绘制顺序很关键，必须先边框，不然会看到多出的线条
    // 绘制边框
    canvas.drawPath(path, strokePaint);

    // 绘制路径
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BubbleShape oldDelegate) {
    return false;
  }
}
