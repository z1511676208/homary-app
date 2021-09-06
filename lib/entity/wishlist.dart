/*
 * @Author       : zhhjie
 * @Date         : 2021-09-06 14:56:23
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-06 17:33:26
 */
// To parse this JSON data, do
//
//     final wishlistRes = wishlistResFromJson(jsonString);

import 'dart:convert';

import 'home.dart';

class WishlistRes {
  WishlistRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory WishlistRes.fromRawJson(String str) =>
      WishlistRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WishlistRes.fromJson(Map<String, dynamic> json) => WishlistRes(
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
    this.total,
    this.skuList,
    this.hasMorePage,
  });

  String total;
  List<ModuleDataProductList> skuList;
  int hasMorePage;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"] == null ? null : json["total"],
        skuList: json["sku_list"] == null
            ? null
            : List<ModuleDataProductList>.from(
                json["sku_list"].map((x) => ModuleDataProductList.fromJson(x))),
        hasMorePage:
            json["has_more_page"] == null ? null : json["has_more_page"],
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "sku_list": skuList == null
            ? null
            : List<dynamic>.from(skuList.map((x) => x.toJson())),
        "has_more_page": hasMorePage == null ? null : hasMorePage,
      };
}

class WishlistOrderBy {
  WishlistOrderBy({
    this.name,
    this.key,
    this.orderBy = '',
    this.isSelect = false,
  });

  String name;
  String key;
  String orderBy;
  bool isSelect;

  factory WishlistOrderBy.fromRawJson(String str) =>
      WishlistOrderBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WishlistOrderBy.fromJson(Map<String, dynamic> json) =>
      WishlistOrderBy(
        name: json["name"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
      };
}
