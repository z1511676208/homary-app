import 'main.dart';

class navigateWatcher extends NavigatorObserver {
  static navigateWatcher _instance;

  static String currentPath;

  static navigateWatcher getInstance() {
    if (_instance == null) {
      _instance = navigateWatcher();
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
    currentPath = route.settings.name;
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    super.didRemove(route, previousRoute);
  }
}
