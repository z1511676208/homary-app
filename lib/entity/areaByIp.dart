/*
 * @Author       : JHao
 * @Date         : 2021-08-26 14:21:15
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-28 16:38:10
 */
// To parse this JSON data, do
//
//     final areaByIpRes = areaByIpResFromJson(jsonString);

import 'dart:convert';

class AreaByIpRes {
  AreaByIpRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  AreaData data;
  String message;

  factory AreaByIpRes.fromRawJson(String str) =>
      AreaByIpRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AreaByIpRes.fromJson(Map<String, dynamic> json) => AreaByIpRes(
        code: json["code"],
        data: json["data"] == null || json["data"] is List
            ? null
            : AreaData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class AreaData {
  AreaData({
    this.countryCode,
    this.stateCode,
    this.city,
    this.zip,
  });

  String countryCode;
  String stateCode;
  String city;
  String zip;

  factory AreaData.fromRawJson(String str) =>
      AreaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
        countryCode: json["country_code"],
        stateCode: json["state_code"],
        city: json["city"],
        zip: json["zip"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "state_code": stateCode,
        "city": city,
        "zip": zip,
      };
}
