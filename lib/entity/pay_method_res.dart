// To parse this JSON data, do
//
//     final payMethodRes = payMethodResFromJson(jsonString);

import 'dart:convert';

class PayMethodRes {
  PayMethodRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  List<PayMethodDatum> data;
  String message;

  factory PayMethodRes.fromRawJson(String str) =>
      PayMethodRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayMethodRes.fromJson(Map<String, dynamic> json) => PayMethodRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<PayMethodDatum>.from(
                json["data"].map((x) => PayMethodDatum.fromJson(x))),
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

class PayMethodDatum {
  PayMethodDatum({
    this.code,
    this.iconSmall,
  });

  String code;
  String iconSmall;

  factory PayMethodDatum.fromRawJson(String str) =>
      PayMethodDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayMethodDatum.fromJson(Map<String, dynamic> json) => PayMethodDatum(
        code: json["code"] == null ? null : json["code"],
        iconSmall: json["icon_small"] == null ? null : json["icon_small"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "icon_small": iconSmall == null ? null : iconSmall,
      };
}
