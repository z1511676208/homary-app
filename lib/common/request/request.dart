import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:homary/common/request/handler.dart';
// import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:homary/common/request/cache.dart';
import 'package:homary/common/config/proxyConfig.dart';

class Request {
  static Request _instance = Request._internal();
  factory Request() => _instance;

  Dio dio;
  Request._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://frontapi.homary.com',
        // 连接服务器超时时间
        connectTimeout: 30000,
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
    dio.interceptors.add(CacheGet());
    dio.interceptors.add(RrequsetHandler());
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // do something before request is sent
      return handler.next(options);
    }, onResponse: (Response res, ResponseInterceptorHandler handler) {
      // do someting before response
      return handler.next(res);
    }, onError: (DioError err, ErrorInterceptorHandler handler) {
      return handler.next(err);
    }));

    /// 开启抓包 proxy 代理，禁用 https 证书
    if (OPEN_PROXY) {
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
  Future get(
    String path, {
    dynamic params,
    Options options,
    CancelToken cancelToken,
    bool refresh = false,
    bool cache = false,
    bool list = false,
    String cacheKey,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      Map<String, dynamic> cacheOption = {
        "refresh": refresh,
        "cache": cache,
        "list": list,
        "cacheKey": cacheKey
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
