// To parse this JSON data, do
//
//     final closeAccountReasonRes = closeAccountReasonResFromJson(jsonString);

import 'dart:convert';

class CloseAccountReasonRes {
  CloseAccountReasonRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  CloseAccountReasonData data;
  String message;

  factory CloseAccountReasonRes.fromRawJson(String str) =>
      CloseAccountReasonRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CloseAccountReasonRes.fromJson(Map<String, dynamic> json) =>
      CloseAccountReasonRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : CloseAccountReasonData.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class CloseAccountReasonData {
  CloseAccountReasonData({
    this.title,
    this.content,
  });

  String title;
  List<Content> content;

  factory CloseAccountReasonData.fromRawJson(String str) =>
      CloseAccountReasonData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CloseAccountReasonData.fromJson(Map<String, dynamic> json) =>
      CloseAccountReasonData(
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null
            ? null
            : List<Content>.from(
                json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "content": content == null
            ? null
            : List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.content,
    this.code,
    this.isSelect = false,
  });

  String content;
  String code;
  bool isSelect;

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        content: json["content"] == null ? null : json["content"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content,
        "code": code == null ? null : code,
      };
}
