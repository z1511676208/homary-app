/*
 * @Author       : JHao
 * @Date         : 2021-09-09 15:49:51
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-09 15:58:23
 */
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
      headerTriggerDistance: 60.w,
      child: SmartRefresher(
        controller: controller,
        child: child,
        header: AppClassicHeader(),
        footer: AppClassicFooter(),
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        onRefresh: onRefresh,
        onLoading: onLoading,
      ),
    );
  }
}
