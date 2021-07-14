import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:homary/common/config/cacheConfig.dart';

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
    } else
      return handler.next(options);
  }

  // 保存回返结果
  _saveCache(Response resOption) {
    RequestOptions options = resOption.requestOptions;
    if (options.extra["cache"] == false ||
        options.method.toLowerCase() != "get" ||
        !CACHE_ENABLE)
      return;
    else if (!_handleReslut())
      return;
    else {
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      print('keykeykey ===> $key');
      cache[key] = CacheObject(resOption);
    }
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // 如果启用缓存，将返回结果保存到缓存
    _saveCache(response);
    handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // 错误状态不缓存
  }

  /// 判断返回结果是否符合预期
  bool _handleReslut() {
    // ...
    return true;
  }
}
