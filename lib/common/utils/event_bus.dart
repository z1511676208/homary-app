import 'dart:async';

/// 用于全局事件的监听和发送
///
/// 监听:
/// StreamSubscription _subscription = EventBus.instance.on<XXX>()
///   .listen((event) {});
///
/// 注意需要在页面 dispose 时主动调用 _subscription?.cancel();
///
/// 发送：
/// EventBus.instance.emit(XXX);
class EventBus {
  static final EventBus instance = EventBus._internal();

  factory EventBus() => instance;

  EventBus._internal() {
    _streamController = StreamController.broadcast(sync: false);
  }

  StreamController _streamController;

  StreamController get streamController => _streamController;

  /// 监听一个事件
  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// 发送一个事件
  void emit(event) {
    streamController.add(event);
  }

  /// 由于 EventBus 是单例的存在，因此 _streamController 在生命周期中不需要主动 close
  void destroy() {
    _streamController.close();
  }
}
