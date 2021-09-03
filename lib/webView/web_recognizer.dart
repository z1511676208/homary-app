import 'package:flutter/gestures.dart';

class WebViewVerticalGestureRecognizer
    extends VerticalDragGestureRecognizer {
  WebViewVerticalGestureRecognizer({PointerDeviceKind kind})
      : super(kind: kind);

  /// 是否在顶部
  bool isAtTop = true;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    if(!(event is PointerMoveEvent)){
      return;
    }

    if(isAtTop){
      // 假如已到达顶部，则识别是否为下滑手势
      // dy == 0 时不处理

      if(event.delta.dy < 0){
        // 下滑手势 不处理
        resolve(GestureDisposition.accepted);
        stopTrackingPointer(event.pointer);
      }
      if(event.delta.dy > 0) {
        // 拦截上滑手势
        resolve(GestureDisposition.rejected);
        stopTrackingPointer(event.pointer);
      }
    } else {
      // 没有在顶部，不处理
      resolve(GestureDisposition.accepted);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'webciew vertical drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}