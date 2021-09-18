import 'dart:async';

import 'package:homary/common/utils/analytics.dart' as Analytics;
import 'package:tuple/tuple.dart';

/// 埋点上报工具类
class AnalyticsUtil {
  static AnalyticsUtil instance = AnalyticsUtil._internal();

  factory AnalyticsUtil() => instance;

  AnalyticsUtil._internal();

  Map<String, Tuple2<List<Map>, Map>> _analyticsMap = {};

  Timer _timer;

  /// 上报商品卡片埋点数据
  void sendProductItemGTM({
    List<Map> pointList,
    String itemListName,
    String eventName,
    Map<String, dynamic> extraParams,
  }) {
    String mapKey = '$eventName,$itemListName';

    if (_analyticsMap.containsKey(mapKey)) {
      _analyticsMap[mapKey].item1.addAll(pointList);
    } else {
      _analyticsMap[mapKey] = Tuple2(pointList, extraParams);
    }

    if (_timer != null && _timer.isActive) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(seconds: 1), () {
      _analyticsMap.forEach((key, value) {
        List<String> keySplit = key.split(',');

        Analytics.sendProductItemGTM(
          data: _analyticsMap[key].item1,
          eventName: keySplit[0],
          itemListName: keySplit[1],
          extraParms: _analyticsMap[key].item2,
        );
      });

      _analyticsMap.clear();
      _timer = null;
    });
  }
}
