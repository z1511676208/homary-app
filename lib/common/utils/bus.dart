class BusProvider {
  static BusProvider _instance = BusProvider._internal();
  factory BusProvider() => _instance;
  Map<String, List<Function>> events = {};
  Map<String, Map<String, Function>> webViewEvent = {};

  BusProvider._internal();

  checkControllers() {
    print('controllerList ---- $events');
  }

  removeControllers(String name, String ctrlName) {
    if (webViewEvent[name] != null) {
      webViewEvent[name].removeWhere((key, value) {
        return key == ctrlName;
      });
      print('webViewEvent ---- $webViewEvent');
    }
  }

  subWebViewCtrl(String name, String ctrlName, Function callBack) {
    if (webViewEvent[name] != null) {
      webViewEvent[name].addAll({ctrlName: callBack});
    } else {
      webViewEvent[name] = {ctrlName: callBack};
    }
  }

  pubWebViewCtrl(String name) {
    print('run hererrer ---- $webViewEvent');
    if (webViewEvent[name] != null) {
      webViewEvent[name].forEach((key, value) {
        value();
      });
    }
  }

  subEvent(String name, Function callBack) {
    if (events[name] != null) {
      events[name].add(callBack);
    } else {
      events[name] = [callBack];
    }
  }

  pubEvent(String name) {
    if (events[name] != null) {
      events[name].forEach((element) {
        element();
      });
    }
  }
}
