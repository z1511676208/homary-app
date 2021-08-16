/*
 * @Author       : zhhjie
 * @Date         : 2021-08-13 11:06:21
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-13 11:06:21
 */
// To parse this JSON data, do
//
//     final cartNumberRes = cartNumberResFromJson(jsonString);

import 'dart:convert';

class CartNumberRes {
  CartNumberRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory CartNumberRes.fromRawJson(String str) =>
      CartNumberRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartNumberRes.fromJson(Map<String, dynamic> json) => CartNumberRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
    this.num,
  });

  int num;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        num: json["num"] == null ? null : json["num"],
      );

  Map<String, dynamic> toJson() => {
        "num": num == null ? null : num,
      };
}
