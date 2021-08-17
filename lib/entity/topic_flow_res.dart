// To parse this JSON data, do
//
//     final topicFlowRes = topicFlowResFromJson(jsonString);

import 'dart:convert';

import 'package:homary/entity/home.dart';

class TopicFlowRes {
  TopicFlowRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory TopicFlowRes.fromRawJson(String str) => TopicFlowRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopicFlowRes.fromJson(Map<String, dynamic> json) => TopicFlowRes(
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
    this.activityInfo,
    this.activityProduct,
    this.channelInfo,
    this.channelList,
    this.total,
    this.hasMorePage,
    this.totalPage,
  });

  ActivityInfo activityInfo;
  List<ModuleDataProductList> activityProduct;
  List<ChannelInfo> channelInfo;
  List<ChannelList> channelList;
  int total;
  int hasMorePage;
  int totalPage;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    activityInfo: json["activity_info"] == null ? null : ActivityInfo.fromJson(json["activity_info"]),
    activityProduct: json["activity_product"] == null ? null : List<ModuleDataProductList>.from(json["activity_product"].map((x) => ModuleDataProductList.fromJson(x))),
    channelInfo: json["channel_info"] == null ? null : List<ChannelInfo>.from(json["channel_info"].map((x) => ChannelInfo.fromJson(x))),
    channelList: json["channel_list"] == null ? null : List<ChannelList>.from(json["channel_list"].map((x) => ChannelList.fromJson(x))),
    total: json["total"] == null ? null : json["total"],
    hasMorePage: json["has_more_page"] == null ? null : json["has_more_page"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
  );

  Map<String, dynamic> toJson() => {
    "activity_info": activityInfo == null ? null : activityInfo.toJson(),
    "activity_product": activityProduct == null ? null : List<dynamic>.from(activityProduct.map((x) => x.toJson())),
    "channel_info": channelInfo == null ? null : List<dynamic>.from(channelInfo.map((x) => x.toJson())),
    "channel_list": channelList == null ? null : List<dynamic>.from(channelList.map((x) => x.toJson())),
    "total": total == null ? null : total,
    "has_more_page": hasMorePage == null ? null : hasMorePage,
    "total_page": totalPage == null ? null : totalPage,
  };
}

class ActivityInfo {
  ActivityInfo({
    this.title,
    this.imgUrl,
    this.bgColor,
    this.status,
    this.seoTitle,
    this.seoKeyword,
    this.seoDescription,
  });

  String title;
  String imgUrl;
  String bgColor;
  String status;
  String seoTitle;
  String seoKeyword;
  String seoDescription;

  factory ActivityInfo.fromRawJson(String str) => ActivityInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityInfo.fromJson(Map<String, dynamic> json) => ActivityInfo(
    title: json["title"] == null ? null : json["title"],
    imgUrl: json["img_url"] == null ? null : json["img_url"],
    bgColor: json["bg_color"] == null ? null : json["bg_color"],
    status: json["status"] == null ? null : json["status"],
    seoTitle: json["seo_title"] == null ? null : json["seo_title"],
    seoKeyword: json["seo_keyword"] == null ? null : json["seo_keyword"],
    seoDescription: json["seo_description"] == null ? null : json["seo_description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "img_url": imgUrl == null ? null : imgUrl,
    "bg_color": bgColor == null ? null : bgColor,
    "status": status == null ? null : status,
    "seo_title": seoTitle == null ? null : seoTitle,
    "seo_keyword": seoKeyword == null ? null : seoKeyword,
    "seo_description": seoDescription == null ? null : seoDescription,
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
    channelId: json["channel_id"] == null ? null : json["channel_id"],
    jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
  );

  Map<String, dynamic> toJson() => {
    "channel_name": channelName == null ? null : channelName,
    "channel_id": channelId == null ? null : channelId,
    "jump_url": jumpUrl == null ? null : jumpUrl,
  };
}

class ChannelList {
  ChannelList({
    this.channelName,
    this.channelId,
    this.sort,
    this.imgUrl,
    this.isSelected,
  });

  String channelName;
  String channelId;
  String sort;
  String imgUrl;
  int isSelected;

  factory ChannelList.fromRawJson(String str) => ChannelList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChannelList.fromJson(Map<String, dynamic> json) => ChannelList(
    channelName: json["channel_name"] == null ? null : json["channel_name"],
    channelId: json["channel_id"] == null ? null : json["channel_id"],
    sort: json["sort"] == null ? null : json["sort"],
    imgUrl: json["img_url"] == null ? null : json["img_url"],
    isSelected: json["is_selected"] == null ? null : json["is_selected"],
  );

  Map<String, dynamic> toJson() => {
    "channel_name": channelName == null ? null : channelName,
    "channel_id": channelId == null ? null : channelId,
    "sort": sort == null ? null : sort,
    "img_url": imgUrl == null ? null : imgUrl,
    "is_selected": isSelected == null ? null : isSelected,
  };
}
