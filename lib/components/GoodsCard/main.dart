/*
 * @Author       : JHao
 * @Date         : 2021-07-22 17:26:36
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-29 19:56:31
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homary/common/utils/formatDate.dart';
import 'package:homary/common/utils/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';

import 'package:homary/widget/networkImg.dart';

class GoodsCard extends StatefulWidget {
  final double width;
  final double height;
  final dynamic data;
  final String moduleName;
  final double marginRight;
  final bool showCorner; // 是否显示角标
  final bool showSkuList; // 是否显示 sku 切换列表
  final bool showFreeShipping; // 是否显示Free Shipping
  final bool showRating; // 是否显示评分
  GoodsCard(
      {Key key,
      this.width,
      this.height,
      this.data,
      this.moduleName,
      this.showCorner = true,
      this.showSkuList = false,
      this.showFreeShipping = false,
      this.showRating = false,
      this.marginRight = 0})
      : super(key: key);

  @override
  _GoodsCardState createState() => _GoodsCardState();
}

class _GoodsCardState extends State<GoodsCard> {
  dynamic _currentData;
  int _serviceTime;
  Timer _timer;
  String _activityTime = 'Ends Soon';

  @override
  void initState() {
    super.initState();
    _currentData = widget.data;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_currentData.activityStatus == 1) {
      int serviceTime =
          Provider.of<GlobalConfig>(context, listen: false).serviceTime;
      if (serviceTime != this._serviceTime) {
        _serviceTime = serviceTime;
        int endTime = _currentData.activityEndTimeStamp - _serviceTime;
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

  bool _isShowActivityEndTimes(int endTime) {
    Map<String, int> time = CountdownUtils.second2HMSList(endTime);
    return time['h'] < 72 ||
        time['h'] == 72 && time['m'] == 0 && time['s'] == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.only(right: widget.marginRight),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryBorderShadow,
            blurRadius: 4.w,
            spreadRadius: 1.w,
            offset: Offset(1.w, 1.w),
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: AppStyle.primaryBorderRaduis,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomNetworkImage(
                    _currentData.imgUrl,
                    width: widget.width,
                    height: widget.width,
                  ),
                  _currentData.activityStatus == 1
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: widget.width,
                            height: 24.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/common/goods_card_bg.png',
                                    ),
                                    fit: BoxFit.cover)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: widget.width / 2,
                                  child: Center(
                                      child: Text(_currentData.priceSymbol,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp))),
                                ),
                                Container(
                                  width: widget.width / 2,
                                  margin: EdgeInsets.only(bottom: 2.w),
                                  alignment: Alignment.bottomCenter,
                                  child: Text(_activityTime,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp)),
                                ),
                              ],
                            ),
                          ))
                      : Container(),
                  widget.showCorner == true && _currentData.cornerBgUrl != null
                      ? Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                              width: widget.moduleName == 'favoredList'
                                  ? 36.w
                                  : 38.w,
                              height: widget.moduleName == 'favoredList'
                                  ? 16.w
                                  : 36.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          _currentData.cornerBgUrl),
                                      fit: BoxFit.cover)),
                              child: Center(
                                child: Text(
                                  _currentData.cornerText,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.sp),
                                ),
                              )))
                      : Container(),
                  _currentData.status != 1
                      ? Container(
                          width: 90.w,
                          height: 90.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.4)),
                          child: Text(
                            'Sold Out',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ))
                      : Container()
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.w),
                  color: Colors.white,
                  child: Column(
                    children: [
                      widget.showSkuList == true
                          ? widget.data?.mergeSkuList != null &&
                                  widget.data.mergeSkuList.length > 0
                              ? Container(
                                  height: 25.w,
                                  margin: EdgeInsets.only(top: 8.w),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) =>
                                        GestureDetector(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        child: Container(
                                          width: 25.w,
                                          height: 25.w,
                                          padding: EdgeInsets.all(2.w),
                                          margin: EdgeInsets.only(right: 2.w),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.w,
                                                  color: _currentData.skuId ==
                                                          widget
                                                              .data
                                                              .mergeSkuList[
                                                                  index]
                                                              .skuId
                                                      ? AppColor.primaryColor
                                                      : AppColor
                                                          .primaryBorderOutline)),
                                          child: CustomNetworkImage(widget.data
                                              .mergeSkuList[index]?.imgUrl),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _currentData =
                                              widget.data.mergeSkuList[index];
                                        });
                                      },
                                    ),
                                    itemCount: widget.data.mergeSkuList.length,
                                  ),
                                )
                              : Container(
                                  height: 25.w,
                                  margin: EdgeInsets.only(top: 8.w),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.data.mergeSkuDesc,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColor.primarySubTitle,
                                        fontSize: 12.sp),
                                  ),
                                )
                          : Container(),
                      Container(
                        height: 44.w,
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        alignment: Alignment.topLeft,
                        child: Text(
                          _currentData.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColor.primaryText, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 4.w),
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: _currentData.priceSymbol ??
                                  _currentData.price,
                              style: TextStyle(
                                  color: _currentData.activityStatus == 1
                                      ? AppColor.offPriceColor
                                      : AppColor.primaryText,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            _currentData.activityStatus == 1
                                ? TextSpan(
                                    text: _currentData.tagPriceSymbol
                                            ?.toString() ??
                                        _currentData.tagPrice?.toString(),
                                    style: TextStyle(
                                      color: AppColor.primarySubTitle,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : TextSpan(
                                    text: '',
                                  ),
                          ]),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: _currentData.priceOffDesc,
                              style: TextStyle(
                                  color: AppColor.offPriceColor,
                                  fontSize: 12.sp),
                            ),
                          ]),
                        ),
                      ),
                      widget.showRating
                          ? Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: _currentData.reviewScore is int
                                        ? _currentData.reviewScore.toDouble()
                                        : 0,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Color(0xFFFFB400),
                                    ),
                                    unratedColor: Color(0xFFE3E3E3),
                                    itemCount: 5,
                                    itemSize: 15.w,
                                    direction: Axis.horizontal,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    _currentData.reviewNum != null
                                        ? _currentData.reviewNum.toString()
                                        : '0',
                                    style: TextStyle(
                                        color: AppColor.primarySubTitle,
                                        fontSize: 13.sp),
                                  ),
                                ],
                              ))
                          : Container(),
                      widget.showFreeShipping
                          ? Container(
                              padding: EdgeInsets.only(top: 8.w),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Free Shipping',
                                style: TextStyle(
                                  color: AppColor.primaryText,
                                  fontSize: 12.sp,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
