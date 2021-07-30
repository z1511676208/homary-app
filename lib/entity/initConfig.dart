// To parse this JSON data, do
//
//     final initConfigRes = initConfigResFromJson(jsonString);

import 'dart:convert';

class InitConfigRes {
  InitConfigRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory InitConfigRes.fromRawJson(String str) =>
      InitConfigRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InitConfigRes.fromJson(Map<String, dynamic> json) => InitConfigRes(
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
    this.urlMapData,
    this.dynamicData,
  });

  Map<String, dynamic> urlMapData;
  Map<String, dynamic> dynamicData;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        urlMapData: json["url_map_data"],
        dynamicData: json["dynamic_data"],
      );

  Map<String, dynamic> toJson() => {
        "url_map_data": urlMapData,
        "dynamic_data": dynamicData,
      };
}
