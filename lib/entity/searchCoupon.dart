/*
 * @Author       : JHao
 * @Date         : 2021-09-27 10:14:48
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-11 15:37:46
 */
// To parse this JSON data, do
//
//     final searchCouponRes = searchCouponResFromJson(jsonString);

import 'dart:convert';

class SearchCouponRes {
  SearchCouponRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory SearchCouponRes.fromRawJson(String str) =>
      SearchCouponRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchCouponRes.fromJson(Map<String, dynamic> json) =>
      SearchCouponRes(
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
    this.list,
  });

  List<ListElement> list;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
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
  });

  dynamic couponId;
  dynamic couponUserId;
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

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
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
