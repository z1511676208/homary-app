/*
 * @Author       : JHao
 * @Date         : 2021-07-27 11:30:55
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 14:09:45
 */
// To parse this JSON data, do
//
//     final serviceTimeRes = serviceTimeResFromJson(jsonString);

import 'dart:convert';

class ServiceTimeRes {
  ServiceTimeRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory ServiceTimeRes.fromRawJson(String str) =>
      ServiceTimeRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceTimeRes.fromJson(Map<String, dynamic> json) => ServiceTimeRes(
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
    this.timeStamp,
    this.timeZoneCode,
    this.dateTime,
  });

  int timeStamp;
  String timeZoneCode;
  DateTime dateTime;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        timeStamp: json["time_stamp"],
        timeZoneCode: json["time_zone_code"],
        dateTime: DateTime.parse(json["date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "time_stamp": timeStamp,
        "time_zone_code": timeZoneCode,
        "date_time": dateTime.toIso8601String(),
      };
}
