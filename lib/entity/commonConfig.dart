// To parse this JSON data, do
//
//     final commonConfigRes = commonConfigResFromJson(jsonString);

import 'dart:convert';

class GlobalConfigRes {
  GlobalConfigRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory GlobalConfigRes.fromRawJson(String str) =>
      GlobalConfigRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlobalConfigRes.fromJson(Map<String, dynamic> json) =>
      GlobalConfigRes(
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
    this.currentConfig,
    this.siteList,
    this.languagesList,
    this.currencyList,
    this.commonAmountList,
  });

  CurrentConfig currentConfig;
  List<SiteList> siteList;
  List<LanguagesList> languagesList;
  List<CurrencyList> currencyList;
  CommonAmountList commonAmountList;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentConfig: json["current_config"] == null
            ? null
            : CurrentConfig.fromJson(json["current_config"]),
        siteList: json["site_list"] == null
            ? null
            : List<SiteList>.from(
                json["site_list"].map((x) => SiteList.fromJson(x))),
        languagesList: json["languages_list"] == null
            ? null
            : List<LanguagesList>.from(
                json["languages_list"].map((x) => LanguagesList.fromJson(x))),
        currencyList: json["currency_list"] == null
            ? null
            : List<CurrencyList>.from(
                json["currency_list"].map((x) => CurrencyList.fromJson(x))),
        commonAmountList: json["common_amount_list"] == null
            ? null
            : CommonAmountList.fromJson(json["common_amount_list"]),
      );

  Map<String, dynamic> toJson() => {
        "current_config": currentConfig == null ? null : currentConfig.toJson(),
        "site_list": siteList == null
            ? null
            : List<dynamic>.from(siteList.map((x) => x.toJson())),
        "languages_list": languagesList == null
            ? null
            : List<dynamic>.from(languagesList.map((x) => x.toJson())),
        "currency_list": currencyList == null
            ? null
            : List<dynamic>.from(currencyList.map((x) => x.toJson())),
        "common_amount_list":
            commonAmountList == null ? null : commonAmountList.toJson(),
      };
}

class CommonAmountList {
  CommonAmountList({
    this.couponSubscribeAmountStr,
    this.couponNewuserAmountStr,
  });

  String couponSubscribeAmountStr;
  String couponNewuserAmountStr;

  factory CommonAmountList.fromRawJson(String str) =>
      CommonAmountList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommonAmountList.fromJson(Map<String, dynamic> json) =>
      CommonAmountList(
        couponSubscribeAmountStr: json["coupon_subscribe_amount_str"] == null
            ? null
            : json["coupon_subscribe_amount_str"],
        couponNewuserAmountStr: json["coupon_newuser_amount_str"] == null
            ? null
            : json["coupon_newuser_amount_str"],
      );

  Map<String, dynamic> toJson() => {
        "coupon_subscribe_amount_str":
            couponSubscribeAmountStr == null ? null : couponSubscribeAmountStr,
        "coupon_newuser_amount_str":
            couponNewuserAmountStr == null ? null : couponNewuserAmountStr,
      };
}

class CurrencyList {
  CurrencyList({
    this.name,
    this.enName,
    this.code,
    this.symbol,
    this.account,
    this.decPoint,
    this.thousandsSep,
  });

  String name;
  String enName;
  String code;
  String symbol;
  String account;
  String decPoint;
  String thousandsSep;

  factory CurrencyList.fromRawJson(String str) =>
      CurrencyList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencyList.fromJson(Map<String, dynamic> json) => CurrencyList(
        name: json["name"] == null ? null : json["name"],
        enName: json["en_name"] == null ? null : json["en_name"],
        code: json["code"] == null ? null : json["code"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        account: json["account"] == null ? null : json["account"],
        decPoint: json["dec_point"] == null ? null : json["dec_point"],
        thousandsSep:
            json["thousands_sep"] == null ? null : json["thousands_sep"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "en_name": enName == null ? null : enName,
        "code": code == null ? null : code,
        "symbol": symbol == null ? null : symbol,
        "account": account == null ? null : account,
        "dec_point": decPoint == null ? null : decPoint,
        "thousands_sep": thousandsSep == null ? null : thousandsSep,
      };
}

class CurrentConfig {
  CurrentConfig({
    this.site,
    this.currencySymbol,
    this.currency,
    this.language,
    this.timeZoneCode,
  });

  String site;
  String currencySymbol;
  String currency;
  String language;
  String timeZoneCode;

  factory CurrentConfig.fromRawJson(String str) =>
      CurrentConfig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrentConfig.fromJson(Map<String, dynamic> json) => CurrentConfig(
        site: json["site"] == null ? null : json["site"],
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        currency: json["currency"] == null ? null : json["currency"],
        language: json["language"] == null ? null : json["language"],
        timeZoneCode:
            json["time_zone_code"] == null ? null : json["time_zone_code"],
      );

  Map<String, dynamic> toJson() => {
        "site": site == null ? null : site,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
        "currency": currency == null ? null : currency,
        "language": language == null ? null : language,
        "time_zone_code": timeZoneCode == null ? null : timeZoneCode,
      };
}

class LanguagesList {
  LanguagesList({
    this.name,
    this.code,
  });

  String name;
  String code;

  factory LanguagesList.fromRawJson(String str) =>
      LanguagesList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LanguagesList.fromJson(Map<String, dynamic> json) => LanguagesList(
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "code": code == null ? null : code,
      };
}

class SiteList {
  SiteList({
    this.siteName,
    this.siteCode,
    this.iconUrl,
    this.currencyCode,
    this.languageCode,
    this.jumpUrl,
    this.mJumpUrl,
  });

  String siteName;
  String siteCode;
  String iconUrl;
  String currencyCode;
  String languageCode;
  String jumpUrl;
  String mJumpUrl;

  factory SiteList.fromRawJson(String str) =>
      SiteList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SiteList.fromJson(Map<String, dynamic> json) => SiteList(
        siteName: json["site_name"] == null ? null : json["site_name"],
        siteCode: json["site_code"] == null ? null : json["site_code"],
        iconUrl: json["icon_url"] == null ? null : json["icon_url"],
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        languageCode:
            json["language_code"] == null ? null : json["language_code"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        mJumpUrl: json["m_jump_url"] == null ? null : json["m_jump_url"],
      );

  Map<String, dynamic> toJson() => {
        "site_name": siteName == null ? null : siteName,
        "site_code": siteCode == null ? null : siteCode,
        "icon_url": iconUrl == null ? null : iconUrl,
        "currency_code": currencyCode == null ? null : currencyCode,
        "language_code": languageCode == null ? null : languageCode,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "m_jump_url": mJumpUrl == null ? null : mJumpUrl,
      };
}
