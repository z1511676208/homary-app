// To parse this JSON data, do
//
//     final productRes = productResFromJson(jsonString);

import 'dart:convert';

import 'package:homary/entity/home.dart';

class ProductRes {
  ProductRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  ProductResData data;
  String message;

  factory ProductRes.fromRawJson(String str) =>
      ProductRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductRes.fromJson(Map<String, dynamic> json) => ProductRes(
        code: json["code"],
        data: ProductResData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class ProductResData {
  ProductResData({
    this.list,
    this.total,
    this.hasMorePage,
    this.totalPage,
    this.seoData,
    this.appCategoryBanner,
    this.seeAlsoData,
  });

  List<ModuleDataProductList> list;
  int total;
  int hasMorePage;
  int totalPage;
  SeoData seoData;
  String appCategoryBanner;
  List<SeeAlsoData> seeAlsoData;

  factory ProductResData.fromRawJson(String str) =>
      ProductResData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductResData.fromJson(Map<String, dynamic> json) => ProductResData(
        list: List<ModuleDataProductList>.from(
            json["list"].map((x) => ModuleDataProductList.fromJson(x))),
        total: json["total"],
        hasMorePage: json["has_more_page"],
        totalPage: json["total_page"],
        seoData: SeoData.fromJson(json["seo_data"]),
        appCategoryBanner: json["app_category_banner"],
        seeAlsoData: List<SeeAlsoData>.from(
            json["see_also"].map((x) => SeeAlsoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "total": total,
        "has_more_page": hasMorePage,
        "total_page": totalPage,
        "seo_data": seoData.toJson(),
        "app_category_banner": appCategoryBanner,
        "see_also": List<dynamic>.from(seeAlsoData.map((x) => x.toJson())),
      };
}

class SeoData {
  SeoData({
    this.seoTitle,
    this.seoKeyword,
    this.seoDescription,
  });

  String seoTitle;
  String seoKeyword;
  String seoDescription;

  factory SeoData.fromRawJson(String str) => SeoData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SeoData.fromJson(Map<String, dynamic> json) => SeoData(
        seoTitle: json["seo_title"],
        seoKeyword: json["seo_keyword"],
        seoDescription: json["seo_description"],
      );

  Map<String, dynamic> toJson() => {
        "seo_title": seoTitle,
        "seo_keyword": seoKeyword,
        "seo_description": seoDescription,
      };
}

class SeeAlsoData {
  SeeAlsoData({
    this.channelId,
    this.channelName,
    this.channelUrl,
  });

  String channelId;
  String channelName;
  String channelUrl;

  factory SeeAlsoData.fromRawJson(String str) =>
      SeeAlsoData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SeeAlsoData.fromJson(Map<String, dynamic> json) => SeeAlsoData(
        channelId: json["channel_id"] == null ? null : json["channel_id"],
        channelName: json["channel_name"] == null ? null : json["channel_name"],
        channelUrl: json["channel_url"] == null ? null : json["channel_url"],
      );

  Map<String, dynamic> toJson() => {
        "channel_id": channelId == null ? null : channelId,
        "channel_name": channelName == null ? null : channelName,
        "channel_url": channelUrl == null ? null : channelUrl,
      };
}
