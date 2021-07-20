/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:31:45
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 17:00:18
 */
import 'package:intl/intl.dart';

// 根据时间戳返回指定格式时间
getFormatData({int timeSamp, String format = 'yyyy-MM-dd HH:mm:ss'}) {
  var dataFormat = new DateFormat(format);
  var dateTime = new DateTime.fromMillisecondsSinceEpoch(timeSamp);
  String formatResult = dataFormat.format(dateTime);
  return formatResult;
}

/// 倒计时工具
class CountdownUtils {
  ///补零
  static String zeroFill(int i) {
    return i >= 10 ? "$i" : "0$i";
  }

  /// 秒转时分秒
  static String second2HMS(int sec) {
    String hms = "00:00:00";
    if (sec > 0) {
      int h = sec ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms = "${zeroFill(h)}:${zeroFill(m)}:${zeroFill(s)}";
    }
    return hms;
  }

  /// 秒转时分秒
  static Map<String, int> second2HMSList(int sec) {
    Map<String, int> hms = {'h': 0, "m": 0, "s": 0};
    if (sec > 0) {
      int h = sec ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms['h'] = h;
      hms['m'] = m;
      hms['s'] = s;
    }
    return hms;
  }
}
