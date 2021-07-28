/*
 * @Author       : JHao
 * @Date         : 2021-07-30 11:33:42
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-30 11:33:42
 */
// To parse this JSON data, do
//
//     final categoryRes = categoryResFromJson(jsonString);

import 'dart:convert';

class CategoryRes {
  CategoryRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory CategoryRes.fromRawJson(String str) =>
      CategoryRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryRes.fromJson(Map<String, dynamic> json) => CategoryRes(
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
    this.categoryId,
    this.categoryName,
    this.jumpUrl,
    this.categoryType,
    this.tagImgUrl,
    this.tagActiveImgUrl,
    this.categoryImgList,
    this.subList,
    this.fontColor,
    this.channelImgM,
    this.channelImgApp,
    this.appCategoryBanner,
  });

  String categoryId;
  String categoryName;
  String jumpUrl;
  int categoryType;
  String tagImgUrl;
  String tagActiveImgUrl;
  List<CategoryImgList> categoryImgList;
  List<Data> subList;
  String fontColor;
  String channelImgM;
  String channelImgApp;
  String appCategoryBanner;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        jumpUrl: json["jump_url"],
        categoryType: json["category_type"],
        tagImgUrl: json["tag_img_url"],
        tagActiveImgUrl: json["tag_active_img_url"],
        categoryImgList: List<CategoryImgList>.from(
            json["category_img_list"].map((x) => CategoryImgList.fromJson(x))),
        subList: List<Data>.from(json["sub_list"].map((x) => Data.fromJson(x))),
        fontColor: json["font_color"],
        channelImgM: json["channel_img_m"],
        channelImgApp: json["channel_img_app"],
        appCategoryBanner: json["app_category_banner"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "jump_url": jumpUrl,
        "category_type": categoryType,
        "tag_img_url": tagImgUrl,
        "tag_active_img_url": tagActiveImgUrl,
        "category_img_list":
            List<dynamic>.from(categoryImgList.map((x) => x.toJson())),
        "sub_list": List<dynamic>.from(subList.map((x) => x.toJson())),
        "font_color": fontColor,
        "channel_img_m": channelImgM,
        "channel_img_app": channelImgApp,
        "app_category_banner": appCategoryBanner,
      };
}

class CategoryImgList {
  CategoryImgList({
    this.jumpType,
    this.jumpUrl,
    this.pathUrl,
  });

  String jumpType;
  String jumpUrl;
  String pathUrl;

  factory CategoryImgList.fromRawJson(String str) =>
      CategoryImgList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryImgList.fromJson(Map<String, dynamic> json) =>
      CategoryImgList(
        jumpType: json["jump_type"],
        jumpUrl: json["jump_url"],
        pathUrl: json["path_url"],
      );

  Map<String, dynamic> toJson() => {
        "jump_type": jumpType,
        "jump_url": jumpUrl,
        "path_url": pathUrl,
      };
}
