import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:homary/common/style/color.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppClassicHeader extends RefreshIndicator {
  AppClassicHeader()
      : super(
          refreshStyle: RefreshStyle.UnFollow,
          completeDuration: Duration(milliseconds: 600),
          height: 60.w,
        );

  @override
  State createState() {
    return _AppClassicHeaderState();
  }
}

class _AppClassicHeaderState extends RefreshIndicatorState<AppClassicHeader>
    with TickerProviderStateMixin {
  double offset = 1;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    // 下拉刷新
    // 松开刷新
    RefreshString strings =
        RefreshLocalizations.of(context)?.currentLocalization ??
            EnRefreshString();
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/data.json',
            height: 16.w * (1 + offset),
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
            },
          ),
          Text(
            mode == RefreshStatus.canRefresh
                ? strings.canRefreshText
                : mode == RefreshStatus.completed
                ?strings.refreshCompleteText
                : mode == RefreshStatus.refreshing
                ?  strings.refreshingText
                : mode == RefreshStatus.idle
                ? strings.idleRefreshText
                : "",
            style: TextStyle(
              fontSize: 5.sp * (1 + offset),
              color: Color(0xFF777777),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.idle) {
      // 收回
      _controller.value = 0;
      _controller.stop();
    } else if (mode == RefreshStatus.refreshing) {
      // 正在刷新
      _controller.repeat();
    }
  }

  @override
  void onOffsetChange(double offset) {
    if (offset < 0) {
      return;
    }
    if (offset > 60.w) {
      return;
    }
    setState(() {
      this.offset = offset / 60.w;
    });
  }
}

class AppClassicFooter extends LoadIndicator {
  AppClassicFooter()
      : super(
          loadStyle: LoadStyle.ShowAlways,
          height: 60.w,
        );

  @override
  State<StatefulWidget> createState() {
    return _AppClassicFooterState();
  }
}

class _AppClassicFooterState extends LoadIndicatorState<AppClassicFooter> {
  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    return Container(
        height: widget.height,
        alignment: Alignment.center,
        child: Lottie.asset('assets/data.json', height: 35.w));
  }

  @override
  Future endLoading() {
    return Future.delayed(Duration(milliseconds: 300));
  }
}

const double _kTwoPI = math.pi * 2.0;

/// Alpha values extracted from the native component (for both dark and light mode) to
/// draw the spinning ticks.
const List<int> _kAlphaValues = <int>[
  47,
  47,
  47,
  47,
  72,
  97,
  122,
  147,
];

/// The alpha value that is used to draw the partially revealed ticks.
const int _partiallyRevealedAlpha = 147;
/// An iOS-style activity indicator that spins clockwise.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=AENVH-ZqKDQ}
///
/// See also:
///
///  * <https://developer.apple.com/ios/human-interface-guidelines/controls/progress-indicators/#activity-indicators>
class CupertinoActivityIndicator extends StatefulWidget {
  /// Creates an iOS-style activity indicator that spins clockwise.
  const CupertinoActivityIndicator({
    Key key,
    this.animating = true,
    this.radius = 10,
  })  : assert(animating != null),
        assert(radius != null),
        assert(radius > 0.0),
        progress = 1.0,
        super(key: key);

  /// Creates a non-animated iOS-style activity indicator that displays
  /// a partial count of ticks based on the value of [progress].
  ///
  /// When provided, the value of [progress] must be between 0.0 (zero ticks
  /// will be shown) and 1.0 (all ticks will be shown) inclusive. Defaults
  /// to 1.0.
  const CupertinoActivityIndicator.partiallyRevealed({
    Key key,
    this.radius = 10,
    this.progress = 1.0,
  })  : assert(radius != null),
        assert(radius > 0.0),
        assert(progress != null),
        assert(progress >= 0.0),
        assert(progress <= 1.0),
        animating = false,
        super(key: key);

  /// Whether the activity indicator is running its animation.
  ///
  /// Defaults to true.
  final bool animating;

  /// Radius of the spinner widget.
  ///
  /// Defaults to 10px. Must be positive and cannot be null.
  final double radius;

  /// Determines the percentage of spinner ticks that will be shown. Typical usage would
  /// display all ticks, however, this allows for more fine-grained control such as
  /// during pull-to-refresh when the drag-down action shows one tick at a time as
  /// the user continues to drag down.
  ///
  /// Defaults to 1.0. Must be between 0.0 and 1.0 inclusive, and cannot be null.
  final double progress;

  @override
  _CupertinoActivityIndicatorState createState() =>
      _CupertinoActivityIndicatorState();
}

class _CupertinoActivityIndicatorState extends State<CupertinoActivityIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.animating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(CupertinoActivityIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating)
        _controller.repeat();
      else
        _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: CustomPaint(
        painter: _CupertinoActivityIndicatorPainter(
          position: _controller,
          activeColor:
          CupertinoDynamicColor.resolve(CupertinoDynamicColor.withBrightness(
            color: AppColor.primaryColor,
            darkColor: AppColor.primaryColor,
          ), context),
          radius: widget.radius,
          progress: widget.progress,
        ),
      ),
    );
  }
}
class _CupertinoActivityIndicatorPainter extends CustomPainter {
  _CupertinoActivityIndicatorPainter({
    @required this.position,
    @required this.activeColor,
    @required this.radius,
    @required this.progress,
  })  : tickFundamentalRRect = RRect.fromLTRBXY(
    -radius / 10,
    -radius / 3.0,
    radius / 10,
    -radius,
    radius / 10,
    radius / 10,
  ),
        super(repaint: position);

  final Animation<double> position;
  final Color activeColor;
  final double radius;
  final double progress;

  final RRect tickFundamentalRRect;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final int tickCount = _kAlphaValues.length;

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (tickCount * position.value).floor();

    for (int i = 0; i < tickCount * progress; ++i) {
      final int t = (i - activeTick) % tickCount;
      paint.color = activeColor
          .withAlpha(progress < 1 ? _partiallyRevealedAlpha : _kAlphaValues[t]);
      canvas.drawRRect(tickFundamentalRRect, paint);
      canvas.rotate(_kTwoPI / tickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CupertinoActivityIndicatorPainter oldPainter) {
    return oldPainter.position != position ||
        oldPainter.activeColor != activeColor ||
        oldPainter.progress != progress;
  }
}
