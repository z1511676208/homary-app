import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio_log/dio_log.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homary/common/request/handler.dart';
// import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
// import 'package:homary/common/utils/main.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:homary/common/request/cache.dart';
import 'package:homary/common/config/proxyConfig.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';

class Request {
  static Request _instance = Request._internal();
  factory Request() => _instance;

  Dio dio;
  Request._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://frontapi.homary.com',
        // 连接服务器超时时间
        connectTimeout: 30,
        // 响应流前后两次接收数据间隔
        receiveTimeout: 5000,
        // 请求头
        headers: {},
        contentType: "application/json; charset=UTF-8",
        // 这里是定义相应数据的格式，默认是json
        responseType: ResponseType.json);
    // 获取dio实力
    dio = Dio(options);

    // 设置cookie
    // CookieJar cookieJar = CookieJar();
    // 设置自定携带 cookies
    // dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(RrequsetHandler());
    dio.interceptors.add(CacheGet());
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // do something before request is sent
      return handler.next(options);
    }, onResponse: (Response res, ResponseInterceptorHandler handler) {
      if (res.statusCode == 200) {
        if (res.data['code'] == 200) {
          bool isSendGTM = res.data['data'] != null &&
              res.data['data'] is Map &&
              res.data['data']['__ga'] != null &&
              res.data['data']['__ga']['is_auto_send'] == 1;
          if (isSendGTM) {
            Map<String, dynamic> gaData = res.data['data']['__ga'];
            // if(){ 判断是否有用户信息
            // GA.addAll({'user_propertys': user_propertys});
            // }
            sendGTMData(gaData);
          }
          return handler.next(res);
        } else if (res.data['code'] == 70011) {
          //重置密码过期
          return handler.reject(res.data);
        } else if (res.data['code'] == 10011) {
          Routes.goHome();
          // 请求的用户信息如果不属于当前单号的用户信息，则返回10011错误码指定前端跳转官网首页
          return handler.reject(res.data);
        } else if (res.data['code'] == 401) {
          if (res.requestOptions.path == '/user/user/info') {
            return handler.reject(res.data);
          }
          String redirect_url = "";
          return handler.reject(res.data);
        }
      }
    }, onError: (DioError err, ErrorInterceptorHandler handler) {
      return handler.next(err);
    }));
    dio.interceptors.add(DioLogInterceptor());

    /// 开启抓包 proxy 代理，禁用 https 证书
    if (openProxy) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// refresh 是否刷新 默认 false
  /// cache 是否缓存 默认 false
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  /// diskCache 磁盘缓存
  /// cacheTime 缓存时间 (默认)
  Future get(
    String path, {
    dynamic params,
    Options options,
    CancelToken cancelToken,
    bool refresh = false,
    bool cache = false,
    bool diskCache = false,
    bool list = false,
    String cacheKey,
    int cacheTime = 600,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      Map<String, dynamic> cacheOption = {
        "refresh": refresh,
        "cache": cache,
        "diskCache": diskCache,
        "list": list,
        "cacheKey": cacheKey,
        "cacheTime": cacheTime,
      };
      if (requestOptions.extra == null) {
        requestOptions.extra = cacheOption;
      } else {
        requestOptions.extra.addEntries(cacheOption.entries);
      }
      var res = await dio.get(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return res.data;
    } on DioError catch (err) {
      throw err;
    }
  }

  Future post(String path,
      {dynamic params, Options options, CancelToken cancelToken}) async {
    try {
      var res = await dio.post(path,
          data: params, options: options, cancelToken: cancelToken);
      return res.data;
    } on DioError catch (err) {
      throw err;
    }
  }

  Future upload(String path,
      {dynamic params, Options options, CancelToken cancelToken}) {
    try {
      var res = dio.post(path,
          data: FormData.fromMap(params),
          options: options,
          cancelToken: cancelToken);
      return res;
    } on DioError catch (err) {
      throw err;
    }
  }
}
