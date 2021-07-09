import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class Localstorage {
  static Localstorage _instance = Localstorage._init();
  factory Localstorage() => _instance;
  static SharedPreferences _prefs;

  Localstorage._init();

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  /// 删除一项
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  /// 设置 String 值
  Future<bool> setString(String key, String val) {
    return _prefs.setString(key, val);
  }

  /// 获取 String 值
  String getString(String key) {
    String val = _prefs.getString(key);
    return val == null ? false : val;
  }

  /// 设置 boolean 值
  Future<bool> setBool(String key, bool val) {
    return _prefs.setBool(key, val);
  }

  /// 获取 boolean 值
  bool getBool(String key) {
    bool val = _prefs.getBool(key);
    return val == null ? false : val;
  }

  /// 设置 int 值
  Future<bool> setInt(String key, int val) {
    return _prefs.setInt(key, val);
  }

  /// 获取 int 值
  int getInt(String key) {
    int val = _prefs.getInt(key);
    return val == null ? false : val;
  }

  /// 设置 json 对象
  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }

  /// 获取 json 对象
  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }
}
