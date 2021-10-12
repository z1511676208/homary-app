/*
 * @Author       : JHao
 * @Date         : 2021-10-13 16:32:56
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-14 16:07:01
 */
// To parse this JSON data, do
//
//     final termsOfServiceRes = termsOfServiceResFromJson(jsonString);

import 'dart:convert';

class TermsOfServiceRes {
  TermsOfServiceRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory TermsOfServiceRes.fromRawJson(String str) =>
      TermsOfServiceRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsOfServiceRes.fromJson(Map<String, dynamic> json) =>
      TermsOfServiceRes(
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
    this.termsOfService,
  });

  List<TermsOfService> termsOfService;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        termsOfService: json["terms_of_service"] == null
            ? null
            : List<TermsOfService>.from(json["terms_of_service"]
                .map((x) => TermsOfService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "terms_of_service": termsOfService == null
            ? null
            : List<dynamic>.from(termsOfService.map((x) => x.toJson())),
      };
}

class TermsOfService {
  TermsOfService({this.title, this.icon, this.eventLabel});

  String title;
  String icon;
  String eventLabel;

  factory TermsOfService.fromRawJson(String str) =>
      TermsOfService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsOfService.fromJson(Map<String, dynamic> json) => TermsOfService(
        title: json["title"] == null ? null : json["title"],
        icon: json["icon"] == null ? null : json["icon"],
        eventLabel: json["event_label"] == null ? null : json["event_label"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "icon": icon == null ? null : icon,
        "event_label": eventLabel == null ? null : eventLabel,
      };
}
