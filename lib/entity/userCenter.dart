/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 09:55:08
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 09:55:28
 */
// To parse this JSON data, do
//
//     final userCenterRes = userCenterResFromJson(jsonString);

import 'dart:convert';

class UserCenterRes {
  UserCenterRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory UserCenterRes.fromRawJson(String str) =>
      UserCenterRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCenterRes.fromJson(Map<String, dynamic> json) => UserCenterRes(
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
    this.couponCount,
    this.pointCount,
    this.goodsCollectionCount,
    this.userViewCount,
    this.unpaidOrderCount,
    this.processingOrderCount,
    this.shippedOrderCount,
    this.returnOrderCount,
    this.userIdentification,
  });

  String couponCount;
  int pointCount;
  String goodsCollectionCount;
  String userViewCount;
  String unpaidOrderCount;
  String processingOrderCount;
  String shippedOrderCount;
  String returnOrderCount;
  String userIdentification;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        couponCount: json["coupon_count"] == null ? null : json["coupon_count"],
        pointCount: json["point_count"] == null ? null : json["point_count"],
        goodsCollectionCount: json["goods_collection_count"] == null
            ? null
            : json["goods_collection_count"],
        userViewCount:
            json["user_view_count"] == null ? null : json["user_view_count"],
        unpaidOrderCount: json["unpaid_order_count"] == null
            ? null
            : json["unpaid_order_count"],
        processingOrderCount: json["processing_order_count"] == null
            ? null
            : json["processing_order_count"],
        shippedOrderCount: json["shipped_order_count"] == null
            ? null
            : json["shipped_order_count"],
        returnOrderCount: json["return_order_count"] == null
            ? null
            : json["return_order_count"],
        userIdentification: json["user_identification"] == null
            ? null
            : json["user_identification"],
      );

  Map<String, dynamic> toJson() => {
        "coupon_count": couponCount == null ? null : couponCount,
        "point_count": pointCount == null ? null : pointCount,
        "goods_collection_count":
            goodsCollectionCount == null ? null : goodsCollectionCount,
        "user_view_count": userViewCount == null ? null : userViewCount,
        "unpaid_order_count":
            unpaidOrderCount == null ? null : unpaidOrderCount,
        "processing_order_count":
            processingOrderCount == null ? null : processingOrderCount,
        "shipped_order_count":
            shippedOrderCount == null ? null : shippedOrderCount,
        "return_order_count":
            returnOrderCount == null ? null : returnOrderCount,
        "user_identification":
            userIdentification == null ? null : userIdentification,
      };
}
