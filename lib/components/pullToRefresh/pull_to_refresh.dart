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
    this.child,
  }) : super(key: key);
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      child: child,
      header: Platform.isAndroid ? MaterialClassicHeader() : AppClassicHeader(),
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
    );
  }
}
