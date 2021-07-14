/*
 * @Author       : zhhjie
 * @Date         : 2021-07-08 16:11:59
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-08 17:38:07
 */
import 'package:homary/entity/main.dart';
import 'package:homary/common/request/request.dart';

class SlideNavApi {
  static Future<SlideNavRes> getSlideNavData() async {
    var res =
        await Request().get('/home/channel/get-home-channel', diskCache: true);
    return SlideNavRes.fromJson(res);
  }
}
