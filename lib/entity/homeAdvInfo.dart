/*
 * @Author       : JHao
 * @Date         : 2021-08-02 15:05:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-02 15:17:03
 */
// To parse this JSON data, do
//
//     final appAdvInfoRes = appAdvInfoResFromJson(jsonString);

import 'dart:convert';

class AppAdvInfoRes {
  AppAdvInfoRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  List<AdvDatum> data;
  String message;

  factory AppAdvInfoRes.fromRawJson(String str) =>
      AppAdvInfoRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppAdvInfoRes.fromJson(Map<String, dynamic> json) => AppAdvInfoRes(
        code: json["code"],
        data:
            List<AdvDatum>.from(json["data"].map((x) => AdvDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class AdvDatum {
  AdvDatum({
    this.moduleType,
    this.moduleData,
  });

  int moduleType;
  List<ModuleAdvDatum> moduleData;

  factory AdvDatum.fromRawJson(String str) =>
      AdvDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvDatum.fromJson(Map<String, dynamic> json) => AdvDatum(
        moduleType: json["module_type"],
        moduleData: List<ModuleAdvDatum>.from(
            json["module_data"].map((x) => ModuleAdvDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "module_type": moduleType,
        "module_data": List<dynamic>.from(moduleData.map((x) => x.toJson())),
      };
}

class ModuleAdvDatum {
  ModuleAdvDatum({
    this.advertId,
    this.title,
    this.imgUrl,
    this.jumpUrl,
    this.bgColor,
  });

  String advertId;
  String title;
  String imgUrl;
  String jumpUrl;
  String bgColor;

  factory ModuleAdvDatum.fromRawJson(String str) =>
      ModuleAdvDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModuleAdvDatum.fromJson(Map<String, dynamic> json) => ModuleAdvDatum(
        advertId: json["advert_id"],
        title: json["title"],
        imgUrl: json["img_url"],
        jumpUrl: json["jump_url"],
        bgColor: json["bg_color"],
      );

  Map<String, dynamic> toJson() => {
        "advert_id": advertId,
        "title": title,
        "img_url": imgUrl,
        "jump_url": jumpUrl,
        "bg_color": bgColor,
      };
}
