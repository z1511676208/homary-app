/*
 * @Author       : zhhjie
 * @Date         : 2021-07-20 10:02:55
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-20 10:48:12
 */
// To parse this JSON data, do
//
//     final analyzeRes = analyzeResFromJson(jsonString);

import 'dart:convert';

class AnalyzeRes {
  AnalyzeRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory AnalyzeRes.fromRawJson(String str) =>
      AnalyzeRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnalyzeRes.fromJson(Map<String, dynamic> json) => AnalyzeRes(
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
    this.keyWord,
    this.jumpUrl,
  });

  String keyWord;
  String jumpUrl;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        keyWord: json["key_word"] == null ? null : json["key_word"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
      );

  Map<String, dynamic> toJson() => {
        "key_word": keyWord == null ? null : keyWord,
        "jump_url": jumpUrl == null ? null : jumpUrl,
      };
}
