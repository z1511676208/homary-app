import 'dart:io';

import 'package:homary/common/utils/main.dart';
import 'package:homary/components/pullToRefresh/app_classic_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefresh extends StatelessWidget {
  const PullToRefresh({
    Key key,
    this.controller,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown: true,
    this.enablePullUp: true,
    this.child,
  }) : super(key: key);
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final Widget child;
  final bool enablePullDown;
  final bool enablePullUp;

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerTriggerDistance: 55,
      child: SmartRefresher(
        controller: controller,
        child: child,
        header: AppClassicHeader(),
        footer: ClassicFooter(
          loadingText: '',
          idleText: '',
          canLoadingText: '',
          canLoadingIcon: loadingIcon(),
          idleIcon: loadingIcon(),
          loadingIcon: loadingIcon(),
        ),
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        onRefresh: onRefresh,
        onLoading: onLoading,
      ),
    );
  }

  Widget loadingIcon() {
    return Platform.isAndroid
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : CupertinoActivityIndicator();
  }
}
