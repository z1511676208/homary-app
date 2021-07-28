/*
 * @Author       : JHao
 * @Date         : 2021-07-29 14:41:11
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-29 14:41:11
 */
// To parse this JSON data, do
//
//     final topChannelCategoryRes = topChannelCategoryResFromJson(jsonString);

import 'dart:convert';

class TopChannelCategoryRes {
  TopChannelCategoryRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  List<Datum> data;
  String message;

  factory TopChannelCategoryRes.fromRawJson(String str) =>
      TopChannelCategoryRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopChannelCategoryRes.fromJson(Map<String, dynamic> json) =>
      TopChannelCategoryRes(
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.categoryId,
    this.categoryName,
    this.jumpUrl,
    this.fontColor,
    this.channelImgApp,
    this.appCategoryBanner,
  });

  String categoryId;
  String categoryName;
  String jumpUrl;
  String fontColor;
  String channelImgApp;
  String appCategoryBanner;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        jumpUrl: json["jump_url"],
        fontColor: json["font_color"],
        channelImgApp: json["channel_img_app"],
        appCategoryBanner: json["app_category_banner"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "jump_url": jumpUrl,
        "font_color": fontColor,
        "channel_img_app": channelImgApp,
        "app_category_banner": appCategoryBanner,
      };
}
