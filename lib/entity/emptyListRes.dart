/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 17:09:00
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-14 17:11:55
 */
// To parse this JSON data, do
//
//     final emptyListRes = emptyListResFromJson(jsonString);

import 'dart:convert';

class EmptyListRes {
  EmptyListRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  List<dynamic> data;
  String message;

  factory EmptyListRes.fromRawJson(String str) =>
      EmptyListRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmptyListRes.fromJson(Map<String, dynamic> json) => EmptyListRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
        "message": message == null ? null : message,
      };
}
