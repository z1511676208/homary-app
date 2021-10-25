/*
 * @Author       : JHao
 * @Date         : 2021-09-03 11:29:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 16:27:42
 */
// To parse this JSON data, do
//
//     final flashModuleRes = flashModuleResFromJson(jsonString);

import 'dart:convert';

import 'package:homary/entity/home.dart';

class FlashModuleRes {
  FlashModuleRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  FlashData data;
  String message;

  factory FlashModuleRes.fromRawJson(String str) =>
      FlashModuleRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlashModuleRes.fromJson(Map<String, dynamic> json) => FlashModuleRes(
        code: json["code"],
        data: FlashData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class FlashData {
  FlashData({
    this.moduleTitle,
    this.moduleDesc,
    this.eventLabel,
    this.onSaleProduct,
    this.upComingProduct,
  });

  String moduleTitle;
  String moduleDesc;
  String eventLabel;
  Product onSaleProduct;
  Product upComingProduct;

  factory FlashData.fromRawJson(String str) =>
      FlashData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlashData.fromJson(Map<String, dynamic> json) => FlashData(
        moduleTitle: json["module_title"],
        moduleDesc: json["module_desc"],
        eventLabel: json["event_label"],
        onSaleProduct: Product.fromJson(json["on_sale_product"]),
        upComingProduct: Product.fromJson(json["up_coming_product"]),
      );

  Map<String, dynamic> toJson() => {
        "module_title": moduleTitle,
        "module_desc": moduleDesc,
        "event_label": eventLabel,
        "on_sale_product": onSaleProduct.toJson(),
        "up_coming_product": upComingProduct.toJson(),
      };
}

class Product {
  Product({
    this.activityStartTimeStamp,
    this.activityEndTimeStamp,
    this.activityStartTime,
    this.productList,
  });

  List<ModuleDataProductList> productList;
  dynamic activityEndTimeStamp;
  dynamic activityStartTimeStamp;
  dynamic activityStartTime;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productList: List<ModuleDataProductList>.from(
            json["product_list"].map((x) => ModuleDataProductList.fromJson(x))),
        activityEndTimeStamp: json["activity_end_time_stamp"],
        activityStartTimeStamp: json["activity_start_time_stamp"],
        activityStartTime: json["activity_start_time"],
      );

  Map<String, dynamic> toJson() => {
        "activity_start_time": activityStartTime,
        "activity_end_time_stamp": activityEndTimeStamp,
        "activity_start_time_stamp": activityStartTimeStamp,
        "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
      };
}
