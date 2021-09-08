/*
 * @Author       : JHao
 * @Date         : 2021-06-28 14:41:10
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-08 14:04:53
 */

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:homary/common/config/storage.dart';
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

//统计
FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);

Future<void> sendGTMData(Map<String, dynamic> data) async {
  Map<String, dynamic> eventData = {};
  if (data['data'] != null) {
    eventData.addAll(data['data']);
  }
  if (data['ecommerce'] != null) {
    eventData.addAll(data['ecommerce']);
  }
  eventData["google_business_vertical"] = "retail";
  if (eventData['value'] != null) {
    eventData['value'] = double.parse(eventData['value'].toString());
  }
  Map<String, dynamic> sendData = {
    ...data,
    "event": data["event"],
    "ecommerce": data['data'] ?? data['ecommerce'] ?? null,
    "user_propertys": getUserInfo()
  };
  sendData.addAll(eventData);
  await analytics.logEvent(name: sendData["event"], parameters: sendData);
  print('LogEvent Succeeded : $sendData');
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
