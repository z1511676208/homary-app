// To parse this JSON data, do
//
//     final afterSaleOrdersRes = afterSaleOrdersResFromJson(jsonString);

import 'dart:convert';

class AfterSaleOrdersRes {
  AfterSaleOrdersRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  AfterSaleOrdersResData data;
  String message;

  factory AfterSaleOrdersRes.fromRawJson(String str) =>
      AfterSaleOrdersRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AfterSaleOrdersRes.fromJson(Map<String, dynamic> json) =>
      AfterSaleOrdersRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : AfterSaleOrdersResData.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class AfterSaleOrdersResData {
  AfterSaleOrdersResData({
    this.count,
    this.total,
    this.list,
    this.title,
    this.key,
    this.totalPage,
  });

  dynamic count;
  String total;
  List<AfterSaleOrdersResElement> list;
  List<dynamic> title;
  List<dynamic> key;
  int totalPage;

  factory AfterSaleOrdersResData.fromRawJson(String str) =>
      AfterSaleOrdersResData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AfterSaleOrdersResData.fromJson(Map<String, dynamic> json) =>
      AfterSaleOrdersResData(
        count: json["count"] == null ? null : json["count"],
        total: json["total"] == null ? null : json["total"],
        list: json["list"] == null
            ? null
            : List<AfterSaleOrdersResElement>.from(
                json["list"].map((x) => AfterSaleOrdersResElement.fromJson(x))),
        title: json["title"] == null
            ? null
            : List<dynamic>.from(json["title"].map((x) => x)),
        key: json["key"] == null
            ? null
            : List<dynamic>.from(json["key"].map((x) => x)),
        totalPage: json["total_page"] == null ? null : json["total_page"],
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "total": total == null ? null : total,
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
        "title": title == null ? null : List<dynamic>.from(title.map((x) => x)),
        "key": key == null ? null : List<dynamic>.from(key.map((x) => x)),
        "total_page": totalPage == null ? null : totalPage,
      };
}

class AfterSaleOrdersResElement {
  AfterSaleOrdersResElement({
    this.afterSaleId,
    this.afterSaleNo,
    this.userId,
    this.status,
    this.type,
    this.orderNo,
    this.orderToUsdRate,
    this.orderToCnyRate,
    this.applyAmount,
    this.amount,
    this.usdAmount,
    this.cnyAmount,
    this.refundNo,
    this.email,
    this.phone,
    this.reason,
    this.reason2,
    this.reason3,
    this.refundReasonType,
    this.refundReason,
    this.refundReason2,
    this.refundReason3,
    this.warehouseType,
    this.description,
    this.proveUrl,
    this.addSource,
    this.addId,
    this.addName,
    this.isShowToCustomer,
    this.closedReason,
    this.closedAt,
    this.createdAt,
    this.updatedAt,
    this.delFlag,
    this.isIntercept,
    this.processingType,
    this.auditAt,
    this.lastModifyTime,
    this.refundType,
    this.couponId,
    this.couponUserId,
    this.auditUser,
    this.refundedAt,
    this.clientDescription,
    this.currencyCode,
    this.statusName,
    this.typeName,
    this.typeStr,
    this.proveType,
    this.proveUrlList,
    this.amountSymbol,
    this.applyAmountSymbol,
    this.reasonBak,
    this.reason2Bak,
    this.reason3Bak,
    this.afterSaleType,
    this.processingTypeName,
    this.afterSaleGoodsList,
    this.site,
    this.paymentNo,
    this.paymentMethod,
    this.orderPayAmount,
    this.orderUsdPayAmount,
    this.orderCnyPayAmount,
    this.siteCode,
    this.reasonZh,
    this.reason2Zh,
    this.reason3Zh,
    this.paidAt,
    this.symbol,
    this.overviewTitle,
    this.overviewStatus,
    this.overviewDescription,
    this.closeDescription,
    this.couponCode,
    this.discountStr,
    this.qty,
    this.skuCode,
  });

  String afterSaleId;
  String afterSaleNo;
  String userId;
  int status;
  String type;
  String orderNo;
  String orderToUsdRate;
  String orderToCnyRate;
  String applyAmount;
  String amount;
  String usdAmount;
  String cnyAmount;
  String refundNo;
  String email;
  String phone;
  String reason;
  String reason2;
  String reason3;
  String refundReasonType;
  String refundReason;
  String refundReason2;
  String refundReason3;
  String warehouseType;
  String description;
  String proveUrl;
  String addSource;
  String addId;
  String addName;
  String isShowToCustomer;
  String closedReason;
  String closedAt;
  String createdAt;
  String updatedAt;
  String delFlag;
  String isIntercept;
  String processingType;
  String auditAt;
  String lastModifyTime;
  String refundType;
  String couponId;
  String couponUserId;
  String auditUser;
  String refundedAt;
  String clientDescription;
  String currencyCode;
  String statusName;
  String typeName;
  String typeStr;
  int proveType;
  List<dynamic> proveUrlList;
  String amountSymbol;
  String applyAmountSymbol;
  String reasonBak;
  String reason2Bak;
  String reason3Bak;
  int afterSaleType;
  String processingTypeName;
  List<AfterSaleGoodsList> afterSaleGoodsList;
  String site;
  String paymentNo;
  String paymentMethod;
  String orderPayAmount;
  String orderUsdPayAmount;
  String orderCnyPayAmount;
  String siteCode;
  String reasonZh;
  String reason2Zh;
  String reason3Zh;
  String paidAt;
  dynamic symbol;
  String overviewTitle;
  String overviewStatus;
  String overviewDescription;
  String closeDescription;
  String couponCode;
  String discountStr;
  int qty;
  String skuCode;

  factory AfterSaleOrdersResElement.fromRawJson(String str) =>
      AfterSaleOrdersResElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AfterSaleOrdersResElement.fromJson(Map<String, dynamic> json) =>
      AfterSaleOrdersResElement(
        afterSaleId:
            json["after_sale_id"] == null ? null : json["after_sale_id"],
        afterSaleNo:
            json["after_sale_no"] == null ? null : json["after_sale_no"],
        userId: json["user_id"] == null ? null : json["user_id"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        orderNo: json["order_no"] == null ? null : json["order_no"],
        orderToUsdRate: json["order_to_usd_rate"] == null
            ? null
            : json["order_to_usd_rate"],
        orderToCnyRate: json["order_to_cny_rate"] == null
            ? null
            : json["order_to_cny_rate"],
        applyAmount: json["apply_amount"] == null ? null : json["apply_amount"],
        amount: json["amount"] == null ? null : json["amount"],
        usdAmount: json["usd_amount"] == null ? null : json["usd_amount"],
        cnyAmount: json["cny_amount"] == null ? null : json["cny_amount"],
        refundNo: json["refund_no"] == null ? null : json["refund_no"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        reason: json["reason"] == null ? null : json["reason"],
        reason2: json["reason2"] == null ? null : json["reason2"],
        reason3: json["reason3"] == null ? null : json["reason3"],
        refundReasonType: json["refund_reason_type"] == null
            ? null
            : json["refund_reason_type"],
        refundReason:
            json["refund_reason"] == null ? null : json["refund_reason"],
        refundReason2:
            json["refund_reason2"] == null ? null : json["refund_reason2"],
        refundReason3:
            json["refund_reason3"] == null ? null : json["refund_reason3"],
        warehouseType:
            json["warehouse_type"] == null ? null : json["warehouse_type"],
        description: json["description"] == null ? null : json["description"],
        proveUrl: json["prove_url"] == null ? null : json["prove_url"],
        addSource: json["add_source"] == null ? null : json["add_source"],
        addId: json["add_id"] == null ? null : json["add_id"],
        addName: json["add_name"] == null ? null : json["add_name"],
        isShowToCustomer: json["is_show_to_customer"] == null
            ? null
            : json["is_show_to_customer"],
        closedReason:
            json["closed_reason"] == null ? null : json["closed_reason"],
        closedAt: json["closed_at"] == null ? null : json["closed_at"],
        createdAt: json["created_at"] == null
            ? null
            : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        delFlag: json["del_flag"] == null ? null : json["del_flag"],
        isIntercept: json["is_intercept"] == null ? null : json["is_intercept"],
        processingType:
            json["processing_type"] == null ? null : json["processing_type"],
        auditAt: json["audit_at"] == null ? null : json["audit_at"],
        lastModifyTime: json["last_modify_time"] == null
            ? null
            : json["last_modify_time"],
        refundType: json["refund_type"] == null ? null : json["refund_type"],
        couponId: json["coupon_id"] == null ? null : json["coupon_id"],
        couponUserId:
            json["coupon_user_id"] == null ? null : json["coupon_user_id"],
        auditUser: json["audit_user"] == null ? null : json["audit_user"],
        refundedAt: json["refunded_at"] == null ? null : json["refunded_at"],
        clientDescription: json["client_description"] == null
            ? null
            : json["client_description"],
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        statusName: json["status_name"] == null ? null : json["status_name"],
        typeName: json["type_name"] == null ? null : json["type_name"],
        typeStr: json["type_str"] == null ? null : json["type_str"],
        proveType: json["prove_type"] == null ? null : json["prove_type"],
        proveUrlList: json["prove_url_list"] == null
            ? null
            : List<dynamic>.from(json["prove_url_list"].map((x) => x)),
        amountSymbol:
            json["amount_symbol"] == null ? null : json["amount_symbol"],
        applyAmountSymbol: json["apply_amount_symbol"] == null
            ? null
            : json["apply_amount_symbol"],
        reasonBak: json["reason_bak"] == null ? null : json["reason_bak"],
        reason2Bak: json["reason2_bak"] == null ? null : json["reason2_bak"],
        reason3Bak: json["reason3_bak"] == null ? null : json["reason3_bak"],
        afterSaleType:
            json["after_sale_type"] == null ? null : json["after_sale_type"],
        processingTypeName: json["processing_type_name"] == null
            ? null
            : json["processing_type_name"],
        afterSaleGoodsList: json["after_sale_goods_list"] == null
            ? null
            : List<AfterSaleGoodsList>.from(json["after_sale_goods_list"]
                .map((x) => AfterSaleGoodsList.fromJson(x))),
        site: json["site"] == null ? null : json["site"],
        paymentNo: json["payment_no"] == null ? null : json["payment_no"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        orderPayAmount:
            json["order_pay_amount"] == null ? null : json["order_pay_amount"],
        orderUsdPayAmount: json["order_usd_pay_amount"] == null
            ? null
            : json["order_usd_pay_amount"],
        orderCnyPayAmount: json["order_cny_pay_amount"] == null
            ? null
            : json["order_cny_pay_amount"],
        siteCode: json["site_code"] == null ? null : json["site_code"],
        reasonZh: json["reason_zh"] == null ? null : json["reason_zh"],
        reason2Zh: json["reason2_zh"] == null ? null : json["reason2_zh"],
        reason3Zh: json["reason3_zh"] == null ? null : json["reason3_zh"],
        paidAt:
            json["paid_at"] == null ? null : json["paid_at"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        overviewTitle:
            json["overview_title"] == null ? null : json["overview_title"],
        overviewStatus:
            json["overview_status"] == null ? null : json["overview_status"],
        overviewDescription: json["overview_description"] == null
            ? null
            : json["overview_description"],
        closeDescription: json["close_description"] == null
            ? null
            : json["close_description"],
        couponCode: json["coupon_code"] == null ? null : json["coupon_code"],
        discountStr: json["discount_str"] == null ? null : json["discount_str"],
        qty: json["qty"] == null ? null : json["qty"],
        skuCode: json["sku_code"] == null ? null : json["sku_code"],
      );

  Map<String, dynamic> toJson() => {
        "after_sale_id": afterSaleId == null ? null : afterSaleId,
        "after_sale_no": afterSaleNo == null ? null : afterSaleNo,
        "user_id": userId == null ? null : userId,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "order_no": orderNo == null ? null : orderNo,
        "order_to_usd_rate": orderToUsdRate == null ? null : orderToUsdRate,
        "order_to_cny_rate": orderToCnyRate == null ? null : orderToCnyRate,
        "apply_amount": applyAmount == null ? null : applyAmount,
        "amount": amount == null ? null : amount,
        "usd_amount": usdAmount == null ? null : usdAmount,
        "cny_amount": cnyAmount == null ? null : cnyAmount,
        "refund_no": refundNo == null ? null : refundNo,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "reason": reason == null ? null : reason,
        "reason2": reason2 == null ? null : reason2,
        "reason3": reason3 == null ? null : reason3,
        "refund_reason_type":
            refundReasonType == null ? null : refundReasonType,
        "refund_reason": refundReason == null ? null : refundReason,
        "refund_reason2": refundReason2 == null ? null : refundReason2,
        "refund_reason3": refundReason3 == null ? null : refundReason3,
        "warehouse_type": warehouseType == null ? null : warehouseType,
        "description": description == null ? null : description,
        "prove_url": proveUrl == null ? null : proveUrl,
        "add_source": addSource == null ? null : addSource,
        "add_id": addId == null ? null : addId,
        "add_name": addName == null ? null : addName,
        "is_show_to_customer":
            isShowToCustomer == null ? null : isShowToCustomer,
        "closed_reason": closedReason == null ? null : closedReason,
        "closed_at": closedAt == null ? null : closedAt,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "del_flag": delFlag == null ? null : delFlag,
        "is_intercept": isIntercept == null ? null : isIntercept,
        "processing_type": processingType == null ? null : processingType,
        "audit_at": auditAt == null ? null : auditAt,
        "last_modify_time":
            lastModifyTime == null ? null : lastModifyTime,
        "refund_type": refundType == null ? null : refundType,
        "coupon_id": couponId == null ? null : couponId,
        "coupon_user_id": couponUserId == null ? null : couponUserId,
        "audit_user": auditUser == null ? null : auditUser,
        "refunded_at": refundedAt == null ? null : refundedAt,
        "client_description":
            clientDescription == null ? null : clientDescription,
        "currency_code": currencyCode == null ? null : currencyCode,
        "status_name": statusName == null ? null : statusName,
        "type_name": typeName == null ? null : typeName,
        "type_str": typeStr == null ? null : typeStr,
        "prove_type": proveType == null ? null : proveType,
        "prove_url_list": proveUrlList == null
            ? null
            : List<dynamic>.from(proveUrlList.map((x) => x)),
        "amount_symbol": amountSymbol == null ? null : amountSymbol,
        "apply_amount_symbol":
            applyAmountSymbol == null ? null : applyAmountSymbol,
        "reason_bak": reasonBak == null ? null : reasonBak,
        "reason2_bak": reason2Bak == null ? null : reason2Bak,
        "reason3_bak": reason3Bak == null ? null : reason3Bak,
        "after_sale_type": afterSaleType == null ? null : afterSaleType,
        "processing_type_name":
            processingTypeName == null ? null : processingTypeName,
        "after_sale_goods_list": afterSaleGoodsList == null
            ? null
            : List<dynamic>.from(afterSaleGoodsList.map((x) => x.toJson())),
        "site": site == null ? null : site,
        "payment_no": paymentNo == null ? null : paymentNo,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "order_pay_amount": orderPayAmount == null ? null : orderPayAmount,
        "order_usd_pay_amount":
            orderUsdPayAmount == null ? null : orderUsdPayAmount,
        "order_cny_pay_amount":
            orderCnyPayAmount == null ? null : orderCnyPayAmount,
        "site_code": siteCode == null ? null : siteCode,
        "reason_zh": reasonZh == null ? null : reasonZh,
        "reason2_zh": reason2Zh == null ? null : reason2Zh,
        "reason3_zh": reason3Zh == null ? null : reason3Zh,
        "paid_at": paidAt == null ? null : paidAt,
        "symbol": symbol == null ? null : symbol,
        "overview_title": overviewTitle == null ? null : overviewTitle,
        "overview_status": overviewStatus == null ? null : overviewStatus,
        "overview_description":
            overviewDescription == null ? null : overviewDescription,
        "close_description": closeDescription == null ? null : closeDescription,
        "coupon_code": couponCode == null ? null : couponCode,
        "discount_str": discountStr == null ? null : discountStr,
        "qty": qty == null ? null : qty,
        "sku_code": skuCode == null ? null : skuCode,
      };
}

class AfterSaleGoodsList {
  AfterSaleGoodsList({
    this.id,
    this.userId,
    this.afterSaleNo,
    this.orderGoodsId,
    this.skuId,
    this.skuCode,
    this.isIntercept,
    this.payAmountSingle,
    this.usdPayAmountSingle,
    this.cnyPayAmountSingle,
    this.qty,
    this.deliveryStatus,
    this.createdAt,
    this.updatedAt,
    this.delFlag,
    this.name,
    this.price,
    this.priceSymbol,
    this.payAmount,
    this.payAmountStr,
    this.symbol,
    this.img,
    this.attrGroup,
    this.buttonList,
    this.isReceived,
    this.ecOrderNo,
    this.ecWarehouseOrderNo,
    this.ecWarehouseName,
    this.estimatedArrivalAt,
    this.spuId,
    this.orderGoodsPayAmount,
    this.orderGoodsUsdPayAmount,
    this.orderGoodsCnyPayAmount,
    this.dispatchedAt,
  });

  String id;
  String userId;
  String afterSaleNo;
  String orderGoodsId;
  String skuId;
  String skuCode;
  String isIntercept;
  String payAmountSingle;
  String usdPayAmountSingle;
  String cnyPayAmountSingle;
  String qty;
  String deliveryStatus;
  String createdAt;
  String updatedAt;
  String delFlag;
  String name;
  String price;
  String priceSymbol;
  String payAmount;
  String payAmountStr;
  dynamic symbol;
  String img;
  Map attrGroup;
  List<dynamic> buttonList;
  String isReceived;
  String ecOrderNo;
  String ecWarehouseOrderNo;
  String ecWarehouseName;
  String estimatedArrivalAt;
  String spuId;
  String orderGoodsPayAmount;
  String orderGoodsUsdPayAmount;
  String orderGoodsCnyPayAmount;
  dynamic dispatchedAt;

  factory AfterSaleGoodsList.fromRawJson(String str) =>
      AfterSaleGoodsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AfterSaleGoodsList.fromJson(Map<String, dynamic> json) =>
      AfterSaleGoodsList(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        afterSaleNo:
            json["after_sale_no"] == null ? null : json["after_sale_no"],
        orderGoodsId:
            json["order_goods_id"] == null ? null : json["order_goods_id"],
        skuId: json["sku_id"] == null ? null : json["sku_id"],
        skuCode: json["sku_code"] == null ? null : json["sku_code"],
        isIntercept: json["is_intercept"] == null ? null : json["is_intercept"],
        payAmountSingle: json["pay_amount_single"] == null
            ? null
            : json["pay_amount_single"],
        usdPayAmountSingle: json["usd_pay_amount_single"] == null
            ? null
            : json["usd_pay_amount_single"],
        cnyPayAmountSingle: json["cny_pay_amount_single"] == null
            ? null
            : json["cny_pay_amount_single"],
        qty: json["qty"] == null ? null : json["qty"],
        deliveryStatus:
            json["delivery_status"] == null ? null : json["delivery_status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        delFlag: json["del_flag"] == null ? null : json["del_flag"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        priceSymbol: json["price_symbol"] == null ? null : json["price_symbol"],
        payAmount: json["pay_amount"] == null ? null : json["pay_amount"],
        payAmountStr:
            json["pay_amount_str"] == null ? null : json["pay_amount_str"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        img: json["img"] == null ? null : json["img"],
        attrGroup: json["attr_group"] == null
            ? null
            : json["attr_group"],
        buttonList: json["button_list"] == null
            ? null
            : List<dynamic>.from(json["button_list"].map((x) => x)),
        isReceived: json["is_received"] == null ? null : json["is_received"],
        ecOrderNo: json["ec_order_no"] == null ? null : json["ec_order_no"],
        ecWarehouseOrderNo: json["ec_warehouse_order_no"] == null
            ? null
            : json["ec_warehouse_order_no"],
        ecWarehouseName: json["ec_warehouse_name"] == null
            ? null
            : json["ec_warehouse_name"],
        estimatedArrivalAt: json["estimated_arrival_at"] == null
            ? null
            : json["estimated_arrival_at"],
        spuId: json["spu_id"] == null ? null : json["spu_id"],
        orderGoodsPayAmount: json["order_goods_pay_amount"] == null
            ? null
            : json["order_goods_pay_amount"],
        orderGoodsUsdPayAmount: json["order_goods_usd_pay_amount"] == null
            ? null
            : json["order_goods_usd_pay_amount"],
        orderGoodsCnyPayAmount: json["order_goods_cny_pay_amount"] == null
            ? null
            : json["order_goods_cny_pay_amount"],
        dispatchedAt:
            json["dispatched_at"] == null ? null : json["dispatched_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "after_sale_no": afterSaleNo == null ? null : afterSaleNo,
        "order_goods_id": orderGoodsId == null ? null : orderGoodsId,
        "sku_id": skuId == null ? null : skuId,
        "sku_code": skuCode == null ? null : skuCode,
        "is_intercept": isIntercept == null ? null : isIntercept,
        "pay_amount_single": payAmountSingle == null ? null : payAmountSingle,
        "usd_pay_amount_single":
            usdPayAmountSingle == null ? null : usdPayAmountSingle,
        "cny_pay_amount_single":
            cnyPayAmountSingle == null ? null : cnyPayAmountSingle,
        "qty": qty == null ? null : qty,
        "delivery_status": deliveryStatus == null ? null : deliveryStatus,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "del_flag": delFlag == null ? null : delFlag,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "price_symbol": priceSymbol == null ? null : priceSymbol,
        "pay_amount": payAmount == null ? null : payAmount,
        "pay_amount_str": payAmountStr == null ? null : payAmountStr,
        "symbol": symbol == null ? null : symbol,
        "img": img == null ? null : img,
        "attr_group": attrGroup == null ? null : attrGroup,
        "button_list": buttonList == null
            ? null
            : List<dynamic>.from(buttonList.map((x) => x)),
        "is_received": isReceived == null ? null : isReceived,
        "ec_order_no": ecOrderNo == null ? null : ecOrderNo,
        "ec_warehouse_order_no":
            ecWarehouseOrderNo == null ? null : ecWarehouseOrderNo,
        "ec_warehouse_name": ecWarehouseName == null ? null : ecWarehouseName,
        "estimated_arrival_at":
            estimatedArrivalAt == null ? null : estimatedArrivalAt,
        "spu_id": spuId == null ? null : spuId,
        "order_goods_pay_amount":
            orderGoodsPayAmount == null ? null : orderGoodsPayAmount,
        "order_goods_usd_pay_amount":
            orderGoodsUsdPayAmount == null ? null : orderGoodsUsdPayAmount,
        "order_goods_cny_pay_amount":
            orderGoodsCnyPayAmount == null ? null : orderGoodsCnyPayAmount,
        "dispatched_at": dispatchedAt == null ? null : dispatchedAt,
      };
}

class AttrGroup {
  AttrGroup({
    this.color,
    this.size,
    this.option,
    this.typeOfPlug,
    this.finish,
    this.attrGroupSize,
  });

  String color;
  String size;
  String option;
  String typeOfPlug;
  String finish;
  String attrGroupSize;

  factory AttrGroup.fromRawJson(String str) =>
      AttrGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttrGroup.fromJson(Map<String, dynamic> json) => AttrGroup(
        color: json["Color"] == null ? null : json["Color"],
        size: json["Size"] == null ? null : json["Size"],
        option: json["Option"] == null ? null : json["Option"],
        typeOfPlug: json["Type Of Plug"] == null ? null : json["Type Of Plug"],
        finish: json["Finish"] == null ? null : json["Finish"],
        attrGroupSize: json["size"] == null ? null : json["size"],
      );

  Map<String, dynamic> toJson() => {
        "Color": color == null ? null : color,
        "Size": size == null ? null : size,
        "Option": option == null ? null : option,
        "Type Of Plug": typeOfPlug == null ? null : typeOfPlug,
        "Finish": finish == null ? null : finish,
        "size": attrGroupSize == null ? null : attrGroupSize,
      };
}
