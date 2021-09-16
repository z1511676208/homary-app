// To parse this JSON data, do
//
//     final couponList = couponListFromJson(jsonString);

import 'dart:convert';

class CouponList {
  CouponList({
    this.code,
    this.data,
    this.message,
  });

  int code;
  CouponData data;
  String message;

  factory CouponList.fromRawJson(String str) => CouponList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponList.fromJson(Map<String, dynamic> json) => CouponList(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : CouponData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data.toJson(),
    "message": message == null ? null : message,
  };
}

class CouponData {
  CouponData({
    this.list,
    this.count,
  });

  List<Coupon> list;
  String count;

  factory CouponData.fromRawJson(String str) => CouponData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
    list: json["list"] == null ? null : List<Coupon>.from(json["list"].map((x) => Coupon.fromJson(x))),
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
    "count": count == null ? null : count,
  };
}

class Coupon {
  Coupon({
    this.couponId,
    this.couponName,
    this.couponCode,
    this.couponAlias,
    this.couponDesc,
    this.drawStartTime,
    this.drawStartTimeUtc8,
    this.drawEndTime,
    this.drawEndTimeUtc8,
    this.discountType,
    this.endTime,
    this.startTime,
    this.endDate,
    this.startDate,
    this.discountAmount,
    this.couponAmountStr,
    this.useAmount,
    this.thresholdAmount,
    this.thresholdAmountReal,
    this.showAlias,
    this.useType,
    this.status,
  });

  String couponId;
  String couponName;
  String couponCode;
  String couponAlias;
  String couponDesc;
  DateTime drawStartTime;
  DateTime drawStartTimeUtc8;
  DateTime drawEndTime;
  DateTime drawEndTimeUtc8;
  String discountType;
  String endTime;
  String startTime;
  String endDate;
  String startDate;
  String discountAmount;
  String couponAmountStr;
  dynamic useAmount;
  String thresholdAmount;
  int thresholdAmountReal;
  String showAlias;
  String useType;
  String status;

  factory Coupon.fromRawJson(String str) => Coupon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    couponId: json["coupon_id"] == null ? null : json["coupon_id"],
    couponName: json["coupon_name"] == null ? null : json["coupon_name"],
    couponCode: json["coupon_code"] == null ? null : json["coupon_code"],
    couponAlias: json["coupon_alias"] == null ? null : json["coupon_alias"],
    couponDesc: json["coupon_desc"] == null ? null : json["coupon_desc"],
    drawStartTime: json["draw_start_time"] == null ? null : DateTime.parse(json["draw_start_time"]),
    drawStartTimeUtc8: json["draw_start_time_utc8"] == null ? null : DateTime.parse(json["draw_start_time_utc8"]),
    drawEndTime: json["draw_end_time"] == null ? null : DateTime.parse(json["draw_end_time"]),
    drawEndTimeUtc8: json["draw_end_time_utc8"] == null ? null : DateTime.parse(json["draw_end_time_utc8"]),
    discountType: json["discount_type"] == null ? null : json["discount_type"],
    endTime: json["end_time"] == null ? null : json["end_time"],
    startTime: json["start_time"] == null ? null : json["start_time"],
    endDate: json["end_date"] == null ? null : json["end_date"],
    startDate: json["start_date"] == null ? null : json["start_date"],
    discountAmount: json["discount_amount"] == null ? null : json["discount_amount"],
    couponAmountStr: json["coupon_amount_str"] == null ? null : json["coupon_amount_str"],
    useAmount: json["use_amount"] == null ? null : json["use_amount"],
    thresholdAmount: json["threshold_amount"] == null ? null : json["threshold_amount"],
    thresholdAmountReal: json["threshold_amount_real"] == null ? null : json["threshold_amount_real"],
    showAlias: json["show_alias"] == null ? null : json["show_alias"],
    useType: json["use_type"] == null ? null : json["use_type"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "coupon_id": couponId == null ? null : couponId,
    "coupon_name": couponName == null ? null : couponName,
    "coupon_code": couponCode == null ? null : couponCode,
    "coupon_alias": couponAlias == null ? null : couponAlias,
    "coupon_desc": couponDesc == null ? null : couponDesc,
    "draw_start_time": drawStartTime == null ? null : drawStartTime.toIso8601String(),
    "draw_start_time_utc8": drawStartTimeUtc8 == null ? null : drawStartTimeUtc8.toIso8601String(),
    "draw_end_time": drawEndTime == null ? null : drawEndTime.toIso8601String(),
    "draw_end_time_utc8": drawEndTimeUtc8 == null ? null : drawEndTimeUtc8.toIso8601String(),
    "discount_type": discountType == null ? null : discountType,
    "end_time": endTime == null ? null : endTime,
    "start_time": startTime == null ? null : startTime,
    "end_date": endDate == null ? null : endDate,
    "start_date": startDate == null ? null : startDate,
    "discount_amount": discountAmount == null ? null : discountAmount,
    "coupon_amount_str": couponAmountStr == null ? null : couponAmountStr,
    "use_amount": useAmount == null ? null : useAmount,
    "threshold_amount": thresholdAmount == null ? null : thresholdAmount,
    "threshold_amount_real": thresholdAmountReal == null ? null : thresholdAmountReal,
    "show_alias": showAlias == null ? null : showAlias,
    "use_type": useType == null ? null : useType,
    "status": status == null ? null : status,
  };
}
