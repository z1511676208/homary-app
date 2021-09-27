/*
 * @Author       : JHao
 * @Date         : 2021-09-26 14:53:07
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-29 17:44:57
 */
// To parse this JSON data, do
//
//     final shoppingCartRes = shoppingCartResFromJson(jsonString);

import 'dart:convert';

class ShoppingCartRes {
  ShoppingCartRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  ShoppingCartResData data;
  String message;

  factory ShoppingCartRes.fromRawJson(String str) =>
      ShoppingCartRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShoppingCartRes.fromJson(Map<String, dynamic> json) =>
      ShoppingCartRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : ShoppingCartResData.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class ShoppingCartResData {
  ShoppingCartResData({
    this.shoppingItemsNum,
    this.saveItemsNum,
    this.saveForLater,
    this.shoppingCart,
    this.summary,
    this.canPay,
    this.token,
    this.couponList,
    this.couponDiscount,
    this.orderSummary,
    this.total,
    this.totalAmount,
    this.paypal,
    this.ga,
    this.beginCheckoutGa,
  });

  int shoppingItemsNum;
  int saveItemsNum;
  List<ShoppingCart> saveForLater;
  List<ShoppingCart> shoppingCart;
  Summary summary;
  int canPay;
  String token;
  CouponList couponList;
  String couponDiscount;
  List<Total> orderSummary;
  Total total;
  dynamic totalAmount;
  Paypal paypal;
  Ga ga;
  BeginCheckoutGa beginCheckoutGa;

  factory ShoppingCartResData.fromRawJson(String str) =>
      ShoppingCartResData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShoppingCartResData.fromJson(Map<String, dynamic> json) =>
      ShoppingCartResData(
        shoppingItemsNum: json["shopping_items_num"] == null
            ? null
            : json["shopping_items_num"],
        saveItemsNum:
            json["save_items_num"] == null ? null : json["save_items_num"],
        saveForLater: json["save_for_later"] == null
            ? null
            : List<ShoppingCart>.from(
                json["save_for_later"].map((x) => ShoppingCart.fromJson(x))),
        shoppingCart: json["shopping_cart"] == null
            ? null
            : List<ShoppingCart>.from(
                json["shopping_cart"].map((x) => ShoppingCart.fromJson(x))),
        summary:
            json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        canPay: json["can_pay"] == null ? null : json["can_pay"],
        token: json["token"] == null ? null : json["token"],
        couponList: json["coupon_list"] == null || json["coupon_list"] is List
            ? null
            : CouponList.fromJson(json["coupon_list"]),
        couponDiscount:
            json["coupon_discount"] == null ? null : json["coupon_discount"],
        orderSummary: json["order_summary"] == null
            ? null
            : List<Total>.from(
                json["order_summary"].map((x) => Total.fromJson(x))),
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
        paypal: json["paypal"] == null ? null : Paypal.fromJson(json["paypal"]),
        ga: json["__ga"] == null ? null : Ga.fromJson(json["__ga"]),
        beginCheckoutGa: json["begin_checkout_ga"] == null
            ? null
            : BeginCheckoutGa.fromJson(json["begin_checkout_ga"]),
      );

  Map<String, dynamic> toJson() => {
        "shopping_items_num":
            shoppingItemsNum == null ? null : shoppingItemsNum,
        "save_items_num": saveItemsNum == null ? null : saveItemsNum,
        "save_for_later": saveForLater == null
            ? null
            : List<dynamic>.from(saveForLater.map((x) => x.toJson())),
        "shopping_cart": shoppingCart == null
            ? null
            : List<dynamic>.from(shoppingCart.map((x) => x.toJson())),
        "summary": summary == null ? null : summary.toJson(),
        "can_pay": canPay == null ? null : canPay,
        "token": token == null ? null : token,
        "coupon_list": couponList == null ? null : couponList.toJson(),
        "coupon_discount": couponDiscount == null ? null : couponDiscount,
        "order_summary": orderSummary == null
            ? null
            : List<dynamic>.from(orderSummary.map((x) => x.toJson())),
        "total": total == null ? null : total.toJson(),
        "total_amount": totalAmount == null ? null : totalAmount,
        "paypal": paypal == null ? null : paypal.toJson(),
        "__ga": ga == null ? null : ga.toJson(),
        "begin_checkout_ga":
            beginCheckoutGa == null ? null : beginCheckoutGa.toJson(),
      };
}

class BeginCheckoutGa {
  BeginCheckoutGa({
    this.event,
    this.data,
    this.isAutoSend,
  });

  String event;
  BeginCheckoutGaData data;
  int isAutoSend;

  factory BeginCheckoutGa.fromRawJson(String str) =>
      BeginCheckoutGa.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BeginCheckoutGa.fromJson(Map<String, dynamic> json) =>
      BeginCheckoutGa(
        event: json["event"] == null ? null : json["event"],
        data: json["data"] == null
            ? null
            : BeginCheckoutGaData.fromJson(json["data"]),
        isAutoSend: json["is_auto_send"] == null ? null : json["is_auto_send"],
      );

  Map<String, dynamic> toJson() => {
        "event": event == null ? null : event,
        "data": data == null ? null : data.toJson(),
        "is_auto_send": isAutoSend == null ? null : isAutoSend,
      };
}

class BeginCheckoutGaData {
  BeginCheckoutGaData({
    this.coupon,
    this.userType,
    this.currency,
    this.items,
    this.value,
    this.checkoutUrl,
    this.eventLabel,
  });

  String coupon;
  String userType;
  String currency;
  List<Item> items;
  String value;
  String checkoutUrl;
  String eventLabel;

  factory BeginCheckoutGaData.fromRawJson(String str) =>
      BeginCheckoutGaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BeginCheckoutGaData.fromJson(Map<String, dynamic> json) =>
      BeginCheckoutGaData(
        coupon: json["coupon"] == null ? null : json["coupon"],
        userType: json["user_type"] == null ? null : json["user_type"],
        currency: json["currency"] == null ? null : json["currency"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        value: json["value"] == null ? null : json["value"],
        checkoutUrl: json["CheckoutURL"] == null ? null : json["CheckoutURL"],
        eventLabel: json["event_label"] == null ? null : json["event_label"],
      );

  Map<String, dynamic> toJson() => {
        "coupon": coupon == null ? null : coupon,
        "user_type": userType == null ? null : userType,
        "currency": currency == null ? null : currency,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "value": value == null ? null : value,
        "CheckoutURL": checkoutUrl == null ? null : checkoutUrl,
        "event_label": eventLabel == null ? null : eventLabel,
      };
}

class Item {
  Item({
    this.itemId,
    this.itemName,
    this.quantity,
    this.promotionId,
    this.affiliation,
    this.index,
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
  });

  String itemId;
  String itemName;
  String quantity;
  dynamic promotionId;
  String affiliation;
  int index;
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

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"] == null ? null : json["item_id"],
        itemName: json["item_name"] == null ? null : json["item_name"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        promotionId: json["promotion_id"],
        affiliation: json["affiliation"] == null ? null : json["affiliation"],
        index: json["index"] == null ? null : json["index"],
        itemBrand: json["item_brand"] == null ? null : json["item_brand"],
        itemCategory:
            json["item_category"] == null ? null : json["item_category"],
        itemCategory2:
            json["item_category2"] == null ? null : json["item_category2"],
        itemCategory3:
            json["item_category3"] == null ? null : json["item_category3"],
        itemCategory4:
            json["item_category4"] == null ? null : json["item_category4"],
        itemVariant: json["item_variant"] == null ? null : json["item_variant"],
        price: json["price"] == null ? null : json["price"],
        currency: json["currency"] == null ? null : json["currency"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        imgUrl: json["img_url"] == null ? null : json["img_url"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId == null ? null : itemId,
        "item_name": itemName == null ? null : itemName,
        "quantity": quantity == null ? null : quantity,
        "promotion_id": promotionId,
        "affiliation": affiliation == null ? null : affiliation,
        "index": index == null ? null : index,
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
      };
}

class CouponList {
  CouponList({
    this.useableList,
    this.diabledList,
    this.coupon,
  });

  List<Coupon> useableList;
  List<Coupon> diabledList;
  Coupon coupon;

  factory CouponList.fromRawJson(String str) =>
      CouponList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponList.fromJson(Map<String, dynamic> json) => CouponList(
        useableList: json["useable_list"] == null
            ? null
            : List<Coupon>.from(
                json["useable_list"].map((x) => Coupon.fromJson(x))),
        diabledList: json["diabled_list"] == null
            ? null
            : List<Coupon>.from(
                json["diabled_list"].map((x) => Coupon.fromJson(x))),
        coupon: json["coupon"] == null || json["coupon"] is List
            ? null
            : Coupon.fromJson(json["coupon"]),
      );

  Map<String, dynamic> toJson() => {
        "useable_list": useableList == null
            ? null
            : List<dynamic>.from(useableList.map((x) => x.toJson())),
        "diabled_list": diabledList == null
            ? null
            : List<dynamic>.from(diabledList.map((x) => x.toJson())),
        "coupon": coupon == null ? null : coupon.toJson(),
      };
}

class Coupon {
  Coupon({
    this.couponId,
    this.couponUserId,
    this.couponName,
    this.thresholdAmount,
    this.couponAlias,
    this.endTime,
    this.startTime,
    this.remarks,
    this.couponAmountStr,
    this.discountType,
    this.discountAmount,
    this.useAmount,
    this.showAlias,
    this.associateInformation,
    this.discountInformation,
    this.threshold,
    this.isNewUserCoupon,
    this.isSelected,
    this.couponDiscountAmount,
    this.couponCode,
    this.couponDesc,
    this.drawStartTime,
    this.drawStartTimeUtc8,
    this.drawEndTime,
    this.drawEndTimeUtc8,
    this.endDate,
    this.startDate,
    this.thresholdAmountReal,
    this.useType,
    this.status,
  });

  int couponId;
  String couponUserId;
  String couponName;
  String thresholdAmount;
  String couponAlias;
  String endTime;
  String startTime;
  String remarks;
  String couponAmountStr;
  String discountType;
  String discountAmount;
  dynamic useAmount;
  String showAlias;
  String associateInformation;
  String discountInformation;
  String threshold;
  int isNewUserCoupon;
  int isSelected;
  dynamic couponDiscountAmount;

  String couponCode;
  String couponDesc;
  DateTime drawStartTime;
  DateTime drawStartTimeUtc8;
  DateTime drawEndTime;
  DateTime drawEndTimeUtc8;
  String endDate;
  String startDate;
  int thresholdAmountReal;
  String useType;
  String status;

  factory Coupon.fromRawJson(String str) => Coupon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        couponId: json["coupon_id"] == null ? null : json["coupon_id"],
        couponUserId:
            json["coupon_user_id"] == null ? null : json["coupon_user_id"],
        couponName: json["coupon_name"] == null ? null : json["coupon_name"],
        thresholdAmount:
            json["threshold_amount"] == null ? null : json["threshold_amount"],
        couponAlias: json["coupon_alias"] == null ? null : json["coupon_alias"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        couponAmountStr: json["coupon_amount_str"] == null
            ? null
            : json["coupon_amount_str"],
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
        discountAmount:
            json["discount_amount"] == null ? null : json["discount_amount"],
        useAmount: json["use_amount"] == null ? null : json["use_amount"],
        showAlias: json["show_alias"] == null ? null : json["show_alias"],
        associateInformation: json["associate_information"] == null
            ? null
            : json["associate_information"],
        discountInformation: json["discount_information"] == null
            ? null
            : json["discount_information"],
        threshold: json["threshold"] == null ? null : json["threshold"],
        isNewUserCoupon: json["is_new_user_coupon"] == null
            ? null
            : json["is_new_user_coupon"],
        isSelected: json["is_selected"] == null ? null : json["is_selected"],
        couponDiscountAmount: json["coupon_discount_amount"] == null
            ? null
            : json["coupon_discount_amount"],
      );

  Map<String, dynamic> toJson() => {
        "coupon_id": couponId == null ? null : couponId,
        "coupon_user_id": couponUserId == null ? null : couponUserId,
        "coupon_name": couponName == null ? null : couponName,
        "threshold_amount": thresholdAmount == null ? null : thresholdAmount,
        "coupon_alias": couponAlias == null ? null : couponAlias,
        "end_time": endTime == null ? null : endTime,
        "start_time": startTime == null ? null : startTime,
        "remarks": remarks == null ? null : remarks,
        "coupon_amount_str": couponAmountStr == null ? null : couponAmountStr,
        "discount_type": discountType == null ? null : discountType,
        "discount_amount": discountAmount == null ? null : discountAmount,
        "use_amount": useAmount == null ? null : useAmount,
        "show_alias": showAlias == null ? null : showAlias,
        "associate_information":
            associateInformation == null ? null : associateInformation,
        "discount_information":
            discountInformation == null ? null : discountInformation,
        "threshold": threshold == null ? null : threshold,
        "is_new_user_coupon": isNewUserCoupon == null ? null : isNewUserCoupon,
        "is_selected": isSelected == null ? null : isSelected,
        "coupon_discount_amount":
            couponDiscountAmount == null ? null : couponDiscountAmount,
      };
}

class DiabledList {
  DiabledList({
    this.couponId,
    this.couponUserId,
    this.couponName,
    this.thresholdAmount,
    this.couponAlias,
    this.endTime,
    this.startTime,
    this.remarks,
    this.couponAmountStr,
    this.discountType,
    this.discountAmount,
    this.useAmount,
    this.showAlias,
    this.associateInformation,
    this.discountInformation,
    this.threshold,
    this.isNewUserCoupon,
  });

  int couponId;
  String couponUserId;
  String couponName;
  String thresholdAmount;
  String couponAlias;
  String endTime;
  String startTime;
  String remarks;
  String couponAmountStr;
  String discountType;
  String discountAmount;
  dynamic useAmount;
  String showAlias;
  String associateInformation;
  String discountInformation;
  String threshold;
  int isNewUserCoupon;

  factory DiabledList.fromRawJson(String str) =>
      DiabledList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiabledList.fromJson(Map<String, dynamic> json) => DiabledList(
        couponId: json["coupon_id"] == null ? null : json["coupon_id"],
        couponUserId:
            json["coupon_user_id"] == null ? null : json["coupon_user_id"],
        couponName: json["coupon_name"] == null ? null : json["coupon_name"],
        thresholdAmount:
            json["threshold_amount"] == null ? null : json["threshold_amount"],
        couponAlias: json["coupon_alias"] == null ? null : json["coupon_alias"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        couponAmountStr: json["coupon_amount_str"] == null
            ? null
            : json["coupon_amount_str"],
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
        discountAmount:
            json["discount_amount"] == null ? null : json["discount_amount"],
        useAmount: json["use_amount"],
        showAlias: json["show_alias"] == null ? null : json["show_alias"],
        associateInformation: json["associate_information"] == null
            ? null
            : json["associate_information"],
        discountInformation: json["discount_information"] == null
            ? null
            : json["discount_information"],
        threshold: json["threshold"] == null ? null : json["threshold"],
        isNewUserCoupon: json["is_new_user_coupon"] == null
            ? null
            : json["is_new_user_coupon"],
      );

  Map<String, dynamic> toJson() => {
        "coupon_id": couponId == null ? null : couponId,
        "coupon_user_id": couponUserId == null ? null : couponUserId,
        "coupon_name": couponName == null ? null : couponName,
        "threshold_amount": thresholdAmount == null ? null : thresholdAmount,
        "coupon_alias": couponAlias == null ? null : couponAlias,
        "end_time": endTime == null ? null : endTime,
        "start_time": startTime == null ? null : startTime,
        "remarks": remarks == null ? null : remarks,
        "coupon_amount_str": couponAmountStr == null ? null : couponAmountStr,
        "discount_type": discountType == null ? null : discountType,
        "discount_amount": discountAmount == null ? null : discountAmount,
        "use_amount": useAmount,
        "show_alias": showAlias == null ? null : showAlias,
        "associate_information":
            associateInformation == null ? null : associateInformation,
        "discount_information":
            discountInformation == null ? null : discountInformation,
        "threshold": threshold == null ? null : threshold,
        "is_new_user_coupon": isNewUserCoupon == null ? null : isNewUserCoupon,
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
  int isAutoSend;

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
    this.currency,
    this.items,
    this.value,
  });

  String currency;
  List<Item> items;
  String value;

  factory GaData.fromRawJson(String str) => GaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GaData.fromJson(Map<String, dynamic> json) => GaData(
        currency: json["currency"] == null ? null : json["currency"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency == null ? null : currency,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "value": value == null ? null : value,
      };
}

class Total {
  Total({
    this.identifying,
    this.color,
    this.name,
    this.amount,
  });

  String identifying;
  String color;
  String name;
  String amount;

  factory Total.fromRawJson(String str) => Total.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        identifying: json["identifying"] == null ? null : json["identifying"],
        color: json["color"] == null ? null : json["color"],
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "identifying": identifying == null ? null : identifying,
        "color": color == null ? null : color,
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
      };
}

class Paypal {
  Paypal({
    this.id,
    this.code,
    this.title,
    this.subTitle,
    this.isLocalPayment,
    this.icon,
    this.iconSmall,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.delFlag,
    this.titleEn,
    this.titleUsa,
    this.titleDe,
    this.titleEs,
    this.titleFr,
    this.subTitleEn,
    this.subTitleUsa,
    this.subTitleDe,
    this.subTitleEs,
    this.subTitleFr,
    this.token,
    this.sdkParams,
    this.paymentParams,
  });

  String id;
  String code;
  String title;
  String subTitle;
  String isLocalPayment;
  String icon;
  String iconSmall;
  String status;
  String createdAt;
  String updatedAt;
  String delFlag;
  String titleEn;
  String titleUsa;
  String titleDe;
  String titleEs;
  String titleFr;
  String subTitleEn;
  String subTitleUsa;
  String subTitleDe;
  String subTitleEs;
  String subTitleFr;
  String token;
  SdkParams sdkParams;
  PaymentParams paymentParams;

  factory Paypal.fromRawJson(String str) => Paypal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paypal.fromJson(Map<String, dynamic> json) => Paypal(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        title: json["title"] == null ? null : json["title"],
        subTitle: json["sub_title"] == null ? null : json["sub_title"],
        isLocalPayment:
            json["is_local_payment"] == null ? null : json["is_local_payment"],
        icon: json["icon"] == null ? null : json["icon"],
        iconSmall: json["icon_small"] == null ? null : json["icon_small"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        delFlag: json["del_flag"] == null ? null : json["del_flag"],
        titleEn: json["title_en"] == null ? null : json["title_en"],
        titleUsa: json["title_usa"] == null ? null : json["title_usa"],
        titleDe: json["title_de"] == null ? null : json["title_de"],
        titleEs: json["title_es"] == null ? null : json["title_es"],
        titleFr: json["title_fr"] == null ? null : json["title_fr"],
        subTitleEn: json["sub_title_en"] == null ? null : json["sub_title_en"],
        subTitleUsa:
            json["sub_title_usa"] == null ? null : json["sub_title_usa"],
        subTitleDe: json["sub_title_de"] == null ? null : json["sub_title_de"],
        subTitleEs: json["sub_title_es"] == null ? null : json["sub_title_es"],
        subTitleFr: json["sub_title_fr"] == null ? null : json["sub_title_fr"],
        token: json["token"] == null ? null : json["token"],
        sdkParams: json["sdk_params"] == null
            ? null
            : SdkParams.fromJson(json["sdk_params"]),
        paymentParams: json["payment_params"] == null
            ? null
            : PaymentParams.fromJson(json["payment_params"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "title": title == null ? null : title,
        "sub_title": subTitle == null ? null : subTitle,
        "is_local_payment": isLocalPayment == null ? null : isLocalPayment,
        "icon": icon == null ? null : icon,
        "icon_small": iconSmall == null ? null : iconSmall,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "del_flag": delFlag == null ? null : delFlag,
        "title_en": titleEn == null ? null : titleEn,
        "title_usa": titleUsa == null ? null : titleUsa,
        "title_de": titleDe == null ? null : titleDe,
        "title_es": titleEs == null ? null : titleEs,
        "title_fr": titleFr == null ? null : titleFr,
        "sub_title_en": subTitleEn == null ? null : subTitleEn,
        "sub_title_usa": subTitleUsa == null ? null : subTitleUsa,
        "sub_title_de": subTitleDe == null ? null : subTitleDe,
        "sub_title_es": subTitleEs == null ? null : subTitleEs,
        "sub_title_fr": subTitleFr == null ? null : subTitleFr,
        "token": token == null ? null : token,
        "sdk_params": sdkParams == null ? null : sdkParams.toJson(),
        "payment_params": paymentParams == null ? null : paymentParams.toJson(),
      };
}

class PaymentParams {
  PaymentParams({
    this.flow,
    this.amount,
    this.currency,
    this.intent,
    this.enableShippingAddress,
    this.shippingAddressEditable,
    this.shippingAddressOverride,
    this.lineItem,
  });

  String flow;
  String amount;
  String currency;
  String intent;
  bool enableShippingAddress;
  bool shippingAddressEditable;
  List<dynamic> shippingAddressOverride;
  List<LineItem> lineItem;

  factory PaymentParams.fromRawJson(String str) =>
      PaymentParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentParams.fromJson(Map<String, dynamic> json) => PaymentParams(
        flow: json["flow"] == null ? null : json["flow"],
        amount: json["amount"] == null ? null : json["amount"],
        currency: json["currency"] == null ? null : json["currency"],
        intent: json["intent"] == null ? null : json["intent"],
        enableShippingAddress: json["enableShippingAddress"] == null
            ? null
            : json["enableShippingAddress"],
        shippingAddressEditable: json["shippingAddressEditable"] == null
            ? null
            : json["shippingAddressEditable"],
        shippingAddressOverride: json["shippingAddressOverride"] == null
            ? null
            : List<dynamic>.from(json["shippingAddressOverride"].map((x) => x)),
        lineItem: json["lineItem"] == null
            ? null
            : List<LineItem>.from(
                json["lineItem"].map((x) => LineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flow": flow == null ? null : flow,
        "amount": amount == null ? null : amount,
        "currency": currency == null ? null : currency,
        "intent": intent == null ? null : intent,
        "enableShippingAddress":
            enableShippingAddress == null ? null : enableShippingAddress,
        "shippingAddressEditable":
            shippingAddressEditable == null ? null : shippingAddressEditable,
        "shippingAddressOverride": shippingAddressOverride == null
            ? null
            : List<dynamic>.from(shippingAddressOverride.map((x) => x)),
        "lineItem": lineItem == null
            ? null
            : List<dynamic>.from(lineItem.map((x) => x.toJson())),
      };
}

class LineItem {
  LineItem({
    this.quantity,
    this.unitAmount,
    this.name,
    this.kind,
    this.unitTaxAmount,
    this.description,
    this.url,
  });

  int quantity;
  String unitAmount;
  String name;
  String kind;
  String unitTaxAmount;
  String description;
  String url;

  factory LineItem.fromRawJson(String str) =>
      LineItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        quantity: json["quantity"] == null ? null : json["quantity"],
        unitAmount: json["unitAmount"] == null ? null : json["unitAmount"],
        name: json["name"] == null ? null : json["name"],
        kind: json["kind"] == null ? null : json["kind"],
        unitTaxAmount:
            json["unitTaxAmount"] == null ? null : json["unitTaxAmount"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity == null ? null : quantity,
        "unitAmount": unitAmount == null ? null : unitAmount,
        "name": name == null ? null : name,
        "kind": kind == null ? null : kind,
        "unitTaxAmount": unitTaxAmount == null ? null : unitTaxAmount,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
      };
}

class SdkParams {
  SdkParams({
    this.clientId,
    this.currency,
    this.intent,
    this.components,
    this.locale,
  });

  String clientId;
  String currency;
  String intent;
  String components;
  String locale;

  factory SdkParams.fromRawJson(String str) =>
      SdkParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SdkParams.fromJson(Map<String, dynamic> json) => SdkParams(
        clientId: json["client-id"] == null ? null : json["client-id"],
        currency: json["currency"] == null ? null : json["currency"],
        intent: json["intent"] == null ? null : json["intent"],
        components: json["components"] == null ? null : json["components"],
        locale: json["locale"] == null ? null : json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "client-id": clientId == null ? null : clientId,
        "currency": currency == null ? null : currency,
        "intent": intent == null ? null : intent,
        "components": components == null ? null : components,
        "locale": locale == null ? null : locale,
      };
}

class SaveForLater {
  SaveForLater({
    this.cartId,
    this.skuId,
    this.isSelected,
    this.skuCode,
    this.spuId,
    this.spuCode,
    this.img,
    this.title,
    this.priceUnsigned,
    this.activityPriceUnsigned,
    this.price,
    this.tagPrice,
    this.qty,
    this.attrGroup,
    this.checkStatus,
    this.checkStatusName,
    this.activityType,
    this.activityId,
    this.activityStatus,
    this.activityStock,
    this.activityDiscountAmount,
    this.deliveryTime,
    this.reviewNum,
    this.reviewScore,
    this.cornerBgUrl,
    this.cornerText,
    this.jumpUrl,
    this.spuBrandId,
    this.spuCategoryIdFirst,
    this.spuCategoryIdSecond,
    this.spuCategoryIdThird,
    this.spuCategoryIdFourth,
    this.itemBrand,
    this.itemCategory,
    this.itemCategory2,
    this.itemCategory3,
    this.itemCategory4,
    this.activityEndTimeStamp,
    this.priceOffDesc,
    this.priceTextLabel,
  });

  String cartId;
  String skuId;
  String isSelected;
  String skuCode;
  String spuId;
  String spuCode;
  String img;
  String title;
  String priceUnsigned;
  dynamic activityPriceUnsigned;
  String price;
  String tagPrice;
  String qty;
  SaveForLaterAttrGroup attrGroup;
  int checkStatus;
  String checkStatusName;
  dynamic activityType;
  dynamic activityId;
  int activityStatus;
  int activityStock;
  dynamic activityDiscountAmount;
  String deliveryTime;
  dynamic reviewNum;
  dynamic reviewScore;
  String cornerBgUrl;
  String cornerText;
  String jumpUrl;
  String spuBrandId;
  String spuCategoryIdFirst;
  String spuCategoryIdSecond;
  String spuCategoryIdThird;
  String spuCategoryIdFourth;
  String itemBrand;
  String itemCategory;
  String itemCategory2;
  String itemCategory3;
  String itemCategory4;
  dynamic activityEndTimeStamp;
  String priceOffDesc;
  String priceTextLabel;

  factory SaveForLater.fromRawJson(String str) =>
      SaveForLater.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveForLater.fromJson(Map<String, dynamic> json) => SaveForLater(
        cartId: json["cart_id"] == null ? null : json["cart_id"],
        skuId: json["sku_id"] == null ? null : json["sku_id"],
        isSelected: json["is_selected"] == null ? null : json["is_selected"],
        skuCode: json["sku_code"] == null ? null : json["sku_code"],
        spuId: json["spu_id"] == null ? null : json["spu_id"],
        spuCode: json["spu_code"] == null ? null : json["spu_code"],
        img: json["img"] == null ? null : json["img"],
        title: json["title"] == null ? null : json["title"],
        priceUnsigned:
            json["price_unsigned"] == null ? null : json["price_unsigned"],
        activityPriceUnsigned: json["activity_price_unsigned"],
        price: json["price"] == null ? null : json["price"],
        tagPrice: json["tag_price"] == null ? null : json["tag_price"],
        qty: json["qty"] == null ? null : json["qty"],
        attrGroup: json["attr_group"] == null
            ? null
            : SaveForLaterAttrGroup.fromJson(json["attr_group"]),
        checkStatus: json["check_status"] == null ? null : json["check_status"],
        checkStatusName: json["check_status_name"] == null
            ? null
            : json["check_status_name"],
        activityType: json["activity_type"],
        activityId: json["activity_id"],
        activityStatus:
            json["activity_status"] == null ? null : json["activity_status"],
        activityStock:
            json["activity_stock"] == null ? null : json["activity_stock"],
        activityDiscountAmount: json["activity_discount_amount"] == null
            ? null
            : json["activity_discount_amount"],
        deliveryTime:
            json["delivery_time"] == null ? null : json["delivery_time"],
        reviewNum: json["review_num"],
        reviewScore: json["review_score"] == null ? null : json["review_score"],
        cornerBgUrl:
            json["corner_bg_url"] == null ? null : json["corner_bg_url"],
        cornerText: json["corner_text"] == null ? null : json["corner_text"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        spuBrandId: json["spu_brand_id"] == null ? null : json["spu_brand_id"],
        spuCategoryIdFirst: json["spu_category_id_first"] == null
            ? null
            : json["spu_category_id_first"],
        spuCategoryIdSecond: json["spu_category_id_second"] == null
            ? null
            : json["spu_category_id_second"],
        spuCategoryIdThird: json["spu_category_id_third"] == null
            ? null
            : json["spu_category_id_third"],
        spuCategoryIdFourth: json["spu_category_id_fourth"] == null
            ? null
            : json["spu_category_id_fourth"],
        itemBrand: json["item_brand"] == null ? null : json["item_brand"],
        itemCategory:
            json["item_category"] == null ? null : json["item_category"],
        itemCategory2:
            json["item_category2"] == null ? null : json["item_category2"],
        itemCategory3:
            json["item_category3"] == null ? null : json["item_category3"],
        itemCategory4:
            json["item_category4"] == null ? null : json["item_category4"],
        activityEndTimeStamp: json["activity_end_time_stamp"] == null
            ? null
            : json["activity_end_time_stamp"],
        priceOffDesc:
            json["price_off_desc"] == null ? null : json["price_off_desc"],
        priceTextLabel:
            json["price_text_label"] == null ? null : json["price_text_label"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId == null ? null : cartId,
        "sku_id": skuId == null ? null : skuId,
        "is_selected": isSelected == null ? null : isSelected,
        "sku_code": skuCode == null ? null : skuCode,
        "spu_id": spuId == null ? null : spuId,
        "spu_code": spuCode == null ? null : spuCode,
        "img": img == null ? null : img,
        "title": title == null ? null : title,
        "price_unsigned": priceUnsigned == null ? null : priceUnsigned,
        "activity_price_unsigned": activityPriceUnsigned,
        "price": price == null ? null : price,
        "tag_price": tagPrice == null ? null : tagPrice,
        "qty": qty == null ? null : qty,
        "attr_group": attrGroup == null ? null : attrGroup.toJson(),
        "check_status": checkStatus == null ? null : checkStatus,
        "check_status_name": checkStatusName == null ? null : checkStatusName,
        "activity_type": activityType,
        "activity_id": activityId,
        "activity_status": activityStatus == null ? null : activityStatus,
        "activity_stock": activityStock == null ? null : activityStock,
        "activity_discount_amount":
            activityDiscountAmount == null ? null : activityDiscountAmount,
        "delivery_time": deliveryTime == null ? null : deliveryTime,
        "review_num": reviewNum,
        "review_score": reviewScore == null ? null : reviewScore,
        "corner_bg_url": cornerBgUrl == null ? null : cornerBgUrl,
        "corner_text": cornerText == null ? null : cornerText,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "spu_brand_id": spuBrandId == null ? null : spuBrandId,
        "spu_category_id_first":
            spuCategoryIdFirst == null ? null : spuCategoryIdFirst,
        "spu_category_id_second":
            spuCategoryIdSecond == null ? null : spuCategoryIdSecond,
        "spu_category_id_third":
            spuCategoryIdThird == null ? null : spuCategoryIdThird,
        "spu_category_id_fourth":
            spuCategoryIdFourth == null ? null : spuCategoryIdFourth,
        "item_brand": itemBrand == null ? null : itemBrand,
        "item_category": itemCategory == null ? null : itemCategory,
        "item_category2": itemCategory2 == null ? null : itemCategory2,
        "item_category3": itemCategory3 == null ? null : itemCategory3,
        "item_category4": itemCategory4 == null ? null : itemCategory4,
        "activity_end_time_stamp":
            activityEndTimeStamp == null ? null : activityEndTimeStamp,
        "price_off_desc": priceOffDesc == null ? null : priceOffDesc,
        "price_text_label": priceTextLabel == null ? null : priceTextLabel,
      };
}

class SaveForLaterAttrGroup {
  SaveForLaterAttrGroup({
    this.color,
    this.option,
    this.size,
    this.finish,
    this.spec,
    this.style,
    this.coverType,
    this.numberOfLights,
  });

  String color;
  String option;
  String size;
  String finish;
  String spec;
  String style;
  String coverType;
  String numberOfLights;

  factory SaveForLaterAttrGroup.fromRawJson(String str) =>
      SaveForLaterAttrGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveForLaterAttrGroup.fromJson(Map<String, dynamic> json) =>
      SaveForLaterAttrGroup(
        color: json["Color"] == null ? null : json["Color"],
        option: json["Option"] == null ? null : json["Option"],
        size: json["Size"] == null ? null : json["Size"],
        finish: json["Finish"] == null ? null : json["Finish"],
        spec: json["Spec"] == null ? null : json["Spec"],
        style: json["Style"] == null ? null : json["Style"],
        coverType: json["Cover Type"] == null ? null : json["Cover Type"],
        numberOfLights:
            json["Number Of Lights"] == null ? null : json["Number Of Lights"],
      );

  Map<String, dynamic> toJson() => {
        "Color": color == null ? null : color,
        "Option": option == null ? null : option,
        "Size": size == null ? null : size,
        "Finish": finish == null ? null : finish,
        "Spec": spec == null ? null : spec,
        "Style": style == null ? null : style,
        "Cover Type": coverType == null ? null : coverType,
        "Number Of Lights": numberOfLights == null ? null : numberOfLights,
      };
}

class ShoppingCart {
  ShoppingCart({
    this.cartId,
    this.skuId,
    this.isSelected,
    this.skuCode,
    this.spuId,
    this.spuCode,
    this.img,
    this.title,
    this.priceUnsigned,
    this.activityPriceUnsigned,
    this.price,
    this.tagPrice,
    this.qty,
    this.attrGroup,
    this.checkStatus,
    this.checkStatusName,
    this.activityType,
    this.activityId,
    this.activityStatus,
    this.activityStock,
    this.activityDiscountAmount,
    this.deliveryTime,
    this.reviewNum,
    this.reviewScore,
    this.cornerBgUrl,
    this.cornerText,
    this.jumpUrl,
    this.spuBrandId,
    this.spuCategoryIdFirst,
    this.spuCategoryIdSecond,
    this.spuCategoryIdThird,
    this.spuCategoryIdFourth,
    this.itemBrand,
    this.itemCategory,
    this.itemCategory2,
    this.itemCategory3,
    this.itemCategory4,
    this.activityEndTimeStamp,
    this.priceOffDesc,
    this.priceTextLabel,
    this.qtyError,
  });

  String cartId;
  String skuId;
  String isSelected;
  String skuCode;
  String spuId;
  String spuCode;
  String img;
  String title;
  String priceUnsigned;
  dynamic activityPriceUnsigned;
  String price;
  String tagPrice;
  String qty;
  Map attrGroup;
  int checkStatus;
  String checkStatusName;
  dynamic activityType;
  dynamic activityId;
  int activityStatus;
  int activityStock;
  dynamic activityDiscountAmount;
  String deliveryTime;
  dynamic reviewNum;
  dynamic reviewScore;
  String cornerBgUrl;
  String cornerText;
  String jumpUrl;
  String spuBrandId;
  String spuCategoryIdFirst;
  String spuCategoryIdSecond;
  String spuCategoryIdThird;
  String spuCategoryIdFourth;
  String itemBrand;
  String itemCategory;
  String itemCategory2;
  String itemCategory3;
  String itemCategory4;
  dynamic activityEndTimeStamp;
  String priceOffDesc;
  String priceTextLabel;
  String qtyError;

  factory ShoppingCart.fromRawJson(String str) =>
      ShoppingCart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
        cartId: json["cart_id"] == null ? null : json["cart_id"],
        skuId: json["sku_id"] == null ? null : json["sku_id"],
        isSelected: json["is_selected"] == null ? null : json["is_selected"],
        skuCode: json["sku_code"] == null ? null : json["sku_code"],
        spuId: json["spu_id"] == null ? null : json["spu_id"],
        spuCode: json["spu_code"] == null ? null : json["spu_code"],
        img: json["img"] == null ? null : json["img"],
        title: json["title"] == null ? null : json["title"],
        priceUnsigned:
            json["price_unsigned"] == null ? null : json["price_unsigned"],
        activityPriceUnsigned: json["activity_price_unsigned"],
        price: json["price"] == null ? null : json["price"],
        tagPrice: json["tag_price"] == null ? null : json["tag_price"],
        qty: json["qty"] == null ? null : json["qty"],
        attrGroup: json["attr_group"] == null || json["attr_group"] is List
            ? {}
            : json["attr_group"],
        checkStatus: json["check_status"] == null ? null : json["check_status"],
        checkStatusName: json["check_status_name"] == null
            ? null
            : json["check_status_name"],
        activityType: json["activity_type"],
        activityId: json["activity_id"],
        activityStatus:
            json["activity_status"] == null ? null : json["activity_status"],
        activityStock:
            json["activity_stock"] == null ? null : json["activity_stock"],
        activityDiscountAmount: json["activity_discount_amount"] == null
            ? null
            : json["activity_discount_amount"],
        deliveryTime:
            json["delivery_time"] == null ? null : json["delivery_time"],
        reviewNum: json["review_num"] == null ? null : json["review_num"],
        reviewScore: json["review_score"] == null ? null : json["review_score"],
        cornerBgUrl:
            json["corner_bg_url"] == null ? null : json["corner_bg_url"],
        cornerText: json["corner_text"] == null ? null : json["corner_text"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        spuBrandId: json["spu_brand_id"] == null ? null : json["spu_brand_id"],
        spuCategoryIdFirst: json["spu_category_id_first"] == null
            ? null
            : json["spu_category_id_first"],
        spuCategoryIdSecond: json["spu_category_id_second"] == null
            ? null
            : json["spu_category_id_second"],
        spuCategoryIdThird: json["spu_category_id_third"] == null
            ? null
            : json["spu_category_id_third"],
        spuCategoryIdFourth: json["spu_category_id_fourth"] == null
            ? null
            : json["spu_category_id_fourth"],
        itemBrand: json["item_brand"] == null ? null : json["item_brand"],
        itemCategory:
            json["item_category"] == null ? null : json["item_category"],
        itemCategory2:
            json["item_category2"] == null ? null : json["item_category2"],
        itemCategory3:
            json["item_category3"] == null ? null : json["item_category3"],
        itemCategory4:
            json["item_category4"] == null ? null : json["item_category4"],
        activityEndTimeStamp: json["activity_end_time_stamp"] == null
            ? null
            : json["activity_end_time_stamp"],
        priceOffDesc:
            json["price_off_desc"] == null ? null : json["price_off_desc"],
        priceTextLabel:
            json["price_text_label"] == null ? null : json["price_text_label"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId == null ? null : cartId,
        "sku_id": skuId == null ? null : skuId,
        "is_selected": isSelected == null ? null : isSelected,
        "sku_code": skuCode == null ? null : skuCode,
        "spu_id": spuId == null ? null : spuId,
        "spu_code": spuCode == null ? null : spuCode,
        "img": img == null ? null : img,
        "title": title == null ? null : title,
        "price_unsigned": priceUnsigned == null ? null : priceUnsigned,
        "activity_price_unsigned": activityPriceUnsigned,
        "price": price == null ? null : price,
        "tag_price": tagPrice == null ? null : tagPrice,
        "qty": qty == null ? null : qty,
        "attr_group": attrGroup == null ? null : attrGroup,
        "check_status": checkStatus == null ? null : checkStatus,
        "check_status_name": checkStatusName == null ? null : checkStatusName,
        "activity_type": activityType,
        "activity_id": activityId,
        "activity_status": activityStatus == null ? null : activityStatus,
        "activity_stock": activityStock == null ? null : activityStock,
        "activity_discount_amount":
            activityDiscountAmount == null ? null : activityDiscountAmount,
        "delivery_time": deliveryTime == null ? null : deliveryTime,
        "review_num": reviewNum == null ? null : reviewNum,
        "review_score": reviewScore == null ? null : reviewScore,
        "corner_bg_url": cornerBgUrl == null ? null : cornerBgUrl,
        "corner_text": cornerText == null ? null : cornerText,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "spu_brand_id": spuBrandId == null ? null : spuBrandId,
        "spu_category_id_first":
            spuCategoryIdFirst == null ? null : spuCategoryIdFirst,
        "spu_category_id_second":
            spuCategoryIdSecond == null ? null : spuCategoryIdSecond,
        "spu_category_id_third":
            spuCategoryIdThird == null ? null : spuCategoryIdThird,
        "spu_category_id_fourth":
            spuCategoryIdFourth == null ? null : spuCategoryIdFourth,
        "item_brand": itemBrand == null ? null : itemBrand,
        "item_category": itemCategory == null ? null : itemCategory,
        "item_category2": itemCategory2 == null ? null : itemCategory2,
        "item_category3": itemCategory3 == null ? null : itemCategory3,
        "item_category4": itemCategory4 == null ? null : itemCategory4,
        "activity_end_time_stamp":
            activityEndTimeStamp == null ? null : activityEndTimeStamp,
        "price_off_desc": priceOffDesc == null ? null : priceOffDesc,
        "price_text_label": priceTextLabel == null ? null : priceTextLabel,
      };
}

class Summary {
  Summary({
    this.subtotal,
  });

  dynamic subtotal;

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        subtotal: json["subtotal"] == null ? null : json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal == null ? null : subtotal,
      };
}
