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
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<AdvDatum>.from(
                json["data"].map((x) => AdvDatum.fromJson(x))),
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

class AdvDatum {
  AdvDatum({
    this.title,
    this.moduleKey,
    this.showType,
    this.grilleType,
    this.positionJumpUrl,
    this.positionJumpUrlEventLabel,
    this.moduleData,
  });

  String title;
  String moduleKey;
  int showType;
  int grilleType;
  String positionJumpUrl;
  String positionJumpUrlEventLabel;
  List<ModuleAdvDatum> moduleData;

  factory AdvDatum.fromRawJson(String str) =>
      AdvDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvDatum.fromJson(Map<String, dynamic> json) => AdvDatum(
        title: json["title"] == null ? null : json["title"],
        moduleKey: json["module_key"] == null ? null : json["module_key"],
        showType: json["show_type"] == null ? null : json["show_type"],
        grilleType: json["grille_type"] == null ? null : json["grille_type"],
        positionJumpUrlEventLabel: json["position_jump_url_event_label"] == null
            ? null
            : json["position_jump_url_event_label"],
        positionJumpUrl: json["position_jump_url"] == null
            ? null
            : json["position_jump_url"],
        moduleData: json["module_data"] == null
            ? null
            : List<ModuleAdvDatum>.from(
                json["module_data"].map((x) => ModuleAdvDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "position_jump_url_event_label": positionJumpUrlEventLabel == null
            ? null
            : positionJumpUrlEventLabel,
        "module_key": moduleKey == null ? null : moduleKey,
        "show_type": showType == null ? null : showType,
        "grille_type": grilleType == null ? null : grilleType,
        "position_jump_url": positionJumpUrl == null ? null : positionJumpUrl,
        "module_data": moduleData == null
            ? null
            : List<dynamic>.from(moduleData.map((x) => x.toJson())),
      };
}

class ModuleAdvDatum {
  ModuleAdvDatum({this.imgUrl, this.jumpUrl, this.title, this.eventLabel});

  String imgUrl;
  String jumpUrl;
  String title;
  String eventLabel;

  factory ModuleAdvDatum.fromRawJson(String str) =>
      ModuleAdvDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModuleAdvDatum.fromJson(Map<String, dynamic> json) => ModuleAdvDatum(
        imgUrl: json["img_url"] == null ? null : json["img_url"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        title: json["title"] == null ? null : json["title"],
        eventLabel: json["event_label"] == null ? null : json["event_label"],
      );

  Map<String, dynamic> toJson() => {
        "img_url": imgUrl == null ? null : imgUrl,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "title": title == null ? null : title,
        "event_label": eventLabel == null ? null : eventLabel,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
