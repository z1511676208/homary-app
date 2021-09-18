/*
 * @Author       : zhhjie
 * @Date         : 2021-07-19 16:47:26
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-03 11:20:49
 */
import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/localstorage.dart';

var requestUrl = Localstorage().getJSON(StorageKey.REQUEST_URL);

class SearchApi {
  static Future<DioResult> getSearchHotKeywords() async {
    DioResult res = await Request()
        .get(requestUrl['hotKeywords'] ?? baseRequestUrl['hotKeywords']);
    return res;
  }

  //搜索预请求
  static Future<DioResult> getAnalyze(params) async {
    DioResult res = await Request().get(
        requestUrl['analyzeData'] ?? baseRequestUrl['analyzeData'],
        params: params);
    return res;
  }

  //搜索联想接口
  static Future<DioResult> getAssociateWordList(params) async {
    DioResult res = await Request().get('/product/search/get-associate-word-list',
        params: params);
    return res;
  }
}
