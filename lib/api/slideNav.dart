/*
 * @Author       : zhhjie
 * @Date         : 2021-07-08 16:11:59
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-16 18:25:53
 */
import 'package:homary/common/request/request.dart';

class SlideNavApi {
  static Future<DioResult> getSlideNavData() async {
    DioResult res =
        await Request().get('/home/channel/get-home-channel', diskCache: true);
    return res;
  }
}
