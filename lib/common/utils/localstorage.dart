/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:31:45
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 17:12:23
 */
import 'dart:convert';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/storage/cookie-manager.dart';
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
    return val == null ? '' : val;
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
    return val == null ? 0 : val;
  }

  /// 设置 json 对象
  Future<bool> setJSON(String key, dynamic jsonVal) async {
    String jsonString = jsonEncode(jsonVal);
    return await _prefs.setString(key, jsonString);
  }

  /// 获取 json 对象
  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  setGaTicketList(String eventName) {
    if (eventName != null && eventName != "") {
      List gaTicketList = getJSON(StorageKey.GA_TICKET_LIST) ?? [];
      gaTicketList.add(eventName);
      gaTicketList = gaTicketList.toSet().toList();
      setCookie(
          StorageKey.GA_TICKET_LIST, jsonEncode(gaTicketList)); // 同步到 webview
      setJSON(StorageKey.GA_TICKET_LIST, gaTicketList);
    }
  }

  removeGaTicketList(String eventName) async {
    if (eventName != null && eventName != "") {
      List gaTicketList = getJSON(StorageKey.GA_TICKET_LIST) ?? [];
      gaTicketList = gaTicketList.toSet().toList();
      gaTicketList.length > 0 && gaTicketList.remove(eventName);
      setCookie(
          StorageKey.GA_TICKET_LIST, jsonEncode(gaTicketList)); // 同步到 webview
      setJSON(StorageKey.GA_TICKET_LIST, gaTicketList);
    }
  }
}
