/*
<<<<<<< HEAD
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
<<<<<<< HEAD
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 19:21:03
=======
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-16 15:46:11
=======
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-14 17:23:24
>>>>>>> 0660c16 (feat：注册登录接口调试，忘记密码页面)
>>>>>>> acd5203 (feat：注册登录接口调试，忘记密码页面)
 */
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
    "pf": 'm',
  };

  // 替换动态 url 目标参数
  Map<String, dynamic> formatParams(
      Map<String, dynamic> params, Map<String, dynamic> replaceParams) {
    Map<String, dynamic> finalParams = {};
    finalParams.addAll(replaceParams);
    var currentConfig = Localstorage().getJSON('currentConfig');
    _publicParams['token'] = Localstorage().getString('token') ?? '';
    _publicParams['site'] = currentConfig['site'] ?? 'us';
    _publicParams['language'] = currentConfig['language'] ?? 'en';
    _publicParams['currency'] = currentConfig['currency'] ?? 'usd';
    print(_publicParams);
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
      Map<String, dynamic> finalParams = formatParams(
          params, options.data != null ? options.data.toJson() : {});
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
