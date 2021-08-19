/// 回到首页的事件
/// 用于在回到首页时，切换到指定的首页导航栏
class GoHomeEvent {
  /// 首页底部导航栏下标
  final int index;

  /// 首页 TabBar 栏下标
  final int homeTabIndex;

  GoHomeEvent({this.index = 0, this.homeTabIndex = 0});

  @override
  String toString() {
    return 'GoHomeEvent{index: $index, homeTabIndex: $homeTabIndex}';
  }
}
