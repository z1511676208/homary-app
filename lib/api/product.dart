import 'package:homary/api/category.dart';
import 'package:homary/common/config/baseRequestUrl.dart';
import 'package:homary/common/request/request.dart';

class ProductApi{
  static Future<DioResult> getProductAttrList({dynamic params}) async {
    DioResult res = await Request().get(
        urlMapList['productAttrList'] ??
            baseRequestUrl['productAttrList'],
        params: params);
    return res;
  }

  static Future<DioResult> getProductList({dynamic params}) async {
    DioResult res = await Request().get(
        urlMapList['productList'] ??
            baseRequestUrl['productList'],
        params: params);
    return res;
  }

  static Future<DioResult> getTopicFlow({dynamic params}) async {
    DioResult res = await Request().get(
        urlMapList['topicFlow'] ??
            baseRequestUrl['topicFlow'],
        params: params);
    return res;
  }
}