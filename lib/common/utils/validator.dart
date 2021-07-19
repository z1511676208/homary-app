/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 09:38:56
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 11:17:40
 */
String checkEmail(String val, String errorText) {
  if (val == null || val.isEmpty) return errorText;
  String reg =
      "^[A-Za-z0-9_\-`.\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+\$";
  if (!RegExp(reg).hasMatch(val))
    return errorText;
  else
    return null;
}

String checkPassWord(String val, String errorText) {
  if (val == null || val.isEmpty) return errorText;
  RegExp reg = new RegExp(
      r'^(?![0-9]+$)(?![a-zA-Z]+$)[(?=(?:.?[`·~!@#$%^&()_+}{:;’",<.>/?=\-\]))*0-9A-Za-z]{8,}$');

  if (!reg.hasMatch(val))
    return errorText;
  else
    return null;
}
