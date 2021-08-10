/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:31:45
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-09 17:00:32
 */
class BusProvider {
  static BusProvider _instance = BusProvider._internal();
  factory BusProvider() => _instance;
  Map<String, List<Function>> events = {};
  Map<String, Map<String, Function>> webViewEvent = {};

  BusProvider._internal();

  checkControllers() {
    // print('controllerList ---- $events');
  }

  removeControllers(String name, String ctrlName) {
    if (webViewEvent[name] != null) {
      webViewEvent[name].removeWhere((key, value) {
        return key == ctrlName;
      });
      // print('webViewEvent ---- $webViewEvent');
    }
  }

  subWebViewCtrl(String name, String ctrlName, Function callBack) {
    if (webViewEvent[name] != null) {
      webViewEvent[name].addAll({ctrlName: callBack});
    } else {
      webViewEvent[name] = {ctrlName: callBack};
    }
  }

  pubWebViewCtrl(String name, {bool isLastCtrl = false}) {
    if (webViewEvent[name] != null) {
      if (isLastCtrl) {
        var v = webViewEvent[name].values.toList().last;
        v();
        return;
      }
      webViewEvent[name].forEach((key, value) {
        print('key====>$key');
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
