/*
 * @Author       : JHao
 * @Date         : 2021-08-05 11:41:52
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-05 13:39:45
 */
// To parse this JSON data, do
//
//     final RecentlyBrowsedRes = RecentlyBrowsedResFromJson(jsonString);

import 'dart:convert';

import 'package:homary/entity/home.dart';

class RecentlyBrowsedRes {
  RecentlyBrowsedRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory RecentlyBrowsedRes.fromRawJson(String str) =>
      RecentlyBrowsedRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentlyBrowsedRes.fromJson(Map<String, dynamic> json) =>
      RecentlyBrowsedRes(
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
    this.total,
    this.skuList,
    this.hasMorePage,
  });

  String total;
  List<ModuleDataProductList> skuList;
  int hasMorePage;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        skuList: List<ModuleDataProductList>.from(
            json["sku_list"].map((x) => ModuleDataProductList.fromJson(x))),
        hasMorePage: json["has_more_page"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "sku_list": List<dynamic>.from(skuList.map((x) => x.toJson())),
        "has_more_page": hasMorePage,
      };
}

class SkuList {
  SkuList({
    this.title,
    this.price,
    this.priceSymbol,
    this.tagPrice,
    this.tagPriceSymbol,
    this.spuId,
    this.skuId,
    this.spuCode,
    this.skuCode,
    this.imgUrl,
    this.jumpUrl,
    this.status,
    this.activityStatus,
    this.statusDesc,
    this.spuCategoryNameFirst,
    this.spuCategoryNameSecond,
    this.spuCategoryNameThird,
    this.spuCategoryNameFourth,
    this.reviewScore,
    this.reviewNum,
    this.skuSaleNum,
    this.sortWeight,
    this.purchaseRate,
    this.cornerText,
    this.cornerBgUrl,
    this.purchaseBuyRate,
    this.spuCategoryIdThird,
    this.activityEndTimeStamp,
    this.priceOffDesc,
    this.eventLabel,
    this.mergeSkuList,
    this.mergeSkuDesc,
    this.totalSkuNum,
    this.ctime,
  });

  String title;
  String price;
  String priceSymbol;
  String tagPrice;
  String tagPriceSymbol;
  String spuId;
  String skuId;
  String spuCode;
  String skuCode;
  String imgUrl;
  String jumpUrl;
  int status;
  int activityStatus;
  String statusDesc;
  String spuCategoryNameFirst;
  String spuCategoryNameSecond;
  String spuCategoryNameThird;
  String spuCategoryNameFourth;
  int reviewScore;
  int reviewNum;
  double skuSaleNum;
  String sortWeight;
  String purchaseRate;
  String cornerText;
  String cornerBgUrl;
  String purchaseBuyRate;
  String spuCategoryIdThird;
  int activityEndTimeStamp;
  String priceOffDesc;
  String eventLabel;
  List<ModuleDataProductList> mergeSkuList;
  String mergeSkuDesc;
  String totalSkuNum;
  int ctime;

  factory SkuList.fromRawJson(String str) => SkuList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SkuList.fromJson(Map<String, dynamic> json) => SkuList(
        title: json["title"],
        price: json["price"],
        priceSymbol: json["price_symbol"],
        tagPrice: json["tag_price"],
        tagPriceSymbol: json["tag_price_symbol"],
        spuId: json["spu_id"],
        skuId: json["sku_id"],
        spuCode: json["spu_code"],
        skuCode: json["sku_code"],
        imgUrl: json["img_url"],
        jumpUrl: json["jump_url"],
        status: json["status"],
        activityStatus: json["activity_status"],
        statusDesc: json["status_desc"],
        spuCategoryNameFirst: json["spu_category_name_first"],
        spuCategoryNameSecond: json["spu_category_name_second"],
        spuCategoryNameThird: json["spu_category_name_third"],
        spuCategoryNameFourth: json["spu_category_name_fourth"],
        reviewScore: json["review_score"],
        reviewNum: json["review_num"],
        skuSaleNum: json["sku_sale_num"].toDouble(),
        sortWeight: json["sort_weight"],
        purchaseRate: json["purchase_rate"],
        cornerText: json["corner_text"],
        cornerBgUrl: json["corner_bg_url"],
        purchaseBuyRate: json["purchase_buy_rate"],
        spuCategoryIdThird: json["spu_category_id_third"],
        activityEndTimeStamp: json["activity_end_time_stamp"],
        priceOffDesc: json["price_off_desc"],
        eventLabel: json["event_label"],
        mergeSkuList: List<ModuleDataProductList>.from(
            json["merge_sku_list"].map((x) => x)),
        mergeSkuDesc: json["merge_sku_desc"],
        totalSkuNum: json["total_sku_num"],
        ctime: json["ctime"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "price_symbol": priceSymbol,
        "tag_price": tagPrice,
        "tag_price_symbol": tagPriceSymbol,
        "spu_id": spuId,
        "sku_id": skuId,
        "spu_code": spuCode,
        "sku_code": skuCode,
        "img_url": imgUrl,
        "jump_url": jumpUrl,
        "status": status,
        "activity_status": activityStatus,
        "status_desc": statusDesc,
        "spu_category_name_first": spuCategoryNameFirst,
        "spu_category_name_second": spuCategoryNameSecond,
        "spu_category_name_third": spuCategoryNameThird,
        "spu_category_name_fourth": spuCategoryNameFourth,
        "review_score": reviewScore,
        "review_num": reviewNum,
        "sku_sale_num": skuSaleNum,
        "sort_weight": sortWeight,
        "purchase_rate": purchaseRate,
        "corner_text": cornerText,
        "corner_bg_url": cornerBgUrl,
        "purchase_buy_rate": purchaseBuyRate,
        "spu_category_id_third": spuCategoryIdThird,
        "activity_end_time_stamp": activityEndTimeStamp,
        "price_off_desc": priceOffDesc,
        "event_label": eventLabel,
        "merge_sku_list":
            List<ModuleDataProductList>.from(mergeSkuList.map((x) => x)),
        "merge_sku_desc": mergeSkuDesc,
        "total_sku_num": totalSkuNum,
        "ctime": ctime,
      };
}
