
import 'package:homary/common/utils/main.dart';

class AppScrollBehavior extends ScrollBehavior{


  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          axisDirection: axisDirection,
          showLeading: false,
          showTrailing: false,
          color: Color(0xFFFFFFFF),
        );
    }
    return child;
  }
}