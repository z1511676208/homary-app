/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-13 16:45:03
 */
import 'package:dio/dio.dart';
import 'package:homary/common/utils/requsetUrl.dart';

class RrequsetHandler extends Interceptor {
  // 公参
  Map<String, dynamic> _publicParams = {
    "site": 'us',
    "language": 'en',
    "currency": 'usd',
    "token": '',
    "pf": 'm',
    "pid": 'test43444',
    "sku": 'sdfeffffddd'
  };

  // 替换动态 url 目标参数
  Map<String, dynamic> formatParams(
      Map<String, dynamic> params, Map<String, dynamic> replaceParams) {
    Map<String, dynamic> finalParams = {};
    params.forEach((key, value) {
      finalParams.addAll({key: replaceParams[key] ?? _publicParams[key]});
    });
    finalParams.addEntries(_publicParams.entries);
    return finalParams;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, dynamic> urlNparams = getRealUrlNParams(options.path);
    String url = urlNparams['url'];
    Map<String, String> params = urlNparams['params'];
    options.path = url;
    if (options.method.toLowerCase() == 'post') {
      print("PPP => ${options.data}");
      Map<String, dynamic> finalParams =
          formatParams(params, options.data.toJson());
      options.data = finalParams;
    }
    if (options.method.toLowerCase() == 'get') {
      Map<String, dynamic> finalParams =
          formatParams(params, options.queryParameters);
      options.queryParameters = finalParams;
    }
    handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }
}
