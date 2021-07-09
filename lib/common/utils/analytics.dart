/*
 * @Author       : JHao
 * @Date         : 2021-06-28 14:41:10
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-01 13:39:16
 */
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

//统计
FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);

Future<void> sendGTMData(Map<String, dynamic> data) async {
  String event = data['event'] ?? '';
  bool hasEvent = [
    'view_search_results',
    'view_item_list',
    'view_item',
    'view_to_cart',
    'purchase'
  ].contains(event);
  Map<String, dynamic> eventData = {};
  if (hasEvent) {
    if (data['data'] != null) {
      eventData.addAll(data['data']);
      eventData["google_business_vertical"] = "retail";
    }
    if (data['ecommerce'] != null) {
      eventData.addAll(data['ecommerce']);
      eventData["google_business_vertical"] = "retail";
    }
  }
  Map<String, dynamic> sendData = {
    "event": data["event"],
    "user_propertys": null
  };
  sendData.addAll(eventData);
  await analytics.logEvent(name: sendData["event"], parameters: sendData);
  print('LogEvent Succeeded : $sendData');
}
