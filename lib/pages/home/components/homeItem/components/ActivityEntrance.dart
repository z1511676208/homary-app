/*
 * @Author       : JHao
 * @Date         : 2021-12-16 10:37:29
 * @LastEditors  : JHao
 * @LastEditTime : 2021-12-16 11:34:55
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';

class ActivityEntrance extends StatefulWidget {
  ActivityEntrance({Key key}) : super(key: key);

  @override
  _ActivityEntranceState createState() => _ActivityEntranceState();
}

class _ActivityEntranceState extends State<ActivityEntrance> {
  /// 活动入口上次显示时间
  int _lastTime = 0;
  bool isShowActivityEntrance = true;

  @override
  void initState() {
    super.initState();
    String str =
        Localstorage().getString(StorageKey.ACTIVITY_ENTRANCE_SHOW_TIME);
    if (str == null || str.isEmpty) {
      _lastTime = 0;
    } else {
      _lastTime = int.parse(str);
    }
    print('_lastTime $_lastTime');
    // 是否超过一天
    bool isADay = (DateTime.now().millisecondsSinceEpoch - _lastTime) >
        1000 * 60 * 60 * 24;
    isShowActivityEntrance = isADay;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<HomeCtrl, AdvDatum>(
      builder: (BuildContext context, AdvDatum data, child) {
        return isShowActivityEntrance &&
                data != null &&
                data.moduleData != null &&
                data.moduleData.length > 0
            ? Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Localstorage().setString(
                            StorageKey.ACTIVITY_ENTRANCE_SHOW_TIME,
                            '${DateTime.now().millisecondsSinceEpoch}');
                        setState(() {
                          isShowActivityEntrance = false;
                        });
                      },
                      child: Container(
                        width: 68.w,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 6.w, bottom: 6.w),
                        child: Image.asset(
                          'assets/images/common/close.png',
                          width: 20.w,
                          height: 20.w,
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        handleSchema(context, data.moduleData[0].jumpUrl);
                      },
                      child: CustomNetworkImage(
                        data.moduleData[0].imgUrl,
                        width: 68.w,
                        height: 68.w,
                      ))
                ],
              )
            : Container();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return homeData.activityEntrance;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    );
  }
}
