/*
 * @Author       : zhhjie
 * @Date         : 2021-07-08 16:11:59
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 19:30:19
 */
import 'package:homary/common/request/request.dart';
import 'package:homary/entity/commonConfig.dart';

class SlideNavApi {
  static Future<DioResult> getSlideNavData() async {
    DioResult res =
        await Request().get('/home/channel/get-home-channel', diskCache: true);
    return res;
  }

  static Future<DioResult> getCommonConfig() async {
    var res = await Request().get('/common/site/getinitconfig');
    return res;
  }
}
