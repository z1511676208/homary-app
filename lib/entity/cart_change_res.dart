/*
 * @Author       : JHao
 * @Date         : 2021-09-28 19:53:07
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-29 11:44:42
 */
// To parse this JSON data, do
//
//     final cartChangeRes = cartChangeResFromJson(jsonString);

import 'dart:convert';

class CartChangeRes {
  CartChangeRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  List<CartChangeDatum> data;
  dynamic message;

  factory CartChangeRes.fromRawJson(String str) =>
      CartChangeRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartChangeRes.fromJson(Map<String, dynamic> json) => CartChangeRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : json["data"] is List
                ? List<CartChangeDatum>.from(
                    json["data"].map((x) => CartChangeDatum.fromJson(x)))
                : null,
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class CartChangeDatum {
  CartChangeDatum({
    this.checkStatus,
    this.checkStatusName,
    this.skuId,
    this.msg,
  });

  int checkStatus;
  String checkStatusName;
  String skuId;
  String msg;

  factory CartChangeDatum.fromRawJson(String str) =>
      CartChangeDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartChangeDatum.fromJson(Map<String, dynamic> json) =>
      CartChangeDatum(
        checkStatus: json["check_status"] == null ? null : json["check_status"],
        checkStatusName: json["check_status_name"] == null
            ? null
            : json["check_status_name"],
        skuId: json["sku_id"] == null ? null : json["sku_id"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "check_status": checkStatus == null ? null : checkStatus,
        "check_status_name": checkStatusName == null ? null : checkStatusName,
        "sku_id": skuId == null ? null : skuId,
        "msg": msg == null ? null : msg,
      };
}
