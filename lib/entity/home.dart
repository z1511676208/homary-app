// To parse this JSON data, do
//
//     final homeDataRes = homeDataResFromJson(jsonString);

import 'dart:convert';

class HomeDataRes {
  HomeDataRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory HomeDataRes.fromRawJson(String str) =>
      HomeDataRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeDataRes.fromJson(Map<String, dynamic> json) => HomeDataRes(
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
    this.modules,
    this.seoData,
  });

  List<Module> modules;
  SeoData seoData;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        modules:
            List<Module>.from(json["modules"].map((x) => Module.fromJson(x))),
        seoData: SeoData.fromJson(json["seo_data"]),
      );

  Map<String, dynamic> toJson() => {
        "modules": List<dynamic>.from(modules.map((x) => x.toJson())),
        "seo_data": seoData.toJson(),
      };
}

class Module {
  Module({
    this.moduleType,
    this.moduleData,
  });

  int moduleType;
  ModuleData moduleData;

  factory Module.fromRawJson(String str) => Module.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        moduleType: json["module_type"],
        moduleData: ModuleData.fromJson(json["module_data"]),
      );

  Map<String, dynamic> toJson() => {
        "module_type": moduleType,
        "module_data": moduleData.toJson(),
      };
}

class ModuleData {
  ModuleData({
    this.list,
    this.topicId,
    this.title,
    this.moreJumpUrl,
    this.productList,
    this.reviewList,
    this.channelList,
    this.serviceList,
  });

  List<ListElement> list;
  String topicId;
  String title;
  String moreJumpUrl;
  List<ModuleDataProductList> productList;
  List<ReviewList> reviewList;
  List<ChannelList> channelList;
  List<ServiceList> serviceList;

  factory ModuleData.fromRawJson(String str) =>
      ModuleData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModuleData.fromJson(Map<String, dynamic> json) => ModuleData(
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
        topicId: json["topic_id"] == null ? null : json["topic_id"],
        title: json["title"] == null ? null : json["title"],
        moreJumpUrl:
            json["more_jump_url"] == null ? null : json["more_jump_url"],
        productList: json["product_list"] == null
            ? null
            : List<ModuleDataProductList>.from(json["product_list"]
                .map((x) => ModuleDataProductList.fromJson(x))),
        reviewList: json["review_list"] == null
            ? null
            : List<ReviewList>.from(
                json["review_list"].map((x) => ReviewList.fromJson(x))),
        channelList: json["channel_list"] == null
            ? null
            : List<ChannelList>.from(
                json["channel_list"].map((x) => ChannelList.fromJson(x))),
        serviceList: json["service_list"] == null
            ? null
            : List<ServiceList>.from(
                json["service_list"].map((x) => ServiceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
        "topic_id": topicId == null ? null : topicId,
        "title": title == null ? null : title,
        "more_jump_url": moreJumpUrl == null ? null : moreJumpUrl,
        "product_list": productList == null
            ? null
            : List<dynamic>.from(productList.map((x) => x.toJson())),
        "review_list": reviewList == null
            ? null
            : List<dynamic>.from(reviewList.map((x) => x.toJson())),
        "channel_list": channelList == null
            ? null
            : List<dynamic>.from(channelList.map((x) => x.toJson())),
        "service_list": serviceList == null
            ? null
            : List<dynamic>.from(serviceList.map((x) => x.toJson())),
      };
}

class ChannelList {
  ChannelList({
    this.channelImgUrl,
    this.channelDesc,
    this.moreJumpUrl,
    this.productList,
  });

  String channelImgUrl;
  String channelDesc;
  String moreJumpUrl;
  List<ChannelListProductList> productList;

  factory ChannelList.fromRawJson(String str) =>
      ChannelList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChannelList.fromJson(Map<String, dynamic> json) => ChannelList(
        channelImgUrl: json["channel_img_url"],
        channelDesc: json["channel_desc"],
        moreJumpUrl: json["more_jump_url"],
        productList: List<ChannelListProductList>.from(json["product_list"]
            .map((x) => ChannelListProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "channel_img_url": channelImgUrl,
        "channel_desc": channelDesc,
        "more_jump_url": moreJumpUrl,
        "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
      };
}

class ChannelListProductList {
  ChannelListProductList({
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
    this.activityEndTimeStamp,
    this.priceOffDesc,
    this.mergeSkuList,
    this.mergeSkuDesc,
    this.activityStock,
    this.activityStockTotal,
  });

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
  StatusDesc statusDesc;
  SpuCategoryNameFirst spuCategoryNameFirst;
  String spuCategoryNameSecond;
  String spuCategoryNameThird;
  String spuCategoryNameFourth;
  int reviewScore;
  dynamic reviewNum;
  double skuSaleNum;
  dynamic sortWeight;
  dynamic purchaseRate;
  String cornerText;
  String cornerBgUrl;
  int activityEndTimeStamp;
  String priceOffDesc;
  List<dynamic> mergeSkuList;
  String mergeSkuDesc;
  dynamic activityStock;
  String activityStockTotal;

  factory ChannelListProductList.fromRawJson(String str) =>
      ChannelListProductList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChannelListProductList.fromJson(Map<String, dynamic> json) =>
      ChannelListProductList(
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
        statusDesc: statusDescValues.map[json["status_desc"]],
        spuCategoryNameFirst:
            spuCategoryNameFirstValues.map[json["spu_category_name_first"]],
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
        activityEndTimeStamp: json["activity_end_time_stamp"],
        priceOffDesc: json["price_off_desc"],
        mergeSkuList: List<dynamic>.from(json["merge_sku_list"].map((x) => x)),
        mergeSkuDesc: json["merge_sku_desc"],
        activityStock: json["activity_stock"],
        activityStockTotal: json["activity_stock_total"],
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
        "status_desc": statusDescValues.reverse[statusDesc],
        "spu_category_name_first":
            spuCategoryNameFirstValues.reverse[spuCategoryNameFirst],
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
        "price_off_desc": priceOffDesc,
        "merge_sku_list": List<dynamic>.from(mergeSkuList.map((x) => x)),
        "merge_sku_desc": mergeSkuDesc,
        "activity_stock": activityStock,
        "activity_stock_total": activityStockTotal,
      };
}

enum SpuCategoryNameFirst { LIGHTING, BATH, FURNITURE }

final spuCategoryNameFirstValues = EnumValues({
  "Bath": SpuCategoryNameFirst.BATH,
  "Furniture": SpuCategoryNameFirst.FURNITURE,
  "Lighting": SpuCategoryNameFirst.LIGHTING
});

enum StatusDesc { IN_STOCK, SOLD_OUT }

final statusDescValues = EnumValues(
    {"In stock": StatusDesc.IN_STOCK, "Sold Out": StatusDesc.SOLD_OUT});

class ListElement {
  ListElement({
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

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
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

class ModuleDataProductList {
  ModuleDataProductList({
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
    this.activityEndTimeStamp,
    this.priceOffDesc,
    this.mergeSkuList,
    this.mergeSkuDesc,
    this.totalSkuNum,
  });

  String title;
  String price;
  String priceSymbol;
  dynamic tagPrice;
  String tagPriceSymbol;
  String spuId;
  String skuId;
  SpuCode spuCode;
  SkuCode skuCode;
  String imgUrl;
  String jumpUrl;
  int status;
  int activityStatus;
  StatusDesc statusDesc;
  SpuCategoryNameFirst spuCategoryNameFirst;
  SpuCategoryNameSecond spuCategoryNameSecond;
  SpuCategoryNameThird spuCategoryNameThird;
  String spuCategoryNameFourth;
  int reviewScore;
  dynamic reviewNum;
  dynamic skuSaleNum;
  dynamic sortWeight;
  dynamic purchaseRate;
  String cornerText;
  String cornerBgUrl;
  int activityEndTimeStamp;
  String priceOffDesc;
  List<MergeSkuList> mergeSkuList;
  String mergeSkuDesc;
  String totalSkuNum;

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
        spuCode: spuCodeValues.map[json["spu_code"]],
        skuCode: skuCodeValues.map[json["sku_code"]],
        imgUrl: json["img_url"],
        jumpUrl: json["jump_url"],
        status: json["status"],
        activityStatus: json["activity_status"],
        statusDesc: statusDescValues.map[json["status_desc"]],
        spuCategoryNameFirst:
            spuCategoryNameFirstValues.map[json["spu_category_name_first"]],
        spuCategoryNameSecond:
            spuCategoryNameSecondValues.map[json["spu_category_name_second"]],
        spuCategoryNameThird:
            spuCategoryNameThirdValues.map[json["spu_category_name_third"]],
        spuCategoryNameFourth: json["spu_category_name_fourth"],
        reviewScore: json["review_score"],
        reviewNum: json["review_num"],
        skuSaleNum: json["sku_sale_num"],
        sortWeight: json["sort_weight"],
        purchaseRate: json["purchase_rate"],
        cornerText: json["corner_text"],
        cornerBgUrl: json["corner_bg_url"],
        activityEndTimeStamp: json["activity_end_time_stamp"],
        priceOffDesc: json["price_off_desc"],
        mergeSkuList: List<MergeSkuList>.from(
            json["merge_sku_list"]?.map((x) => MergeSkuList.fromJson(x))),
        mergeSkuDesc: json["merge_sku_desc"],
        totalSkuNum: json["total_sku_num"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "price_symbol": priceSymbol,
        "tag_price": tagPrice,
        "tag_price_symbol": tagPriceSymbol,
        "spu_id": spuId,
        "sku_id": skuId,
        "spu_code": spuCodeValues.reverse[spuCode],
        "sku_code": skuCodeValues.reverse[skuCode],
        "img_url": imgUrl,
        "jump_url": jumpUrl,
        "status": status,
        "activity_status": activityStatus,
        "status_desc": statusDescValues.reverse[statusDesc],
        "spu_category_name_first":
            spuCategoryNameFirstValues.reverse[spuCategoryNameFirst],
        "spu_category_name_second":
            spuCategoryNameSecondValues.reverse[spuCategoryNameSecond],
        "spu_category_name_third":
            spuCategoryNameThirdValues.reverse[spuCategoryNameThird],
        "spu_category_name_fourth": spuCategoryNameFourth,
        "review_score": reviewScore,
        "review_num": reviewNum,
        "sku_sale_num": skuSaleNum,
        "sort_weight": sortWeight,
        "purchase_rate": purchaseRate,
        "corner_text": cornerText,
        "corner_bg_url": cornerBgUrl,
        "activity_end_time_stamp": activityEndTimeStamp,
        "price_off_desc": priceOffDesc,
        "merge_sku_list":
            List<dynamic>.from(mergeSkuList.map((x) => x.toJson())),
        "merge_sku_desc": mergeSkuDesc,
        "total_sku_num": totalSkuNum,
      };
}

class MergeSkuList {
  MergeSkuList({
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
    this.activityEndTimeStamp,
    this.priceOffDesc,
    this.mergeSkuList,
    this.mergeSkuDesc,
  });

  String title;
  String price;
  String priceSymbol;
  dynamic tagPrice;
  String tagPriceSymbol;
  String spuId;
  String skuId;
  SpuCode spuCode;
  SkuCode skuCode;
  String imgUrl;
  String jumpUrl;
  int status;
  int activityStatus;
  StatusDesc statusDesc;
  SpuCategoryNameFirst spuCategoryNameFirst;
  SpuCategoryNameSecond spuCategoryNameSecond;
  SpuCategoryNameThird spuCategoryNameThird;
  String spuCategoryNameFourth;
  int reviewScore;
  dynamic reviewNum;
  dynamic skuSaleNum;
  dynamic sortWeight;
  dynamic purchaseRate;
  String cornerText;
  String cornerBgUrl;
  int activityEndTimeStamp;
  String priceOffDesc;
  List<dynamic> mergeSkuList;
  String mergeSkuDesc;

  factory MergeSkuList.fromRawJson(String str) =>
      MergeSkuList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MergeSkuList.fromJson(Map<String, dynamic> json) => MergeSkuList(
        title: json["title"],
        price: json["price"],
        priceSymbol: json["price_symbol"],
        tagPrice: json["tag_price"],
        tagPriceSymbol: json["tag_price_symbol"],
        spuId: json["spu_id"],
        skuId: json["sku_id"],
        spuCode: spuCodeValues.map[json["spu_code"]],
        skuCode: skuCodeValues.map[json["sku_code"]],
        imgUrl: json["img_url"],
        jumpUrl: json["jump_url"],
        status: json["status"],
        activityStatus: json["activity_status"],
        statusDesc: statusDescValues.map[json["status_desc"]],
        spuCategoryNameFirst:
            spuCategoryNameFirstValues.map[json["spu_category_name_first"]],
        spuCategoryNameSecond:
            spuCategoryNameSecondValues.map[json["spu_category_name_second"]],
        spuCategoryNameThird:
            spuCategoryNameThirdValues.map[json["spu_category_name_third"]],
        spuCategoryNameFourth: json["spu_category_name_fourth"],
        reviewScore: json["review_score"],
        reviewNum: json["review_num"],
        skuSaleNum: json["sku_sale_num"],
        sortWeight: json["sort_weight"],
        purchaseRate: json["purchase_rate"],
        cornerText: json["corner_text"],
        cornerBgUrl: json["corner_bg_url"],
        activityEndTimeStamp: json["activity_end_time_stamp"],
        priceOffDesc: json["price_off_desc"],
        mergeSkuList: List<dynamic>.from(json["merge_sku_list"].map((x) => x)),
        mergeSkuDesc: json["merge_sku_desc"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "price_symbol": priceSymbol,
        "tag_price": tagPrice,
        "tag_price_symbol": tagPriceSymbol,
        "spu_id": spuId,
        "sku_id": skuId,
        "spu_code": spuCodeValues.reverse[spuCode],
        "sku_code": skuCodeValues.reverse[skuCode],
        "img_url": imgUrl,
        "jump_url": jumpUrl,
        "status": status,
        "activity_status": activityStatus,
        "status_desc": statusDescValues.reverse[statusDesc],
        "spu_category_name_first":
            spuCategoryNameFirstValues.reverse[spuCategoryNameFirst],
        "spu_category_name_second":
            spuCategoryNameSecondValues.reverse[spuCategoryNameSecond],
        "spu_category_name_third":
            spuCategoryNameThirdValues.reverse[spuCategoryNameThird],
        "spu_category_name_fourth": spuCategoryNameFourth,
        "review_score": reviewScore,
        "review_num": reviewNum,
        "sku_sale_num": skuSaleNum,
        "sort_weight": sortWeight,
        "purchase_rate": purchaseRate,
        "corner_text": cornerText,
        "corner_bg_url": cornerBgUrl,
        "activity_end_time_stamp": activityEndTimeStamp,
        "price_off_desc": priceOffDesc,
        "merge_sku_list": List<dynamic>.from(mergeSkuList.map((x) => x)),
        "merge_sku_desc": mergeSkuDesc,
      };
}

enum SkuCode { J011005_1_V_BLACK_L, J011005_1_V_GRAY_M, J011005_1_V_WHITE_L }

final skuCodeValues = EnumValues({
  "J011005-1V-BLACK-L": SkuCode.J011005_1_V_BLACK_L,
  "J011005-1V-GRAY-M": SkuCode.J011005_1_V_GRAY_M,
  "J011005-1V-WHITE-L": SkuCode.J011005_1_V_WHITE_L
});

enum SpuCategoryNameSecond { CEILING_LIGHTS }

final spuCategoryNameSecondValues =
    EnumValues({"Ceiling Lights": SpuCategoryNameSecond.CEILING_LIGHTS});

enum SpuCategoryNameThird { FLUSH_MOUNT_LIGHTING }

final spuCategoryNameThirdValues = EnumValues(
    {"Flush Mount Lighting": SpuCategoryNameThird.FLUSH_MOUNT_LIGHTING});

enum SpuCode { J011005_1_V }

final spuCodeValues = EnumValues({"J011005-1V": SpuCode.J011005_1_V});

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
