/*
 * @Author       : zhhjie
 * @Date         : 2021-08-13 11:07:38
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-16 16:52:07
 */

import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var urlMapList = Localstorage().getJSON(StorageKey.REQUEST_URL);

class CartApi {
  static Future<DioResult> getShoppingCartNumber({dynamic params}) async {
    DioResult res = await Request().post(
        urlMapList['getCartNums'] ?? baseRequestUrl['getCartNums'],
        params: params,
        isRequire: true);
    return res;
  }
}
