/*
 * @Author       : zhhjie
 * @Date         : 2021-07-19 16:47:26
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-02 17:01:14
 */
import 'package:homary/common/request/request.dart';

class SearchApi {
  static Future<DioResult> getSearchHotKeywords() async {
    DioResult res = await Request().get('/product/search/hot-keywords');
    return res;
  }

  //搜索预请求
  static Future<DioResult> getAnalyze(params) async {
    DioResult res =
        await Request().get('/product/search/analyze-data', params: params);
    return res;
  }
}
