// To parse this JSON data, do
//
//     final ordersRes = ordersResFromJson(jsonString);

import 'dart:convert';

class OrdersRes {
  OrdersRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  OrdersResData data;
  String message;

  factory OrdersRes.fromRawJson(String str) => OrdersRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrdersRes.fromJson(Map<String, dynamic> json) => OrdersRes(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : OrdersResData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data.toJson(),
    "message": message == null ? null : message,
  };
}

class OrdersResData {
  OrdersResData({
    this.count,
    this.list,
  });

  dynamic count;
  List<OrdersResElement> list;

  factory OrdersResData.fromRawJson(String str) => OrdersResData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrdersResData.fromJson(Map<String, dynamic> json) => OrdersResData(
    count: json["count"] == null ? null : json["count"],
    list: json["list"] == null ? null : List<OrdersResElement>.from(json["list"].map((x) => OrdersResElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class OrdersResElement {
  OrdersResElement({
    this.date,
    this.orderNo,
    this.paymentNo,
    this.payAmount,
    this.payAmountStr,
    this.orderStatus,
    this.goodsList,
    this.paymentMethod,
    this.isShowSnapshot,
    this.fileLink,
  });

  DateTime date;
  String orderNo;
  String paymentNo;
  String payAmount;
  String payAmountStr;
  String orderStatus;
  List<GoodsList> goodsList;
  String paymentMethod;
  bool isShowSnapshot;
  String fileLink;

  factory OrdersResElement.fromRawJson(String str) => OrdersResElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrdersResElement.fromJson(Map<String, dynamic> json) => OrdersResElement(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    orderNo: json["order_no"] == null ? null : json["order_no"],
    paymentNo: json["payment_no"] == null ? null : json["payment_no"],
    payAmount: json["pay_amount"] == null ? null : json["pay_amount"],
    payAmountStr: json["pay_amount_str"] == null ? null : json["pay_amount_str"],
    orderStatus: json["order_status"] == null ? null : json["order_status"],
    goodsList: json["goods_list"] == null ? null : List<GoodsList>.from(json["goods_list"].map((x) => GoodsList.fromJson(x))),
    paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    isShowSnapshot: json["is_show_snapshot"] == null ? null : json["is_show_snapshot"],
    fileLink: json["file_link"] == null ? null : json["file_link"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date.toIso8601String(),
    "order_no": orderNo == null ? null : orderNo,
    "payment_no": paymentNo == null ? null : paymentNo,
    "pay_amount": payAmount == null ? null : payAmount,
    "pay_amount_str": payAmountStr == null ? null : payAmountStr,
    "order_status": orderStatus == null ? null : orderStatus,
    "goods_list": goodsList == null ? null : List<dynamic>.from(goodsList.map((x) => x.toJson())),
    "payment_method": paymentMethod == null ? null : paymentMethod,
    "is_show_snapshot": isShowSnapshot == null ? null : isShowSnapshot,
    "file_link": fileLink == null ? null : fileLink,
  };
}

class GoodsList {
  GoodsList({
    this.skuId,
    this.name,
    this.price,
    this.priceStr,
    this.qty,
    this.img,
    this.attrGroup,
    this.buttonList,
    this.isReceived,
    this.orderGoodsId,
    this.jumpUrl,
  });

  String skuId;
  String name;
  String price;
  String priceStr;
  String qty;
  String img;
  Map attrGroup;
  List<dynamic> buttonList;
  String isReceived;
  String orderGoodsId;
  String jumpUrl;

  factory GoodsList.fromRawJson(String str) => GoodsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoodsList.fromJson(Map<String, dynamic> json) => GoodsList(
    skuId: json["sku_id"] == null ? null : json["sku_id"],
    name: json["name"] == null ? null : json["name"],
    price: json["price"] == null ? null : json["price"],
    priceStr: json["price_str"] == null ? null : json["price_str"],
    qty: json["qty"] == null ? null : json["qty"],
    img: json["img"] == null ? null : json["img"],
    attrGroup: json["attr_group"] == null ? null : json["attr_group"],
    buttonList: json["button_list"] == null ? null : List<dynamic>.from(json["button_list"].map((x) => x)),
    isReceived: json["is_received"] == null ? null : json["is_received"],
    orderGoodsId: json["order_goods_id"] == null ? null : json["order_goods_id"],
    jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
  );

  Map<String, dynamic> toJson() => {
    "sku_id": skuId == null ? null : skuId,
    "name": name == null ? null : name,
    "price": price == null ? null : price,
    "price_str": priceStr == null ? null : priceStr,
    "qty": qty == null ? null : qty,
    "img": img == null ? null : img,
    "attr_group": attrGroup == null ? null : attrGroup,
    "button_list": buttonList == null ? null : List<dynamic>.from(buttonList.map((x) => x)),
    "is_received": isReceived == null ? null : isReceived,
    "order_goods_id": orderGoodsId == null ? null : orderGoodsId,
    "jump_url": jumpUrl == null ? null : jumpUrl,
  };
}