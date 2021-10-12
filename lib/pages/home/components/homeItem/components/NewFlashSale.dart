/*
 * @Author       : JHao
 * @Date         : 2021-10-13 11:26:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 16:29:48
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/formatDate.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/flashModule.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';

class NewFlashSale extends StatelessWidget {
  const NewFlashSale({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, FlashData>(
      builder: (BuildContext context, FlashData data, child) {
        return data != null &&
                (data?.onSaleProduct != null &&
                    data.onSaleProduct.productList.length > 0)
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 28.w, 12.w, 0),
                child: Product(
                  data: data,
                ))
            : SizedBox();
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return homeData.flashData;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}

class Product extends StatefulWidget {
  final FlashData data;
  Product({Key key, @required this.data}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Timer _timer;
  String _upComingTime = "";
  int _serviceTime;
  String _activityTime = 'Ends Soon';

  bool _isShowActivityEndTimes(int endTime) {
    Map<String, int> time = CountdownUtils.second2HMSList(endTime);
    return time['h'] < 72 ||
        time['h'] == 72 && time['m'] == 0 && time['s'] == 0;
  }

  // 开始时间距离服务器时间小于24小时
  bool _isShowUpcomingStartInText(int timestamp) {
    int serviceTime =
        Provider.of<GlobalConfig>(context, listen: false).serviceTime;
    return timestamp - serviceTime <= 24 * 60 * 60;
  }

  bool isShowUpcoming() {
    HomeCtrl ctrl = Provider.of<HomeCtrl>(context, listen: false);
    return (ctrl.flashData?.onSaleProduct == null ||
            ctrl.flashData?.onSaleProduct != null &&
                ctrl.flashData.onSaleProduct.productList.length == 0) &&
        ctrl.flashData?.upComingProduct != null &&
        ctrl.flashData.upComingProduct.productList.length > 0;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _activityTime = S.of(context).endsSoon;
    GlobalConfig globalCtrl = Provider.of<GlobalConfig>(context, listen: false);
    int serviceTime = globalCtrl.serviceTime;
    HomeCtrl ctrl = Provider.of<HomeCtrl>(context, listen: false);
    if (serviceTime != this._serviceTime) {
      _serviceTime = serviceTime;
      if (ctrl.flashData?.onSaleProduct != null &&
          ctrl.flashData.onSaleProduct.productList.length > 0) {
        int endTime =
            ctrl.flashData.onSaleProduct.activityEndTimeStamp - _serviceTime;
        if (_isShowActivityEndTimes(endTime)) {
          _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
            setState(() {
              endTime -= 1;
              _activityTime = CountdownUtils.second2HMS(endTime);
              if (_activityTime == '00:00:00') {
                _timer.cancel();
              }
            });
          });
        }
      }

      if (isShowUpcoming()) {
        int time = ctrl.flashData.upComingProduct.activityStartTimeStamp -
            _serviceTime;
        if (_isShowUpcomingStartInText(
            ctrl.flashData.upComingProduct.activityStartTimeStamp)) {
          _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
            setState(() {
              time -= 1;
              _upComingTime = CountdownUtils.second2HMS(time);
              if (_upComingTime == '00:00:00') {
                _timer.cancel();
              }
            });
          });
        }
      }
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      // 页面销毁时触发定时器销毁
      if (_timer.isActive) {
        // 判断定时器是否是激活状态
        _timer.cancel();
      }
    }
    super.dispose();
  }

  Widget getProductItems(List<ModuleDataProductList> data) {
    List<ModuleDataProductList> productData = [];
    productData = data.length > 2 ? data.sublist(0, 2) : data;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: productData
            .asMap()
            .entries
            .map((e) => GoodsCard(
                  key: UniqueKey(),
                  showFlashSale: false,
                  showTitle: false,
                  width: (1.sw - 24.w - 11.w) / 2,
                  data: e.value,
                  onTap: () {
                    sendGTMData({
                      "event": 'custom_click_cart',
                      "ecommerce": {"event_label": e.value.eventLabel ?? ''}
                    });
                    Routes.push(context, '/webview', params: {
                      "content":
                          '{"url":"https://m.homary.com/activity-list/seckilling-goods?type=1"}'
                    });
                  },
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.data.moduleTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryText)),
            Expanded(
                child: Row(
              children: [
                SizedBox(
                  width: 6.w,
                ),
                Icon(
                  Iconfont.flashSale,
                  color: AppColor.flashSaleFontColor,
                  size: 15.sp,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  isShowUpcoming()
                      ? _isShowUpcomingStartInText(widget
                              .data.upComingProduct.activityStartTimeStamp)
                          ? '${S.of(context).home_Startsin} $_upComingTime'
                          : '${S.of(context).home_StartsAt}} ${widget.data.upComingProduct.activityStartTime}'
                      : _activityTime,
                  style:
                      TextStyle(fontSize: 15.sp, color: AppColor.primaryText),
                )
              ],
            )),
            GestureDetector(
              onTap: () {
                sendGTMData({
                  "event": 'custom_click_item',
                  "ecommerce": {"event_label": widget.data.eventLabel ?? ''}
                });
                Routes.push(context, '/webview', params: {
                  "content":
                      '{"url":"https://m.homary.com/activity-list/seckilling-goods?type=1"}'
                });
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    S.of(context).more,
                    style:
                        TextStyle(fontSize: 14.sp, color: AppColor.primaryText),
                  ),
                  Icon(
                    Iconfont.ArrowRight,
                    size: 12.w,
                    color: AppColor.primaryText,
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 16.w,
        ),
        isShowUpcoming()
            ? getProductItems(widget.data.upComingProduct.productList)
            : getProductItems(widget.data.onSaleProduct.productList)
      ],
    );
  }
}
