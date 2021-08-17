/*
 * @Author       : zhhjie
 * @Date         : 2021-08-25 10:10:20
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-26 18:52:26
 */
// To parse this JSON data, do
//
//     final upgradeRes = upgradeResFromJson(jsonString);

import 'dart:convert';

class UpgradeReq {
  UpgradeReq({this.version, this.language}) : super();

  String version;
  String language;

  factory UpgradeReq.fromJson(Map<String, dynamic> json) {
    return UpgradeReq(
      version: json["version"],
      language: json["language"],
    );
  }

  Map<String, dynamic> toJson() => {
        "version": version,
        "language": language,
      };
}
// To parse this JSON data, do
//
//     final upgradeRes = upgradeResFromJson(jsonString);

class UpgradeRes {
  UpgradeRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory UpgradeRes.fromRawJson(String str) =>
      UpgradeRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpgradeRes.fromJson(Map<String, dynamic> json) => UpgradeRes(
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
    this.isUpgrade,
    this.upgradeVersion,
    this.content,
  });

  int isUpgrade;
  String upgradeVersion;
  String content;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isUpgrade: json["is_upgrade"] == null ? null : json["is_upgrade"],
        upgradeVersion:
            json["upgrade_version"] == null ? null : json["upgrade_version"],
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "is_upgrade": isUpgrade == null ? null : isUpgrade,
        "upgrade_version": upgradeVersion == null ? null : upgradeVersion,
        "content": content == null ? null : content,
      };
}
