import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppClassicHeader extends RefreshIndicator {
  AppClassicHeader()
      : super(
          refreshStyle:RefreshStyle.UnFollow,
          completeDuration: Duration(milliseconds: 600),
          height: 60.w,
        );

  @override
  State createState() {
    return _AppClassicHeaderState();
  }
}

class _AppClassicHeaderState extends RefreshIndicatorState<AppClassicHeader> {
  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      child: Lottie.asset('assets/data.json',height: 50.w)
    );
  }
}

class AppClassicFooter extends LoadIndicator{

  AppClassicFooter() : super(
    loadStyle:LoadStyle.ShowAlways,
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
        child: Lottie.asset('assets/data.json',height: 35.w)
    );
  }

  @override
  Future endLoading() {
    return Future.delayed(Duration(milliseconds: 300));
  }
}