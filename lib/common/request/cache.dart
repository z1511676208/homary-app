import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:homary/common/config/cacheConfig.dart';
import 'package:homary/common/utils/localstorage.dart';
// import 'package:homary/common/utils/main.dart';

class CacheObject {
  // 返回值的时间戳
  int timeStamp;
  // cache 返回值
  Response response;

  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class CacheGet extends Interceptor {
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 缓存拦截 flag
    if (!CACHE_ENABLE) return handler.next(options);
    bool refresh = options.extra["refresh"] == true;
    // // 是否需要磁盘缓存
    // bool diskCache = options.extra["diskCache"];
    // 先判断是否refresh操作，如果是，就删除内存的数据，强行刷新缓存
    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        cache.remove(options.uri.toString());
      }
      return handler.next(options);
    }
    // 判断是否开启缓存
    if (options.extra["cache"] != false &&
        options.method.toLowerCase() == 'get') {
      // 使用当前 qpi 的 path 作为 hash 表的key
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var cacheData = cache[key];
      // 判断当前是否有缓存内容
      if (cacheData != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - cacheData.timeStamp) /
                1000 <
            CACHE_MAXAGE) {
          // 如果没有过期直接 resolve
          return handler.resolve(cache[key].response);
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      } else
        return handler.next(options);
    }
    // else if (options.extra["diskCache"] != false &&
    //     options.method.toLowerCase() == 'get') {
    //   如果有直接点用磁盘数据的情况，可以在这里补充
    // }
    else
      return handler.next(options);
  }

  // 保存回返结果
  _saveCache(Response resOption) {
    RequestOptions options = resOption.requestOptions;
    if (options.extra["cache"] == false ||
        options.method.toLowerCase() != "get" ||
        !CACHE_ENABLE)
      return;
    // 判断返回结果是没有问题的才存到内存
    else if (!_handleReslut(resOption.data))
      return;
    else {
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(resOption);
    }
  }

  // 保存返回结果到磁盘
  _saveDiskCache(Response resOption) async {
    RequestOptions options = resOption.requestOptions;
    if (options.extra["diskCache"] == false ||
        options.method.toLowerCase() != "get" ||
        !CACHE_ENABLE)
      return;
    // 判断返回结果是没有问题的才存到磁盘
    else if (!_handleReslut(resOption.data))
      return;
    else {
      String key = options.uri.toString();
      await Localstorage().setJSON(key, resOption.data);
    }
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // 如果启用缓存，将返回结果保存到缓存
    _saveCache(response);
    await _saveDiskCache(response);
    if (response.extra["diskCache"] == true && !_handleReslut(response.data)) {
      String key = response.requestOptions.uri.toString();
      var res = Response(
          requestOptions: response.requestOptions,
          data: Localstorage().getJSON(key));
      handler.resolve(res);
    }
    handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.extra["diskCache"] == true ||
        err.requestOptions.method.toLowerCase() == "get" ||
        CACHE_ENABLE) {
      String key = err.requestOptions.uri.toString();
      var data = Localstorage().getJSON(key);
      if (data != null) {
        var res = Response(requestOptions: err.requestOptions, data: data);
        handler.resolve(res);
      } else
        handler.next(err);
    }
  }

  /// 判断返回结果是否符合预期
  bool _handleReslut(data) {
    // ...
    return true;
  }
}
