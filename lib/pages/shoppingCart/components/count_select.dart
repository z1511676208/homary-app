import 'dart:math';
import 'dart:ui';

import 'package:homary/common/utils/main.dart';

class CountSelect extends StatefulWidget {
  const CountSelect({Key key, this.value = 1}) : super(key: key);

  final int value;

  @override
  _CountSelectState createState() => _CountSelectState();
}

class _CountSelectState extends State<CountSelect> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.2,initialPage: widget.value-1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 300.w,
        child: Column(
          children: [
            Container(
              height: 50.w,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      S.of(context).shopping_cancel,
                      style: TextStyle(
                        color: AppColor.primaryLightSubTitle,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Text(
                    S.of(context).shopping_cart_qty,
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, _controller.page.toInt() + 1),
                    child: Text(
                      S.of(context).confirm,
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 44.w,
                      color: Color(0xFFF8F8F8),
                    ),
                  ),
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _controller,
                    itemCount: 99,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50.w,
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      );
                    },
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x00FFFFFF), Color(0xFFFFFFFF)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(height: 50.w),
                      Expanded(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x00FFFFFF), Color(0xFFFFFFFF)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SnappingListScrollPhysics extends ScrollPhysics {
  final double itemWidth;

  const SnappingListScrollPhysics({
    @required this.itemWidth,
    ScrollPhysics parent,
  }) : super(parent: parent);

  @override
  SnappingListScrollPhysics applyTo(ScrollPhysics ancestor) =>
      SnappingListScrollPhysics(
        parent: buildParent(ancestor),
        itemWidth: itemWidth,
      );

  double _getItem(ScrollPosition position) => (position.pixels) / itemWidth;

  double _getPixels(ScrollPosition position, double item) =>
      min(item * itemWidth, position.maxScrollExtent);

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity) {
      item -= 0.5;
    } else if (velocity > tolerance.velocity) {
      item += 0.5;
    }
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
