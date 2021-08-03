/*
 * @Author       : JHao
 * @Date         : 2021-08-02 17:48:06
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-02 17:49:30
 */
// To parse this JSON data, do
//
//     final homeProductModuleRes = homeProductModuleResFromJson(jsonString);

import 'dart:convert';

import 'home.dart';

class HomeProductModuleRes {
  HomeProductModuleRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory HomeProductModuleRes.fromRawJson(String str) =>
      HomeProductModuleRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeProductModuleRes.fromJson(Map<String, dynamic> json) =>
      HomeProductModuleRes(
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
    this.saleFlow,
    this.hotSaleActivity,
  });

  HotSaleActivity saleFlow;
  HotSaleActivity hotSaleActivity;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        saleFlow: HotSaleActivity.fromJson(json["sale_flow"]),
        hotSaleActivity: HotSaleActivity.fromJson(json["hot_sale_activity"]),
      );

  Map<String, dynamic> toJson() => {
        "sale_flow": saleFlow.toJson(),
        "hot_sale_activity": hotSaleActivity.toJson(),
      };
}

class HotSaleActivity {
  HotSaleActivity({
    this.topicId,
    this.title,
    this.moreJumpUrl,
    this.productList,
  });

  String topicId;
  String title;
  String moreJumpUrl;
  List<ModuleDataProductList> productList;

  factory HotSaleActivity.fromRawJson(String str) =>
      HotSaleActivity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotSaleActivity.fromJson(Map<String, dynamic> json) =>
      HotSaleActivity(
        topicId: json["topic_id"],
        title: json["title"],
        moreJumpUrl: json["more_jump_url"],
        productList: List<ModuleDataProductList>.from(
            json["product_list"].map((x) => ModuleDataProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topic_id": topicId,
        "title": title,
        "more_jump_url": moreJumpUrl,
        "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
      };
}
