// To parse this JSON data, do
//
//     final homeDataRes = homeDataResFromJson(jsonString);

import 'dart:convert';

class ModuleDataProductList {
  ModuleDataProductList(
      {this.title,
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
      this.activityEndTimeStamp,
      this.activityStartTimeStamp,
      this.activityEndTime,
      this.activityStartTime,
      this.priceOffDesc,
      this.mergeSkuList,
      this.mergeSkuDesc,
      this.totalSkuNum,
      this.spuSaleQuantityDesc});

  String title;
  String price;
  String priceSymbol;
  dynamic tagPrice;
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
  dynamic reviewScore;
  dynamic reviewNum;
  dynamic skuSaleNum;
  dynamic sortWeight;
  dynamic purchaseRate;
  String cornerText;
  String cornerBgUrl;
  int activityStartTimeStamp;
  int activityEndTimeStamp;
  String activityStartTime;
  String activityEndTime;
  String priceOffDesc;
  List<ModuleDataProductList> mergeSkuList;
  String mergeSkuDesc;
  String totalSkuNum;
  String spuSaleQuantityDesc;

  factory ModuleDataProductList.fromRawJson(String str) =>
      ModuleDataProductList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModuleDataProductList.fromJson(Map<String, dynamic> json) =>
      ModuleDataProductList(
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
          skuSaleNum: json["sku_sale_num"],
          sortWeight: json["sort_weight"],
          purchaseRate: json["purchase_rate"],
          cornerText: json["corner_text"],
          cornerBgUrl: json["corner_bg_url"],
          activityEndTimeStamp: json["activity_end_time_stamp"],
          activityStartTimeStamp: json["activity_start_time_stamp"],
          activityEndTime: json["activity_end_time"],
          activityStartTime: json["activity_start_time"],
          priceOffDesc: json["price_off_desc"],
          mergeSkuList: List<ModuleDataProductList>.from(json["merge_sku_list"]
              ?.map((x) => ModuleDataProductList.fromJson(x))),
          mergeSkuDesc: json["merge_sku_desc"],
          totalSkuNum: json["total_sku_num"],
          spuSaleQuantityDesc: json["spu_sale_quantity_desc"]);

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
        "activity_end_time_stamp": activityEndTimeStamp,
        "activity_start_time_stamp": activityStartTimeStamp,
        "activity_end_time": activityEndTime,
        "activity_start_time": activityStartTime,
        "price_off_desc": priceOffDesc,
        "merge_sku_list":
            List<dynamic>.from(mergeSkuList.map((x) => x.toJson())),
        "merge_sku_desc": mergeSkuDesc,
        "total_sku_num": totalSkuNum,
        "spu_sale_quantity_desc": spuSaleQuantityDesc
      };
}

// class MergeSkuList {
//   MergeSkuList(
//       {this.title,
//       this.price,
//       this.priceSymbol,
//       this.tagPrice,
//       this.tagPriceSymbol,
//       this.spuId,
//       this.skuId,
//       this.spuCode,
//       this.skuCode,
//       this.imgUrl,
//       this.jumpUrl,
//       this.status,
//       this.activityStatus,
//       this.statusDesc,
//       this.spuCategoryNameFirst,
//       this.spuCategoryNameSecond,
//       this.spuCategoryNameThird,
//       this.spuCategoryNameFourth,
//       this.reviewScore,
//       this.reviewNum,
//       this.skuSaleNum,
//       this.sortWeight,
//       this.purchaseRate,
//       this.cornerText,
//       this.cornerBgUrl,
//       this.activityEndTimeStamp,
//       this.priceOffDesc,
//       this.mergeSkuList,
//       this.mergeSkuDesc,
//       this.spuSaleQuantityDesc});

//   String title;
//   String price;
//   String priceSymbol;
//   dynamic tagPrice;
//   String tagPriceSymbol;
//   String spuId;
//   String skuId;
//   String spuCode;
//   String skuCode;
//   String imgUrl;
//   String jumpUrl;
//   int status;
//   int activityStatus;
//   String statusDesc;
//   String spuCategoryNameFirst;
//   String spuCategoryNameSecond;
//   String spuCategoryNameThird;
//   String spuCategoryNameFourth;
//   dynamic reviewScore;
//   dynamic reviewNum;
//   dynamic skuSaleNum;
//   dynamic sortWeight;
//   dynamic purchaseRate;
//   String cornerText;
//   String cornerBgUrl;
//   int activityEndTimeStamp;
//   String priceOffDesc;
//   List<dynamic> mergeSkuList;
//   String mergeSkuDesc;
//   String spuSaleQuantityDesc;

//   factory MergeSkuList.fromRawJson(String str) =>
//       MergeSkuList.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MergeSkuList.fromJson(Map<String, dynamic> json) => MergeSkuList(
//       title: json["title"],
//       price: json["price"],
//       priceSymbol: json["price_symbol"],
//       tagPrice: json["tag_price"],
//       tagPriceSymbol: json["tag_price_symbol"],
//       spuId: json["spu_id"],
//       skuId: json["sku_id"],
//       spuCode: json["spu_code"],
//       skuCode: json["sku_code"],
//       imgUrl: json["img_url"],
//       jumpUrl: json["jump_url"],
//       status: json["status"],
//       activityStatus: json["activity_status"],
//       statusDesc: json["status_desc"],
//       spuCategoryNameFirst: json["spu_category_name_first"],
//       spuCategoryNameSecond: json["spu_category_name_second"],
//       spuCategoryNameThird: json["spu_category_name_third"],
//       spuCategoryNameFourth: json["spu_category_name_fourth"],
//       reviewScore: json["review_score"],
//       reviewNum: json["review_num"],
//       skuSaleNum: json["sku_sale_num"],
//       sortWeight: json["sort_weight"],
//       purchaseRate: json["purchase_rate"],
//       cornerText: json["corner_text"],
//       cornerBgUrl: json["corner_bg_url"],
//       activityEndTimeStamp: json["activity_end_time_stamp"],
//       priceOffDesc: json["price_off_desc"],
//       mergeSkuList: List<dynamic>.from(json["merge_sku_list"].map((x) => x)),
//       mergeSkuDesc: json["merge_sku_desc"],
//       spuSaleQuantityDesc: json["spu_sale_quantity_desc"]);

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "price": price,
//         "price_symbol": priceSymbol,
//         "tag_price": tagPrice,
//         "tag_price_symbol": tagPriceSymbol,
//         "spu_id": spuId,
//         "sku_id": skuId,
//         "spu_code": spuCode,
//         "sku_code": skuCode,
//         "img_url": imgUrl,
//         "jump_url": jumpUrl,
//         "status": status,
//         "activity_status": activityStatus,
//         "status_desc": statusDesc,
//         "spu_category_name_first": spuCategoryNameFirst,
//         "spu_category_name_second": spuCategoryNameSecond,
//         "spu_category_name_third": spuCategoryNameThird,
//         "spu_category_name_fourth": spuCategoryNameFourth,
//         "review_score": reviewScore,
//         "review_num": reviewNum,
//         "sku_sale_num": skuSaleNum,
//         "sort_weight": sortWeight,
//         "purchase_rate": purchaseRate,
//         "corner_text": cornerText,
//         "corner_bg_url": cornerBgUrl,
//         "activity_end_time_stamp": activityEndTimeStamp,
//         "price_off_desc": priceOffDesc,
//         "merge_sku_list": List<dynamic>.from(mergeSkuList.map((x) => x)),
//         "merge_sku_desc": mergeSkuDesc,
//         "spu_sale_quantity_desc": spuSaleQuantityDesc
//       };
// }

class ReviewList {
  ReviewList({
    this.productImage,
    this.imgUrl,
    this.jumpUrl,
    this.username,
    this.score,
    this.title,
    this.content,
  });

  String productImage;
  String imgUrl;
  String jumpUrl;
  String username;
  double score;
  String title;
  String content;

  factory ReviewList.fromRawJson(String str) =>
      ReviewList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewList.fromJson(Map<String, dynamic> json) => ReviewList(
        productImage: json["product_image"],
        imgUrl: json["img_url"],
        jumpUrl: json["jump_url"],
        username: json["username"],
        score: json["score"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "product_image": productImage,
        "img_url": imgUrl,
        "jump_url": jumpUrl,
        "username": username,
        "score": score,
        "title": title,
        "content": content,
      };
}

class ServiceList {
  ServiceList({
    this.name,
    this.icon,
    this.jumpUrl,
  });

  String name;
  String icon;
  String jumpUrl;

  factory ServiceList.fromRawJson(String str) =>
      ServiceList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
        name: json["name"],
        icon: json["icon"],
        jumpUrl: json["jump_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "jump_url": jumpUrl,
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
