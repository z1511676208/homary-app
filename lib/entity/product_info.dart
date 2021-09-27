// To parse this JSON data, do
//
//     final productInfoRes = productInfoResFromJson(jsonString);

import 'dart:convert';

class ProductInfoRes {
  ProductInfoRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  ProductInfoResData data;
  String message;

  factory ProductInfoRes.fromRawJson(String str) => ProductInfoRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductInfoRes.fromJson(Map<String, dynamic> json) => ProductInfoRes(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : ProductInfoResData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data.toJson(),
    "message": message == null ? null : message,
  };
}

class ProductInfoResData {
  ProductInfoResData({
    this.spuId,
    this.skuId,
    this.title,
    this.oldProductId,
    this.productCommentUniqKey,
    this.sellingPoint,
    this.spuCode,
    this.skuCode,
    this.productImg,
    this.realProductImg,
    this.highlightImg,
    this.dimensionImg,
    this.productMainImg,
    this.video,
    this.price,
    this.priceSymbol,
    this.normalPrice,
    this.normalPriceSymbol,
    this.tagPrice,
    this.tagPriceSymbol,
    this.saleStatus,
    this.status,
    this.statusDesc,
    this.activityId,
    this.activityPrice,
    this.activityType,
    this.activityPriceSymbol,
    this.activityStartTime,
    this.activityEndTime,
    this.activityEndTimeStamp,
    this.activityStartTimeStamp,
    this.activityCountdown,
    this.activityStock,
    this.clearanceText,
    this.deliveryTime,
    this.deliveryTimeStr,
    this.isShowAffirmPay,
    this.seoTitle,
    this.seoKeyword,
    this.seoDescription,
    this.priceOffDesc,
    this.channelInfo,
    this.metaInfo,
    this.ga,
  });

  String spuId;
  String skuId;
  String title;
  String oldProductId;
  String productCommentUniqKey;
  List<dynamic> sellingPoint;
  String spuCode;
  String skuCode;
  List<String> productImg;
  List<String> realProductImg;
  List<dynamic> highlightImg;
  List<dynamic> dimensionImg;
  String productMainImg;
  String video;
  String price;
  String priceSymbol;
  String normalPrice;
  String normalPriceSymbol;
  dynamic tagPrice;
  String tagPriceSymbol;
  int saleStatus;
  int status;
  String statusDesc;
  dynamic activityId;
  dynamic activityPrice;
  dynamic activityType;
  dynamic activityPriceSymbol;
  dynamic activityStartTime;
  dynamic activityEndTime;
  int activityEndTimeStamp;
  int activityStartTimeStamp;
  int activityCountdown;
  dynamic activityStock;
  String clearanceText;
  String deliveryTime;
  String deliveryTimeStr;
  int isShowAffirmPay;
  String seoTitle;
  String seoKeyword;
  String seoDescription;
  String priceOffDesc;
  List<ChannelInfo> channelInfo;
  MetaInfo metaInfo;
  Ga ga;

  factory ProductInfoResData.fromRawJson(String str) => ProductInfoResData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductInfoResData.fromJson(Map<String, dynamic> json) => ProductInfoResData(
    spuId: json["spu_id"] == null ? null : json["spu_id"],
    skuId: json["sku_id"] == null ? null : json["sku_id"],
    title: json["title"] == null ? null : json["title"],
    oldProductId: json["old_product_id"] == null ? null : json["old_product_id"],
    productCommentUniqKey: json["product_comment_uniq_key"] == null ? null : json["product_comment_uniq_key"],
    sellingPoint: json["selling_point"] == null ? null : List<dynamic>.from(json["selling_point"].map((x) => x)),
    spuCode: json["spu_code"] == null ? null : json["spu_code"],
    skuCode: json["sku_code"] == null ? null : json["sku_code"],
    productImg: json["product_img"] == null ? null : List<String>.from(json["product_img"].map((x) => x)),
    realProductImg: json["real_product_img"] == null ? null : List<String>.from(json["real_product_img"].map((x) => x)),
    highlightImg: json["highlight_img"] == null ? null : List<dynamic>.from(json["highlight_img"].map((x) => x)),
    dimensionImg: json["dimension_img"] == null ? null : List<dynamic>.from(json["dimension_img"].map((x) => x)),
    productMainImg: json["product_main_img"] == null ? null : json["product_main_img"],
    video: json["video"] == null ? null : json["video"],
    price: json["price"] == null ? null : json["price"],
    priceSymbol: json["price_symbol"] == null ? null : json["price_symbol"],
    normalPrice: json["normal_price"] == null ? null : json["normal_price"],
    normalPriceSymbol: json["normal_price_symbol"] == null ? null : json["normal_price_symbol"],
    tagPrice: json["tag_price"] == null ? null : json["tag_price"],
    tagPriceSymbol: json["tag_price_symbol"] == null ? null : json["tag_price_symbol"],
    saleStatus: json["sale_status"] == null ? null : json["sale_status"],
    status: json["status"] == null ? null : json["status"],
    statusDesc: json["status_desc"] == null ? null : json["status_desc"],
    activityId: json["activity_id"] == null ? null : json["activity_id"],
    activityPrice: json["activity_price"] == null ? null : json["activity_price"],
    activityType: json["activity_type"] == null ? null : json["activity_type"],
    activityPriceSymbol: json["activity_price_symbol"] == null ? null : json["activity_price_symbol"],
    activityStartTime: json["activity_start_time"] == null ? null : json["activity_start_time"],
    activityEndTime: json["activity_end_time"] == null ? null : json["activity_end_time"],
    activityEndTimeStamp: json["activity_end_time_stamp"] == null ? null : json["activity_end_time_stamp"],
    activityStartTimeStamp: json["activity_start_time_stamp"] == null ? null : json["activity_start_time_stamp"],
    activityCountdown: json["activity_countdown"] == null ? null : json["activity_countdown"],
    activityStock: json["activity_stock"] == null ? null : json["activity_stock"],
    clearanceText: json["clearance_text"] == null ? null : json["clearance_text"],
    deliveryTime: json["delivery_time"] == null ? null : json["delivery_time"],
    deliveryTimeStr: json["delivery_time_str"] == null ? null : json["delivery_time_str"],
    isShowAffirmPay: json["is_show_affirm_pay"] == null ? null : json["is_show_affirm_pay"],
    seoTitle: json["seo_title"] == null ? null : json["seo_title"],
    seoKeyword: json["seo_keyword"] == null ? null : json["seo_keyword"],
    seoDescription: json["seo_description"] == null ? null : json["seo_description"],
    priceOffDesc: json["price_off_desc"] == null ? null : json["price_off_desc"],
    channelInfo: json["channel_info"] == null ? null : List<ChannelInfo>.from(json["channel_info"].map((x) => ChannelInfo.fromJson(x))),
    metaInfo: json["meta_info"] == null ? null : MetaInfo.fromJson(json["meta_info"]),
    ga: json["__ga"] == null ? null : Ga.fromJson(json["__ga"]),
  );

  Map<String, dynamic> toJson() => {
    "spu_id": spuId == null ? null : spuId,
    "sku_id": skuId == null ? null : skuId,
    "title": title == null ? null : title,
    "old_product_id": oldProductId == null ? null : oldProductId,
    "product_comment_uniq_key": productCommentUniqKey == null ? null : productCommentUniqKey,
    "selling_point": sellingPoint == null ? null : List<dynamic>.from(sellingPoint.map((x) => x)),
    "spu_code": spuCode == null ? null : spuCode,
    "sku_code": skuCode == null ? null : skuCode,
    "product_img": productImg == null ? null : List<dynamic>.from(productImg.map((x) => x)),
    "real_product_img": realProductImg == null ? null : List<dynamic>.from(realProductImg.map((x) => x)),
    "highlight_img": highlightImg == null ? null : List<dynamic>.from(highlightImg.map((x) => x)),
    "dimension_img": dimensionImg == null ? null : List<dynamic>.from(dimensionImg.map((x) => x)),
    "product_main_img": productMainImg == null ? null : productMainImg,
    "video": video == null ? null : video,
    "price": price == null ? null : price,
    "price_symbol": priceSymbol == null ? null : priceSymbol,
    "normal_price": normalPrice == null ? null : normalPrice,
    "normal_price_symbol": normalPriceSymbol == null ? null : normalPriceSymbol,
    "tag_price": tagPrice == null ? null : tagPrice,
    "tag_price_symbol": tagPriceSymbol == null ? null : tagPriceSymbol,
    "sale_status": saleStatus == null ? null : saleStatus,
    "status": status == null ? null : status,
    "status_desc": statusDesc == null ? null : statusDesc,
    "activity_id": activityId == null ? null : activityId,
    "activity_price": activityPrice == null ? null : activityPrice,
    "activity_type": activityType == null ? null : activityType,
    "activity_price_symbol": activityPriceSymbol == null ? null : activityPriceSymbol,
    "activity_start_time": activityStartTime == null ? null : activityStartTime,
    "activity_end_time": activityEndTime == null ? null : activityEndTime,
    "activity_end_time_stamp": activityEndTimeStamp == null ? null : activityEndTimeStamp,
    "activity_start_time_stamp": activityStartTimeStamp == null ? null : activityStartTimeStamp,
    "activity_countdown": activityCountdown == null ? null : activityCountdown,
    "activity_stock": activityStock == null ? null : activityStock,
    "clearance_text": clearanceText == null ? null : clearanceText,
    "delivery_time": deliveryTime == null ? null : deliveryTime,
    "delivery_time_str": deliveryTimeStr == null ? null : deliveryTimeStr,
    "is_show_affirm_pay": isShowAffirmPay == null ? null : isShowAffirmPay,
    "seo_title": seoTitle == null ? null : seoTitle,
    "seo_keyword": seoKeyword == null ? null : seoKeyword,
    "seo_description": seoDescription == null ? null : seoDescription,
    "price_off_desc": priceOffDesc == null ? null : priceOffDesc,
    "channel_info": channelInfo == null ? null : List<dynamic>.from(channelInfo.map((x) => x.toJson())),
    "meta_info": metaInfo == null ? null : metaInfo.toJson(),
    "__ga": ga == null ? null : ga.toJson(),
  };
}

class ChannelInfo {
  ChannelInfo({
    this.channelName,
    this.channelId,
    this.jumpUrl,
  });

  String channelName;
  dynamic channelId;
  String jumpUrl;

  factory ChannelInfo.fromRawJson(String str) => ChannelInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChannelInfo.fromJson(Map<String, dynamic> json) => ChannelInfo(
    channelName: json["channel_name"] == null ? null : json["channel_name"],
    channelId: json["channel_id"],
    jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
  );

  Map<String, dynamic> toJson() => {
    "channel_name": channelName == null ? null : channelName,
    "channel_id": channelId,
    "jump_url": jumpUrl == null ? null : jumpUrl,
  };
}

class Ga {
  Ga({
    this.event,
    this.data,
    this.isAutoSend,
  });

  String event;
  GaData data;
  bool isAutoSend;

  factory Ga.fromRawJson(String str) => Ga.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ga.fromJson(Map<String, dynamic> json) => Ga(
    event: json["event"] == null ? null : json["event"],
    data: json["data"] == null ? null : GaData.fromJson(json["data"]),
    isAutoSend: json["is_auto_send"] == null ? null : json["is_auto_send"],
  );

  Map<String, dynamic> toJson() => {
    "event": event == null ? null : event,
    "data": data == null ? null : data.toJson(),
    "is_auto_send": isAutoSend == null ? null : isAutoSend,
  };
}

class GaData {
  GaData({
    this.items,
    this.value,
    this.eventLabel,
    this.currency,
  });

  List<Item> items;
  String value;
  String eventLabel;
  String currency;

  factory GaData.fromRawJson(String str) => GaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GaData.fromJson(Map<String, dynamic> json) => GaData(
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    value: json["value"] == null ? null : json["value"],
    eventLabel: json["event_label"] == null ? null : json["event_label"],
    currency: json["currency"] == null ? null : json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    "value": value == null ? null : value,
    "event_label": eventLabel == null ? null : eventLabel,
    "currency": currency == null ? null : currency,
  };
}

class Item {
  Item({
    this.itemId,
    this.itemName,
    this.promotionId,
    this.promotionName,
    this.itemBrand,
    this.itemCategory,
    this.itemCategory2,
    this.itemCategory3,
    this.itemCategory4,
    this.itemVariant,
    this.price,
    this.currency,
    this.jumpUrl,
    this.imgUrl,
    this.eventLabel,
    this.googleBusinessVertical,
  });

  String itemId;
  String itemName;
  String promotionId;
  String promotionName;
  String itemBrand;
  String itemCategory;
  String itemCategory2;
  String itemCategory3;
  String itemCategory4;
  String itemVariant;
  String price;
  String currency;
  String jumpUrl;
  String imgUrl;
  String eventLabel;
  String googleBusinessVertical;

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"] == null ? null : json["item_id"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    promotionId: json["promotion_id"] == null ? null : json["promotion_id"],
    promotionName: json["promotion_name"] == null ? null : json["promotion_name"],
    itemBrand: json["item_brand"] == null ? null : json["item_brand"],
    itemCategory: json["item_category"] == null ? null : json["item_category"],
    itemCategory2: json["item_category2"] == null ? null : json["item_category2"],
    itemCategory3: json["item_category3"] == null ? null : json["item_category3"],
    itemCategory4: json["item_category4"] == null ? null : json["item_category4"],
    itemVariant: json["item_variant"] == null ? null : json["item_variant"],
    price: json["price"] == null ? null : json["price"],
    currency: json["currency"] == null ? null : json["currency"],
    jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
    imgUrl: json["img_url"] == null ? null : json["img_url"],
    eventLabel: json["event_label"] == null ? null : json["event_label"],
    googleBusinessVertical: json["google_business_vertical"] == null ? null : json["google_business_vertical"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId == null ? null : itemId,
    "item_name": itemName == null ? null : itemName,
    "promotion_id": promotionId == null ? null : promotionId,
    "promotion_name": promotionName == null ? null : promotionName,
    "item_brand": itemBrand == null ? null : itemBrand,
    "item_category": itemCategory == null ? null : itemCategory,
    "item_category2": itemCategory2 == null ? null : itemCategory2,
    "item_category3": itemCategory3 == null ? null : itemCategory3,
    "item_category4": itemCategory4 == null ? null : itemCategory4,
    "item_variant": itemVariant == null ? null : itemVariant,
    "price": price == null ? null : price,
    "currency": currency == null ? null : currency,
    "jump_url": jumpUrl == null ? null : jumpUrl,
    "img_url": imgUrl == null ? null : imgUrl,
    "event_label": eventLabel == null ? null : eventLabel,
    "google_business_vertical": googleBusinessVertical == null ? null : googleBusinessVertical,
  };
}

class MetaInfo {
  MetaInfo({
    this.entireJumpUrl,
  });

  String entireJumpUrl;

  factory MetaInfo.fromRawJson(String str) => MetaInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaInfo.fromJson(Map<String, dynamic> json) => MetaInfo(
    entireJumpUrl: json["entire_jump_url"] == null ? null : json["entire_jump_url"],
  );

  Map<String, dynamic> toJson() => {
    "entire_jump_url": entireJumpUrl == null ? null : entireJumpUrl,
  };
}
