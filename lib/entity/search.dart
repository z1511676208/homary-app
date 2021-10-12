/*
 * @Author       : zhhjie
 * @Date         : 2021-07-19 16:50:14
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-14 16:24:30
 */
// To parse this JSON data, do
//
//     final hotKeywordRes = hotKeywordResFromJson(jsonString);

import 'dart:convert';

class HotKeywordRes {
  HotKeywordRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory HotKeywordRes.fromRawJson(String str) =>
      HotKeywordRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotKeywordRes.fromJson(Map<String, dynamic> json) => HotKeywordRes(
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
    this.hotKeywords,
    this.channelList,
  });

  List<HotKeyword> hotKeywords;
  List<ChannelList> channelList;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hotKeywords: json["hot_keywords"] == null
            ? null
            : List<HotKeyword>.from(
                json["hot_keywords"].map((x) => HotKeyword.fromJson(x))),
        channelList: json["channel_list"] == null
            ? null
            : List<ChannelList>.from(
                json["channel_list"].map((x) => ChannelList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hot_keywords": hotKeywords == null
            ? null
            : List<dynamic>.from(hotKeywords.map((x) => x.toJson())),
        "channel_list": channelList == null
            ? null
            : List<dynamic>.from(channelList.map((x) => x.toJson())),
      };
}

class ChannelList {
  ChannelList({
    this.channelId,
    this.channelName,
    this.channelUrl,
  });

  String channelId;
  String channelName;
  String channelUrl;

  factory ChannelList.fromRawJson(String str) =>
      ChannelList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChannelList.fromJson(Map<String, dynamic> json) => ChannelList(
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

class HotKeyword {
  HotKeyword({
    this.sort,
    this.hotWord,
    this.type,
    this.activityUrl,
    this.eventLabel,
  });

  String sort;
  String hotWord;
  String type;
  String eventLabel;
  String activityUrl;

  factory HotKeyword.fromRawJson(String str) =>
      HotKeyword.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotKeyword.fromJson(Map<String, dynamic> json) => HotKeyword(
        sort: json["sort"] == null ? null : json["sort"],
        hotWord: json["hot_word"] == null ? null : json["hot_word"],
        type: json["type"] == null ? null : json["type"],
        activityUrl: json["activity_url"] == null ? null : json["activity_url"],
        eventLabel: json["event_label"] == null ? null : json["event_label"],
      );

  Map<String, dynamic> toJson() => {
        "sort": sort == null ? null : sort,
        "hot_word": hotWord == null ? null : hotWord,
        "type": type == null ? null : type,
        "activity_url": activityUrl == null ? null : activityUrl,
        "event_label": eventLabel == null ? null : eventLabel,
      };
}
