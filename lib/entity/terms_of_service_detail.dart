// To parse this JSON data, do
//
//     final termsOfServiceDetailRes = termsOfServiceDetailResFromJson(jsonString);

import 'dart:convert';

class TermsOfServiceDetailRes {
  TermsOfServiceDetailRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  TermsOfServiceDetail data;
  String message;

  factory TermsOfServiceDetailRes.fromRawJson(String str) =>
      TermsOfServiceDetailRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsOfServiceDetailRes.fromJson(Map<String, dynamic> json) =>
      TermsOfServiceDetailRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : TermsOfServiceDetail.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class TermsOfServiceDetail {
  TermsOfServiceDetail({
    this.title,
    this.termsOfService,
  });

  String title;
  List<TermsService> termsOfService;

  factory TermsOfServiceDetail.fromRawJson(String str) =>
      TermsOfServiceDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsOfServiceDetail.fromJson(Map<String, dynamic> json) =>
      TermsOfServiceDetail(
        title: json["title"] == null ? null : json["title"],
        termsOfService: json["terms_of_service"] == null
            ? null
            : List<TermsService>.from(
                json["terms_of_service"].map((x) => TermsService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "terms_of_service": termsOfService == null
            ? null
            : List<dynamic>.from(termsOfService.map((x) => x.toJson())),
      };
}

class TermsService {
  TermsService({
    this.key,
    this.title,
    this.content,
    this.icon,
    this.type,
    this.sort,
  });

  String key;
  String title;
  List<String> content;
  String icon;
  String type;
  String sort;

  factory TermsService.fromRawJson(String str) =>
      TermsService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsService.fromJson(Map<String, dynamic> json) => TermsService(
        key: json["key"] == null ? null : json["key"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null
            ? null
            : List<String>.from(json["content"].map((x) => x)),
        icon: json["icon"] == null ? null : json["icon"],
        type: json["type"] == null ? null : json["type"],
        sort: json["sort"] == null ? null : json["sort"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "title": title == null ? null : title,
        "content":
            content == null ? null : List<dynamic>.from(content.map((x) => x)),
        "icon": icon == null ? null : icon,
        "type": type == null ? null : type,
        "sort": sort == null ? null : sort,
      };
}
