import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppClassicHeader extends RefreshIndicator {
  AppClassicHeader()
      : super(
          refreshStyle:RefreshStyle.UnFollow,
          completeDuration: Duration(milliseconds: 600),
          height: 60,
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
      child: CupertinoActivityIndicator(radius: 16,),
    );
  }
}
