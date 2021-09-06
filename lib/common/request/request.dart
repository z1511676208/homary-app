import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio_log/dio_log.dart';
import 'package:homary/common/request/handler.dart';
// import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
// import 'package:homary/common/utils/main.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:homary/common/config/proxyConfig.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/main.dart';

class Request {
  static Request _instance = Request._internal();
  factory Request() => _instance;

  static const BASE_URL = 'https://frontapi.homary.com';

  DioCacheManager dioCacheManager =
      DioCacheManager(CacheConfig(baseUrl: BASE_URL));

  Dio dio;
  Request._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        // 连接服务器超时时间
        connectTimeout: 30 * 1000,
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
    dio.interceptors.add(dioCacheManager.interceptor);
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
              res.data['data']['__ga'] is Map &&
              res.data['data']['__ga']['is_auto_send'] == 1;
          if (isSendGTM) {
            Map<String, dynamic> gaData = res.data['data']['__ga'];
            // 判断是否有用户信息
            Map<String, dynamic> userInfo =
                Localstorage().getJSON(StorageKey.USER_INFO);
            if (userInfo != null) {
              gaData.addAll({'user_propertys': userInfo});
            }
            sendGTMData(gaData);
          }
          return handler.next(res);
        } else if (res.data['code'] == 70011) {
          //重置密码过期
          DioError errData =
              DioError(requestOptions: res.requestOptions, error: res.data);
          return handler.reject(errData);
        } else if (res.data['code'] == 10011) {
          Routes.goHome();
          // 请求的用户信息如果不属于当前单号的用户信息，则返回10011错误码指定前端跳转官网首页
          DioError errData =
              DioError(requestOptions: res.requestOptions, error: res.data);
          return handler.reject(errData);
        } else if (res.data['code'] == 401) {
          Localstorage().remove(StorageKey.TOKEN);
          DioError errData =
              DioError(requestOptions: res.requestOptions, error: res.data);

          if (res.requestOptions.path == '/user/user/info') {
            return handler.reject(errData);
          }
          Toast.error(res.data['message'] ?? '');
          String redirectUrl = Routes.getCurPath();
          BuildContext context = navigatorKey.currentState.overlay.context;
          Routes.replace(context, '/signIn',
              params: {'redirect_url': Uri.encodeComponent(redirectUrl)});
          return handler.reject(errData);
        } else {
          Toast.error(res.data['message'] ?? '');
          DioError errData =
              DioError(requestOptions: res.requestOptions, error: res.data);
          return handler.reject(errData);
        }
      }
    }, onError: (DioError err, ErrorInterceptorHandler handler) {
      Toast.clear();
      return handler.next(err);
    }));
    dio.interceptors.add(DioLogInterceptor());

    /// 开启抓包 proxy 代理，禁用 https 证书
    if(proxy != null){
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // the proxy value likes:  {port: 8899, host: 127.0.0.1}
        var systemProxyIp = proxy['host'];
        var systemProxyProxy = int.parse(proxy['port']);

        client.findProxy = (uri) {
          return "PROXY $systemProxyIp:$systemProxyProxy";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// refresh 是否强制刷新 默认 false
  /// cache 是否缓存 默认 false
  /// isRequire 是否需要登陆token
  Future get(
    String path, {
    dynamic params,
    Options options,
    CancelToken cancelToken,
    bool refresh = false,
    bool cache = false,
    bool isRequire = false,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      if (cache) {
        // 缓存策略:
        // 10分钟内 使用缓存数据
        // 10分钟后至7天之内 网络正常时发送请求，网络异常时使用缓存数据
        requestOptions = buildCacheOptions(
          Duration(minutes: 10),
          maxStale: Duration(days: 7),
          forceRefresh: refresh,
          options: options,
        );
      }
      Map<String, dynamic> cacheOption = {
        "isRequire": isRequire,
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
      return DioResult(null, res.data);
    } on DioError catch (err) {
      return DioResult(err.error, null);
    }
  }

  Future post(String path,
      {dynamic params,
      Options options,
      bool isRequire = false,
      CancelToken cancelToken}) async {
    try {
      Options requestOptions = options ?? Options();
      Map<String, dynamic> cacheOption = {
        "isRequire": isRequire,
      };
      if (requestOptions.extra == null) {
        requestOptions.extra = cacheOption;
      } else {
        requestOptions.extra.addEntries(cacheOption.entries);
      }
      var res = await dio.post(path,
          data: params, options: requestOptions, cancelToken: cancelToken);
      return DioResult(null, res.data);
    } on DioError catch (err) {
      return DioResult(err.error, null);
    }
  }

  Future upload(String path,
      {dynamic params,
      Options options,
      bool isRequire = false,
      CancelToken cancelToken}) async {
    try {
      Options requestOptions = options ?? Options();
      Map<String, dynamic> cacheOption = {
        "isRequire": isRequire,
      };
      if (requestOptions.extra == null) {
        requestOptions.extra = cacheOption;
        requestOptions.extra.addEntries(cacheOption.entries);
      }
      var res = await dio.post(path,
          data: FormData.fromMap(params),
          options: requestOptions,
          cancelToken: cancelToken);
      return DioResult(null, res.data);
    } on DioError catch (err) {
      return DioResult(err.error, null);
    }
  }
}

class DioResult {
  dynamic error;
  dynamic result;

  DioResult(error, result) {
    this.error = error;
    this.result = result;
  }
}
