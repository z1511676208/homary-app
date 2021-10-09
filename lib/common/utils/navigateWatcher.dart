import 'main.dart';

class NavigateWatcher extends NavigatorObserver {
  static NavigateWatcher _instance;

  static String currentPath;

  static NavigateWatcher getInstance() {
    if (_instance == null) {
      _instance = NavigateWatcher();
    }
    return _instance;
  }

  @override
  void didPush(Route route, Route previousRoute) {
    currentPath = route.settings.name;
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    currentPath = previousRoute.settings.name;
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    super.didRemove(route, previousRoute);
  }
}
