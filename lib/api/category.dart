/*
 * @Author       : JHao
 * @Date         : 2021-07-29 14:35:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-30 10:47:42
 */
import 'package:homary/common/request/request.dart';

class CategoryApi {
  static Future<DioResult> getTopChannelCategory({dynamic params}) async {
    DioResult res = await Request()
        .get('/home/channel/app-top-channel-category', params: params);
    return res;
  }

  static Future<DioResult> getCategoryList({dynamic params}) async {
    DioResult res = await Request()
        .get('/home/channel/app-channel-category', params: params);
    return res;
  }
}
