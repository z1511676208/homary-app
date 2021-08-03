/*
 * @Author       : JHao
 * @Date         : 2021-07-29 14:35:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 10:52:04
 */

import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var urlMapList = Localstorage().getJSON(REQUEST_URL);

class CategoryApi {
  static Future<DioResult> getTopChannelCategory({dynamic params}) async {
    DioResult res = await Request().get(
        urlMapList['topChannelCategory'] ??
            baseRequestUrl['topChannelCategory'],
        params: params);
    return res;
  }

  static Future<DioResult> getCategoryList({dynamic params}) async {
    DioResult res = await Request().get(
        urlMapList['channelCategory'] ?? baseRequestUrl['channelCategory'],
        params: params);
    return res;
  }
}
