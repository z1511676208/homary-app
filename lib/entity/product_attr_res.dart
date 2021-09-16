// To parse this JSON data, do
//
//     final productAttrRes = productAttrResFromJson(jsonString);

import 'dart:convert';

class ProductAttrRes {
  ProductAttrRes({
    this.code,
    this.data,
  });

  int code;
  ProductAttrData data;

  factory ProductAttrRes.fromRawJson(String str) =>
      ProductAttrRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttrRes.fromJson(Map<String, dynamic> json) => ProductAttrRes(
        code: json["code"],
        data: ProductAttrData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
      };
}

class ProductAttrData {
  ProductAttrData({
    this.main,
    this.orderBy,
  });

  List<ProductAttrMain> main;
  List<ProductAttrOrderBy> orderBy;

  factory ProductAttrData.fromRawJson(String str) =>
      ProductAttrData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttrData.fromJson(Map<String, dynamic> json) =>
      ProductAttrData(
        main: List<ProductAttrMain>.from(
            json["main"].map((x) => ProductAttrMain.fromJson(x))),
        orderBy: List<ProductAttrOrderBy>.from(
            json["order_by"].map((x) => ProductAttrOrderBy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main": List<dynamic>.from(main.map((x) => x.toJson())),
        "order_by": List<dynamic>.from(orderBy.map((x) => x.toJson())),
      };
}

class ProductAttrMain {
  ProductAttrMain({
    this.type,
    this.isChannel,
    this.pnId,
    this.pnValue,
    this.filterData,
    this.numberMin,
    this.numberMax,
    this.isExpand = false,
  });

  dynamic pnId;
  String pnValue;
  List<ProductAttrFilterDatum> filterData;
  bool isExpand;
  int type;
  int isChannel;
  int numberMin;
  int numberMax;

  factory ProductAttrMain.fromRawJson(String str) =>
      ProductAttrMain.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttrMain.fromJson(Map<String, dynamic> json) =>
      ProductAttrMain(
        pnId: json["pn_id"],
        pnValue: json["pn_value"],
        type: json["type"],
        isChannel: json["is_channel"],
        numberMin: json["number_min"],
        numberMax: json["number_max"],
        filterData: List<ProductAttrFilterDatum>.from(
            json["filter_data"].map((x) => ProductAttrFilterDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "is_channel": isChannel,
        "pn_id": pnId,
        "pn_value": pnValue,
        "number_min": numberMin,
        "number_max": numberMax,
        "filter_data": List<dynamic>.from(filterData.map((x) => x.toJson())),
      };
}

class ProductAttrFilterDatum {
  ProductAttrFilterDatum({
    this.pvId,
    this.pvValue,
    this.isDisabled,
    this.isSelect = false,
    this.pnValue,
  });

  dynamic pvId;
  String pvValue;
  String pnValue;
  bool isSelect;
  int isDisabled;

  factory ProductAttrFilterDatum.fromRawJson(String str) =>
      ProductAttrFilterDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttrFilterDatum.fromJson(Map<String, dynamic> json) =>
      ProductAttrFilterDatum(
        pvId: json["pv_id"],
        pvValue: json["pv_value"],
        pnValue: json["pn_value"] ?? "",
        isDisabled: json["is_disabled"],
      );

  Map<String, dynamic> toJson() => {
        "pv_id": pvId,
        "pv_value": pvValue,
        "pn_value": pnValue,
        "is_disabled": isDisabled,
      };
}

class ProductAttrOrderBy {
  ProductAttrOrderBy({
    this.name,
    this.key,
    this.orderBy = 'desc',
    this.isSelect = false,
  });

  String name;
  String key;
  String orderBy;
  bool isSelect;

  factory ProductAttrOrderBy.fromRawJson(String str) =>
      ProductAttrOrderBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttrOrderBy.fromJson(Map<String, dynamic> json) =>
      ProductAttrOrderBy(
        name: json["name"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
      };
}
