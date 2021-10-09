// To parse this JSON data, do
//
//     final closeAccountInfoRes = closeAccountInfoResFromJson(jsonString);

import 'dart:convert';

class CloseAccountInfoRes {
  CloseAccountInfoRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  CloseAccountInfoData data;
  String message;

  factory CloseAccountInfoRes.fromRawJson(String str) =>
      CloseAccountInfoRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CloseAccountInfoRes.fromJson(Map<String, dynamic> json) =>
      CloseAccountInfoRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : CloseAccountInfoData.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class CloseAccountInfoData {
  CloseAccountInfoData({
    this.title,
    this.info,
    this.applyStatus,
    this.reviewTips,
  });

  String title;
  String info;
  String applyStatus;
  String reviewTips;

  factory CloseAccountInfoData.fromRawJson(String str) =>
      CloseAccountInfoData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CloseAccountInfoData.fromJson(Map<String, dynamic> json) =>
      CloseAccountInfoData(
        title: json["title"] == null ? null : json["title"],
        info: json["info"] == null ? null : json["info"],
        applyStatus: json["apply_status"] == null ? null : json["apply_status"],
        reviewTips: json["review_tips"] == null ? null : json["review_tips"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "info": info == null ? null : info,
        "apply_status": applyStatus == null ? null : applyStatus,
        "review_tips": reviewTips == null ? null : reviewTips,
      };
}
