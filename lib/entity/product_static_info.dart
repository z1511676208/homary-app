// To parse this JSON data, do
//
//     final productStaticInfoRes = productStaticInfoResFromJson(jsonString);

import 'dart:convert';

class ProductStaticInfoRes {
  ProductStaticInfoRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  ProductStaticInfoResData data;
  String message;

  factory ProductStaticInfoRes.fromRawJson(String str) => ProductStaticInfoRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductStaticInfoRes.fromJson(Map<String, dynamic> json) => ProductStaticInfoRes(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : ProductStaticInfoResData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data.toJson(),
    "message": message == null ? null : message,
  };
}

class ProductStaticInfoResData {
  ProductStaticInfoResData({
    this.skuCode,
    this.spuCode,
    this.oldProductId,
    this.productCommentUniqKey,
    this.details,
    this.files,
    this.description,
    this.standard,
    this.spuCategoryIdFirst,
    this.spuCategoryIdSecond,
    this.spuCategoryIdThird,
    this.spuCategoryIdFourth,
    this.descriptionImgs,
    this.shippingReturns,
    this.qa,
    this.ratingValue,
    this.reviewCount,
    this.aggregateRating,
    this.productOverview,
    this.weightDimension,
    this.additionalDocument,
    this.termsOfService,
    this.faqCount,
  });

  String skuCode;
  String spuCode;
  String oldProductId;
  String productCommentUniqKey;
  List<Detail> details;
  List<FileElement> files;
  String description;
  List<dynamic> standard;
  String spuCategoryIdFirst;
  String spuCategoryIdSecond;
  String spuCategoryIdThird;
  String spuCategoryIdFourth;
  List<String> descriptionImgs;
  ShippingReturns shippingReturns;
  List<Qa> qa;
  String ratingValue;
  dynamic reviewCount;
  AggregateRating aggregateRating;
  List<Detail> productOverview;
  WeightDimension weightDimension;
  AdditionalDocument additionalDocument;
  List<TermsOfService> termsOfService;
  int faqCount;

  factory ProductStaticInfoResData.fromRawJson(String str) => ProductStaticInfoResData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductStaticInfoResData.fromJson(Map<String, dynamic> json) => ProductStaticInfoResData(
    skuCode: json["sku_code"] == null ? null : json["sku_code"],
    spuCode: json["spu_code"] == null ? null : json["spu_code"],
    oldProductId: json["old_product_id"] == null ? null : json["old_product_id"],
    productCommentUniqKey: json["product_comment_uniq_key"] == null ? null : json["product_comment_uniq_key"],
    details: json["details"] == null ? null : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    description: json["description"] == null ? null : json["description"],
    standard: json["standard"] == null ? null : List<dynamic>.from(json["standard"].map((x) => x)),
    spuCategoryIdFirst: json["spu_category_id_first"] == null ? null : json["spu_category_id_first"],
    spuCategoryIdSecond: json["spu_category_id_second"] == null ? null : json["spu_category_id_second"],
    spuCategoryIdThird: json["spu_category_id_third"] == null ? null : json["spu_category_id_third"],
    spuCategoryIdFourth: json["spu_category_id_fourth"] == null ? null : json["spu_category_id_fourth"],
    descriptionImgs: json["description_imgs"] == null ? null : List<String>.from(json["description_imgs"].map((x) => x)),
    shippingReturns: json["shipping_returns"] == null ? null : ShippingReturns.fromJson(json["shipping_returns"]),
    qa: json["qa"] == null ? null : List<Qa>.from(json["qa"].map((x) => Qa.fromJson(x))),
    ratingValue: json["ratingValue"] == null ? null : json["ratingValue"],
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
    aggregateRating: json["aggregateRating"] == null ? null : AggregateRating.fromJson(json["aggregateRating"]),
    productOverview: json["product_overview"] == null ? null : List<Detail>.from(json["product_overview"].map((x) => Detail.fromJson(x))),
    weightDimension: json["weight_dimension"] == null ? null : WeightDimension.fromJson(json["weight_dimension"]),
    additionalDocument: json["additional_document"] == null ? null : AdditionalDocument.fromJson(json["additional_document"]),
    termsOfService: json["terms_of_service"] == null ? null : List<TermsOfService>.from(json["terms_of_service"].map((x) => TermsOfService.fromJson(x))),
    faqCount: json["faq_count"] == null ? null : json["faq_count"],
  );

  Map<String, dynamic> toJson() => {
    "sku_code": skuCode == null ? null : skuCode,
    "spu_code": spuCode == null ? null : spuCode,
    "old_product_id": oldProductId == null ? null : oldProductId,
    "product_comment_uniq_key": productCommentUniqKey == null ? null : productCommentUniqKey,
    "details": details == null ? null : List<dynamic>.from(details.map((x) => x.toJson())),
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
    "description": description == null ? null : description,
    "standard": standard == null ? null : List<dynamic>.from(standard.map((x) => x)),
    "spu_category_id_first": spuCategoryIdFirst == null ? null : spuCategoryIdFirst,
    "spu_category_id_second": spuCategoryIdSecond == null ? null : spuCategoryIdSecond,
    "spu_category_id_third": spuCategoryIdThird == null ? null : spuCategoryIdThird,
    "spu_category_id_fourth": spuCategoryIdFourth == null ? null : spuCategoryIdFourth,
    "description_imgs": descriptionImgs == null ? null : List<dynamic>.from(descriptionImgs.map((x) => x)),
    "shipping_returns": shippingReturns == null ? null : shippingReturns.toJson(),
    "qa": qa == null ? null : List<dynamic>.from(qa.map((x) => x.toJson())),
    "ratingValue": ratingValue == null ? null : ratingValue,
    "reviewCount": reviewCount == null ? null : reviewCount,
    "aggregateRating": aggregateRating == null ? null : aggregateRating.toJson(),
    "product_overview": productOverview == null ? null : List<dynamic>.from(productOverview.map((x) => x.toJson())),
    "weight_dimension": weightDimension == null ? null : weightDimension.toJson(),
    "additional_document": additionalDocument == null ? null : additionalDocument.toJson(),
    "terms_of_service": termsOfService == null ? null : List<dynamic>.from(termsOfService.map((x) => x.toJson())),
    "faq_count": faqCount == null ? null : faqCount,
  };
}

class AdditionalDocument {
  AdditionalDocument({
    this.files,
    this.videoUrl,
  });

  List<FileElement> files;
  String videoUrl;

  factory AdditionalDocument.fromRawJson(String str) => AdditionalDocument.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalDocument.fromJson(Map<String, dynamic> json) => AdditionalDocument(
    files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    videoUrl: json["video_url"] == null ? null : json["video_url"],
  );

  Map<String, dynamic> toJson() => {
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
    "video_url": videoUrl == null ? null : videoUrl,
  };
}

class FileElement {
  FileElement({
    this.name,
    this.nameResourceId,
    this.url,
  });

  String name;
  dynamic nameResourceId;
  String url;

  factory FileElement.fromRawJson(String str) => FileElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    name: json["name"] == null ? null : json["name"],
    nameResourceId: json["name_resource_id"] == null ? null : json["name_resource_id"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "name_resource_id": nameResourceId == null ? null : nameResourceId,
    "url": url == null ? null : url,
  };
}

class AggregateRating {
  AggregateRating({
    this.type,
    this.ratingValue,
    this.reviewCount,
  });

  String type;
  String ratingValue;
  dynamic reviewCount;

  factory AggregateRating.fromRawJson(String str) => AggregateRating.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AggregateRating.fromJson(Map<String, dynamic> json) => AggregateRating(
    type: json["@type"] == null ? null : json["@type"],
    ratingValue: json["ratingValue"] == null ? null : json["ratingValue"],
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type == null ? null : type,
    "ratingValue": ratingValue == null ? null : ratingValue,
    "reviewCount": reviewCount == null ? null : reviewCount,
  };
}

class Detail {
  Detail({
    this.key,
    this.value,
    this.sort,
    this.overviewImg,
  });

  String key;
  String value;
  String sort;
  String overviewImg;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    key: json["key"] == null ? null : json["key"],
    value: json["value"] == null ? null : json["value"],
    sort: json["sort"] == null ? null : json["sort"],
    overviewImg: json["overview_img"] == null ? null : json["overview_img"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value == null ? null : value,
    "sort": sort == null ? null : sort,
    "overview_img": overviewImg == null ? null : overviewImg,
  };
}

class Qa {
  Qa({
    this.q,
    this.a,
  });

  String q;
  String a;

  factory Qa.fromRawJson(String str) => Qa.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Qa.fromJson(Map<String, dynamic> json) => Qa(
    q: json["q"] == null ? null : json["q"],
    a: json["a"] == null ? null : json["a"],
  );

  Map<String, dynamic> toJson() => {
    "q": q == null ? null : q,
    "a": a == null ? null : a,
  };
}

class ShippingReturns {
  ShippingReturns({
    this.title,
    this.desc,
    this.siteUrlList,
    this.policyList,
  });

  Title title;
  String desc;
  List<SiteUrlList> siteUrlList;
  List<PolicyList> policyList;

  factory ShippingReturns.fromRawJson(String str) => ShippingReturns.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingReturns.fromJson(Map<String, dynamic> json) => ShippingReturns(
    title: json["title"] == null ? null : Title.fromJson(json["title"]),
    desc: json["desc"] == null ? null : json["desc"],
    siteUrlList: json["site_url_list"] == null ? null : List<SiteUrlList>.from(json["site_url_list"].map((x) => SiteUrlList.fromJson(x))),
    policyList: json["policy_list"] == null ? null : List<PolicyList>.from(json["policy_list"].map((x) => PolicyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title.toJson(),
    "desc": desc == null ? null : desc,
    "site_url_list": siteUrlList == null ? null : List<dynamic>.from(siteUrlList.map((x) => x.toJson())),
    "policy_list": policyList == null ? null : List<dynamic>.from(policyList.map((x) => x.toJson())),
  };
}

class PolicyList {
  PolicyList({
    this.desc,
    this.jumpUrl,
  });

  String desc;
  String jumpUrl;

  factory PolicyList.fromRawJson(String str) => PolicyList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyList.fromJson(Map<String, dynamic> json) => PolicyList(
    desc: json["desc"] == null ? null : json["desc"],
    jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc == null ? null : desc,
    "jump_url": jumpUrl == null ? null : jumpUrl,
  };
}

class SiteUrlList {
  SiteUrlList({
    this.siteName,
    this.siteHost,
  });

  String siteName;
  String siteHost;

  factory SiteUrlList.fromRawJson(String str) => SiteUrlList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SiteUrlList.fromJson(Map<String, dynamic> json) => SiteUrlList(
    siteName: json["site_name"] == null ? null : json["site_name"],
    siteHost: json["site_host"] == null ? null : json["site_host"],
  );

  Map<String, dynamic> toJson() => {
    "site_name": siteName == null ? null : siteName,
    "site_host": siteHost == null ? null : siteHost,
  };
}

class Title {
  Title({
    this.highLight,
    this.highLightColor,
    this.text,
  });

  String highLight;
  String highLightColor;
  String text;

  factory Title.fromRawJson(String str) => Title.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    highLight: json["high_light"] == null ? null : json["high_light"],
    highLightColor: json["high_light_color"] == null ? null : json["high_light_color"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "high_light": highLight == null ? null : highLight,
    "high_light_color": highLightColor == null ? null : highLightColor,
    "text": text == null ? null : text,
  };
}

class TermsOfService {
  TermsOfService({
    this.key,
    this.title,
    this.subTitle,
    this.icon,
    this.type,
    this.sort,
  });

  String key;
  String title;
  String subTitle;
  String icon;
  String type;
  String sort;

  factory TermsOfService.fromRawJson(String str) => TermsOfService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsOfService.fromJson(Map<String, dynamic> json) => TermsOfService(
    key: json["key"] == null ? null : json["key"],
    title: json["title"] == null ? null : json["title"],
    subTitle: json["sub_title"] == null ? null : json["sub_title"],
    icon: json["icon"] == null ? null : json["icon"],
    type: json["type"] == null ? null : json["type"],
    sort: json["sort"] == null ? null : json["sort"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "title": title == null ? null : title,
    "sub_title": subTitle == null ? null : subTitle,
    "icon": icon == null ? null : icon,
    "type": type == null ? null : type,
    "sort": sort == null ? null : sort,
  };
}

class WeightDimension {
  WeightDimension({
    this.dimensionImg,
    this.dimensionAttr,
  });

  List<dynamic> dimensionImg;
  List<Detail> dimensionAttr;

  factory WeightDimension.fromRawJson(String str) => WeightDimension.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeightDimension.fromJson(Map<String, dynamic> json) => WeightDimension(
    dimensionImg: json["dimension_img"] == null ? null : List<dynamic>.from(json["dimension_img"].map((x) => x)),
    dimensionAttr: json["dimension_attr"] == null ? null : List<Detail>.from(json["dimension_attr"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dimension_img": dimensionImg == null ? null : List<dynamic>.from(dimensionImg.map((x) => x)),
    "dimension_attr": dimensionAttr == null ? null : List<dynamic>.from(dimensionAttr.map((x) => x.toJson())),
  };
}
