/*
 * @Author       : JHao
 * @Date         : 2021-07-16 19:35:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-19 11:10:01
 */
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/requsetUrl.dart';

class RrequsetHandler extends Interceptor {
  // 公参
  Map<String, dynamic> _publicParams = {
    "site": 'us',
    "language": 'en',
    "currency": 'usd',
    "token": '',
    "pf": Platform.isIOS ? 'ios' : 'android',
  };

  // 替换动态 url 目标参数
  Map<String, dynamic> formatParams(
      Map<String, dynamic> params, Map<String, dynamic> replaceParams) {
    Map<String, dynamic> finalParams = {};
    finalParams.addAll(replaceParams);
    var currentConfig = Localstorage().getJSON('currentConfig') ?? {};
    _publicParams['token'] = Localstorage().getString('token') ?? '';
    _publicParams['site'] = currentConfig['site'] ?? 'us';
    _publicParams['language'] = currentConfig['language'] ?? 'en';
    _publicParams['currency'] = currentConfig['currency'] ?? 'usd';
    finalParams.addAll(_publicParams);
    params.forEach((key, value) {
      finalParams.addAll({key: replaceParams[key] ?? _publicParams[key]});
    });
    // finalParams.addEntries(_publicParams.entries);
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
      Map<String, dynamic> finalParams = formatParams(
          params, options.data != null ? options.data.toJson() : {});
      if (options.extra['isRequire'] == false) {
        // 如果接口不需要登陆token  则从参数中移除
        finalParams.remove('token');
      }
      options.data = finalParams;
    }
    if (options.method.toLowerCase() == 'get') {
      Map<String, dynamic> finalParams =
          formatParams(params, options.queryParameters);
      if (options.extra['isRequire'] == false) {
        // 如果接口不需要登陆token  则从参数中移除
        finalParams.remove('token');
      }
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
