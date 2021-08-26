/*
 * @Author       : JHao
 * @Date         : 2021-07-19 11:35:37
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-26 18:33:01
 */
import 'dart:async';

import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:uuid/uuid.dart';

String getUuid() {
  var uuid = Uuid();
  return uuid.v1();
}

// 生成唯一id
String getEquipmentIdentification() {
  String eid = Localstorage().getString('EID');
  if (eid != '') {
    return eid;
  } else {
    String newEid = getUuid();
    Localstorage().setString('EID', newEid);
    setEidCookie(); // 同步APP EID 到 webview里
    return newEid;
  }
}

//防抖
Function debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 2000),
]) {
  Timer timer;
  Function target = () {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func?.call();
    });
  };
  return target;
}

/// 从url中获取id
String getIdFromUrl(String url) {
  final reg = RegExp(r'-(\d+)\.html$');
  String id =
      reg.stringMatch(url)?.replaceAll('-', '')?.replaceAll('.html', '');
  return id;
}

// 判断是否显示ETA信息 (美国/英国站才显示)
bool isShowEtaInfo() {
  List<String> siteList = ["us", 'uk'];
  var currentConfig = getCurrentConfig();
  return siteList.contains(currentConfig['site'] ?? '');
}
