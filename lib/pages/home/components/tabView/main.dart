/*
 * @Author       : JHao
 * @Date         : 2021-07-09 19:31:26
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-16 19:06:07
 */
import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homary/common/utils/device.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';

class TabViewBox extends StatelessWidget {
  final TabController _tabController;
  final List<String> _tabValues;

  const TabViewBox(this._tabController, this._tabValues, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer _timer;
    double _progress;
    return Container(
      child: TabBarView(
        controller: _tabController,
        children: _tabValues
            .map((e) => Center(
                  child: TextButton(
                    child: Text(e),
                    onPressed: () async {
                      Toast.success();
                      // EasyLoading.show(status: 'loading...');
                      // Routes.push(context, '/signIn',
                      //     params: {'redirectUrl': '/home?v=1.0.0'});
                      // _progress = 0;
                      // _timer?.cancel();
                      // _timer = Timer.periodic(const Duration(milliseconds: 100),
                      //     (Timer timer) {
                      //   EasyLoading.showProgress(_progress,
                      //       status: '${(_progress * 100).toStringAsFixed(0)}%');
                      //   _progress += 0.03;

                      //   if (_progress >= 1) {
                      //     _timer?.cancel();
                      //     EasyLoading.dismiss();
                      //   }
                      // });
                      // EasyLoading.show(status: "Loading....");
                      // Future.delayed(Duration(seconds: 3))
                      //     .then((value) => EasyLoading.dismiss());
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
