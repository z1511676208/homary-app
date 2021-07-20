/*
 * @Author       : zhhjie
 * @Date         : 2021-07-08 16:11:59
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 20:12:41
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
