/*
 * @Author       : zhhjie
 * @Date         : 2021-07-08 16:11:59
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-02 20:02:41
 */
import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var requestUrl = Localstorage().getJSON(REQUEST_URL);

class SlideNavApi {
  static Future<DioResult> getSlideNavData() async {
    DioResult res = await Request()
        .get(requestUrl['homeChannel'] ?? baseRequestUrl['homeChannel']);
    return res;
  }

  static Future<DioResult> getGlobalConfig() async {
    print(Localstorage().getJSON(REQUEST_URL));
    var res = await Request().get('/common/site/getinitconfig');
    return res;
  }
}
