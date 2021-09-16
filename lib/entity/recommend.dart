/*
 * @Author       : JHao
 * @Date         : 2021-07-23 15:25:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-15 10:07:42
 */
// To parse this JSON data, do
//
//     final recommendListRes = recommendListResFromJson(jsonString);

import 'dart:convert';

import 'package:homary/entity/home.dart';

class RecommendListRes {
  RecommendListRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory RecommendListRes.fromRawJson(String str) =>
      RecommendListRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecommendListRes.fromJson(Map<String, dynamic> json) =>
      RecommendListRes(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.list,
    this.total,
    this.hasMorePage,
    this.totalPage,
  });

  List<ModuleDataProductList> list;
  dynamic total;
  int hasMorePage;
  int totalPage;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ModuleDataProductList>.from(
            json["list"].map((x) => ModuleDataProductList.fromJson(x))),
        total: json["total"],
        hasMorePage: json["has_more_page"],
        totalPage: json["total_page"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "total": total,
        "has_more_page": hasMorePage,
        "total_page": totalPage,
      };
}
