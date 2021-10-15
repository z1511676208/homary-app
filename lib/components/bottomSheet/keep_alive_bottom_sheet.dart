import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:homary/common/utils/main.dart';

/// 底部弹窗框控制器，用于显示或取消底部弹窗
class KeepAliveBottomSheetManager extends InheritedWidget {
  KeepAliveBottomSheetManager({
    Key key,
    @required Widget child,
    @required _KeepAliveBottomSheetState state,
  })  : _state = state,
        super(key: key, child: child);

  final _KeepAliveBottomSheetState _state;

  Future<T> show<T extends Object>({int index = 0}) {
    return _state.show(index: index);
  }

  void hide<T extends Object>([T result]) {
    _state.hide(result);
  }

  @override
  bool updateShouldNotify(covariant KeepAliveBottomSheetManager oldWidget) {
    return _state != oldWidget._state;
  }

  static KeepAliveBottomSheetManager of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<KeepAliveBottomSheetManager>();
  }
}

/// 底部弹窗框，可保存 Widget 状态
/// 用于在底部弹窗中使用 Webview
class KeepAliveBottomSheet extends StatefulWidget {
  const KeepAliveBottomSheet({
    Key key,
    @required this.child,
    @required this.bottomSheet,
    this.borderRadius,
  }) : super(key: key);
  final Widget child;
  final List<Widget> bottomSheet;
  final BorderRadiusGeometry borderRadius;

  @override
  _KeepAliveBottomSheetState createState() => _KeepAliveBottomSheetState();
}

class _KeepAliveBottomSheetState extends State<KeepAliveBottomSheet>
    with TickerProviderStateMixin {
  /// 当前显示弹窗下标
  int index;

  /// 弹窗是否已初始化过
  Set<int> initSet = Set();

  /// 当前是否显示弹窗
  bool isShowBottomSheet = false;

  AnimationController _controller;

  ParametricCurve<double> animationCurve = decelerateEasing;

  Completer _completer;

  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isShowBottomSheet = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<T> show<T extends Object>({int index = 0}) {
    setState(() {
      this.index = index;
      initSet.add(widget.bottomSheet[index].hashCode);
      isShowBottomSheet = true;
      _controller.forward();
    });

    _completer = Completer();
    return _completer.future;
  }

  void hide<T extends Object>([T result]) {
    _controller.reverse();
    _completer?.complete(result);
  }

  void _handleDragStart(DragStartDetails details) {
    // Allow the bottom sheet to track the user's finger accurately.
    animationCurve = Curves.linear;
  }

  void _handleDragEnd(DragEndDetails details, {bool isClosing}) {
    // Allow the bottom sheet to animate smoothly from its current position.
    animationCurve = _BottomSheetSuspendedCurve(
      _controller.value,
      curve: decelerateEasing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: isShowBottomSheet
          ? () {
              hide();
              return Future.value(false);
            }
          : null,
      child: KeepAliveBottomSheetManager(
        state: this,
        child: Stack(
          children: [
            widget.child,
            if (isShowBottomSheet)
              GestureDetector(
                onTap: hide,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black54,
                ),
              ),
            ...buildBottomSheets(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildBottomSheets() {
    List<Widget> list = [];
    for (int i = 0; i < widget.bottomSheet.length; i++) {
      if (initSet.contains(widget.bottomSheet[i].hashCode)) {
        list.add(buildBottomSheet(widget.bottomSheet[i], i));
      }
    }
    return list;
  }

  Widget buildBottomSheet(Widget child, int index) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Offstage(
        offstage: !isShowBottomSheet || this.index != index,
        child: AnimatedBuilder(
          animation: _controller,
          child: BottomSheet(
            key: ValueKey(index),
            animationController: _controller,
            onDragStart: _handleDragStart,
            onDragEnd: _handleDragEnd,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ??
                  BorderRadius.vertical(
                    top: Radius.circular(8.w),
                  ),
            ),
            builder: (_) {
              return child;
            },
            onClosing: hide,
          ),
          builder: (BuildContext context, Widget child) {
            return Align(
              alignment: AlignmentDirectional.topStart,
              heightFactor: animationCurve.transform(_controller.value),
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class _BottomSheetSuspendedCurve extends ParametricCurve<double> {
  /// Creates a suspended curve.
  const _BottomSheetSuspendedCurve(
    this.startingPoint, {
    this.curve = Curves.easeOutCubic,
  })  : assert(startingPoint != null),
        assert(curve != null);

  /// The progress value at which [curve] should begin.
  ///
  /// This defaults to [Curves.easeOutCubic].
  final double startingPoint;

  /// The curve to use when [startingPoint] is reached.
  final Curve curve;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    assert(startingPoint >= 0.0 && startingPoint <= 1.0);

    if (t < startingPoint) {
      return t;
    }

    if (t == 1.0) {
      return t;
    }

    final double curveProgress = (t - startingPoint) / (1 - startingPoint);
    final double transformed = curve.transform(curveProgress);
    return lerpDouble(startingPoint, 1, transformed);
  }

  @override
  String toString() {
    return '${describeIdentity(this)}($startingPoint, $curve)';
  }
}
