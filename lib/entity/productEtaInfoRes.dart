/*
 * @Author       : JHao
 * @Date         : 2021-08-26 14:35:26
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-26 15:28:49
 */
// To parse this JSON data, do
//
//     final productEtaInfoRes = productEtaInfoResFromJson(jsonString);

import 'dart:convert';

class ProductEtaInfoRes {
  ProductEtaInfoRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Map<String, Datum> data;
  String message;

  factory ProductEtaInfoRes.fromRawJson(String str) =>
      ProductEtaInfoRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductEtaInfoRes.fromJson(Map<String, dynamic> json) =>
      ProductEtaInfoRes(
        code: json["code"],
        data: Map.from(json["data"])
            .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.deliveryTime,
    this.showLabel,
    this.stockLabel,
    this.dispatchLabel,
    this.dispatchShortLabel,
    this.arrivalLabel,
  });

  String deliveryTime;
  int showLabel;
  String stockLabel;
  String dispatchLabel;
  String dispatchShortLabel;
  String arrivalLabel;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        deliveryTime: json["delivery_time"],
        showLabel: json["show_label"],
        stockLabel: json["stock_label"],
        dispatchLabel: json["dispatch_label"],
        dispatchShortLabel: json["dispatch_short_label"],
        arrivalLabel: json["arrival_label"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_time": deliveryTime,
        "show_label": showLabel,
        "stock_label": stockLabel,
        "dispatch_label": dispatchLabel,
        "dispatch_short_label": dispatchShortLabel,
        "arrival_label": arrivalLabel,
      };
}
