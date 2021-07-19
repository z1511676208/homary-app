/*
 * @Author       : zhhjie
 * @Date         : 2021-07-08 16:11:59
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 16:13:12
 */
import 'package:homary/common/request/request.dart';

class SlideNavApi {
  static Future<DioResult> getSlideNavData() async {
    DioResult res = await Request().get('/home/channel/get-home-channel');
    return res;
  }

  static Future<DioResult> getGlobalConfig() async {
    var res = await Request().get('/common/site/getinitconfig');
    return res;
  }
}
