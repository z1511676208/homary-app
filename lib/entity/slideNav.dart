// To parse this JSON data, do
//
//     final slideNavRes = slideNavResFromJson(jsonString);

import 'dart:convert';

class SlideNavRes {
  SlideNavRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  List<Datum> data;
  String message;

  factory SlideNavRes.fromRawJson(String str) =>
      SlideNavRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SlideNavRes.fromJson(Map<String, dynamic> json) => SlideNavRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.categoryId,
    this.categoryName,
    this.jumpUrl,
    this.categoryType,
    this.tagImgUrl,
    this.tagActiveImgUrl,
    this.categoryImgList,
    this.subList,
    this.fontColor,
  });

  String categoryId;
  String categoryName;
  String jumpUrl;
  int categoryType;
  String tagImgUrl;
  String tagActiveImgUrl;
  List<CategoryImgList> categoryImgList;
  List<Datum> subList;
  String fontColor;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        categoryType:
            json["category_type"] == null ? null : json["category_type"],
        tagImgUrl: json["tag_img_url"] == null ? null : json["tag_img_url"],
        tagActiveImgUrl: json["tag_active_img_url"] == null
            ? null
            : json["tag_active_img_url"],
        categoryImgList: json["category_img_list"] == null
            ? null
            : List<CategoryImgList>.from(json["category_img_list"]
                .map((x) => CategoryImgList.fromJson(x))),
        subList: json["sub_list"] == null
            ? null
            : List<Datum>.from(json["sub_list"].map((x) => Datum.fromJson(x))),
        fontColor: json["font_color"] == '' ? null : json["font_color"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId == null ? null : categoryId,
        "category_name": categoryName == null ? null : categoryName,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "category_type": categoryType == null ? null : categoryType,
        "tag_img_url": tagImgUrl == null ? null : tagImgUrl,
        "tag_active_img_url": tagActiveImgUrl == null ? null : tagActiveImgUrl,
        "category_img_list": categoryImgList == null
            ? null
            : List<dynamic>.from(categoryImgList.map((x) => x.toJson())),
        "sub_list": subList == null
            ? null
            : List<dynamic>.from(subList.map((x) => x.toJson())),
        "font_color": fontColor == '' ? null : fontColor,
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
        jumpType: json["jump_type"] == null ? null : json["jump_type"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        pathUrl: json["path_url"] == null ? null : json["path_url"],
      );

  Map<String, dynamic> toJson() => {
        "jump_type": jumpType == null ? null : jumpType,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "path_url": pathUrl == null ? null : pathUrl,
      };
}
