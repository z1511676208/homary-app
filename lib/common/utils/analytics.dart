/*
 * @Author       : JHao
 * @Date         : 2021-06-28 14:41:10
 * @LastEditors  : JHao
 * @LastEditTime : 2022-01-04 14:25:25
 */

import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/config/storage.dart';
import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/utils/localstorage.dart';

// 曝光埋点name
Map<String, String> itemListName = {
  "HomeFlashSale": 'Home Flash Sale',
  "SeckillingFlashSale": 'Seckilling Flash Sale',
  "HomeFavoredbyCustomers": 'Home Favored by Customers',
  "HomeHomaryStyle": 'Home Homary Style',
  "Lego": 'Lego Page',
  "ProductDetailsCustomersAlsoViewed": 'Product Details Customers Also Viewed',
  "Activity": 'Activity',
  "wishlist": 'Wishlist',
  "Tracks": 'Tracks',
  "HomeReviews": 'Real Reviews From Real Customers',
  "TodaysDeals": "Today's Deals",
  "MarketActivity": 'Market Activity',
  "combineBuyGoods": 'Combine Buy Goods',
  "ShoppingcartJustForYou": 'Shoppingcart Just For You'
};

//商品流处理需要自定义事件
const goodsPointCustomEvent = [
  'viewitem_buytogether_click',
  'view_itemadded',
  'itemadded_checkout_click',
  'itemadded_viewcart_click',
  'itemadded_alsolike_click',
  'shippingcart_top_checkout_click',
  'shippingcart_bottom_checkout_click',
  'shippingcart_saveforlater_click',
  'shippingcart_movetocart_click',
  'shippingcart_block_checkout_click',
  'itemadded_buytogether_click',
  'viewitem_view_bundleitem',
  'itemadded_view_bundleitem',
  'view_lego_itemlable_item',
  'select_lego_itemlable_item'
];

// 自定义字段
Map<String, dynamic> customData = {
  "event_label": '', // event_label事件标签要为唯一值，需要产品确认该值，默认为''
  "event_category": 'custom',
  // non_interaction 此字段表示进页面自动触发，非手动点击触发 (默认为true)
  "non_interaction": true
};

class TicketList {
  static String cart = "view_cart";
  static String beginCheckout = "begin_checkout";
} // 需要验证ticket是否存在才执行上报操作

List<String> ticketList = [TicketList.cart, TicketList.beginCheckout];

//统计
FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);

Future<void> sendGTMData(Map<String, dynamic> data,
    {bool isCustomEvent = false}) async {
  Map<String, dynamic> eventData = {};
  if (data['data'] != null) {
    eventData.addAll(data['data']);
  }
  if (data['ecommerce'] != null) {
    eventData.addAll(data['ecommerce']);
  }
  eventData["google_business_vertical"] = "retail";
  if (eventData['value'] != null) {
    try {
      eventData['value'] = double.parse(eventData['value'].toString());
    } catch (e) {
      eventData['value'] = eventData['value'];
    }
  }
  Map<String, dynamic> sendData = {};
  if (goodsPointCustomEvent.contains(data['event']) ||
      (data['event'] as String).contains('custom_') ||
      isCustomEvent) {
    if (goodsPointCustomEvent.contains(data['event']) || isCustomEvent) {
      data["event"] = 'custom_${data["event"]}';
      customData['non_interaction'] = false;
    }
    customData.addAll(data['data'] ?? data['ecommerce'] ?? {});
    sendData = {
      ...data,
      "event": data["event"],
      "custom_data": customData,
      "user_propertys": getUserInfo()
    };
  } else {
    sendData = {
      ...data,
      "event": data["event"],
      "ecommerce": data['data'] ?? data['ecommerce'] ?? null,
      "user_propertys": getUserInfo()
    };
  }

  sendData.addAll(eventData);
  // Firebase purchase 事件要求 quantity price 为 Number类型
  if (sendData['event'] == 'purchase') {
    if (sendData['items'] != null && sendData['items'] is List) {
      (sendData['items'] as List).forEach((element) {
        try {
          element['quantity'] = double.parse(element['quantity'].toString());
          element['price'] = double.parse(element['price'].toString());
        } catch (e) {
          element['quantity'] = element['quantity'];
          element['price'] = element['price'];
        }
      });
    }
  }
  if (ticketList.contains(data["event"])) {
    Cookie webviewTicketList = await getCookie(StorageKey.GA_TICKET_LIST);
    if (webviewTicketList != null) {
      List _ticketList = [];
      try {
        _ticketList = jsonDecode(Uri.decodeComponent(webviewTicketList.value));
      } catch (e) {}

      if (_ticketList.contains(data["event"])) {
        await analytics.logEvent(name: sendData["event"], parameters: sendData);
        Localstorage().removeGaTicketList(data["event"]);
        print('LogEvent Succeeded : $sendData');
      }
    }
  } else {
    await analytics.logEvent(name: sendData["event"], parameters: sendData);
    print('LogEvent Succeeded : $sendData');
  }
}

getUserInfo() {
  var userInfo = Localstorage().getJSON(StorageKey.USER_INFO);
  if (userInfo != null) {
    userInfo = {
      "email": userInfo["email"],
      "first_name": userInfo["first_name"],
      "last_name": userInfo["last_name"],
      "id": userInfo["id"],
      "user_id": userInfo["user_id"]
    };
  }
  return userInfo;
}

// 商品卡片上报
sendProductItemGTM(
    {List<Map> data,
    String itemListName,
    String eventName,
    Map<String, dynamic> extraParms}) {
  List pointList = data;
  List<Map> currenPointList = [];
  pointList.asMap().entries.map((entry) {
    int idx = entry.key;
    dynamic e = entry.value;
    return currenPointList.add({
      "item_name": e['title'], // Name or ID is required.
      "item_id": e['sku_code'],
      "price": e['price'],
      "item_brand": 'homary',
      "item_category": e['spu_category_name_first'],
      "item_category2": e['spu_category_name_second'],
      "item_category3": e['spu_category_name_third'],
      "item_category4": e['spu_category_name_fourth'],
      "item_variant": '',
      "item_list_name": itemListName,
      "item_list_id": "",
      "index": idx + 1,
      "quantity": 1
    });
  }).toList();
  Map<String, dynamic> ecommerce = {
    "items": currenPointList,
    "item_list_id": "",
    "item_list_name": itemListName,
  };
  if (extraParms != null) {
    ecommerce.addAll(extraParms);
  }
  sendGTMData({"event": eventName, "ecommerce": ecommerce});
}
