/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-03 18:56:47
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/flashModule.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/home/contorller.dart';

class FlashSale extends StatefulWidget {
  FlashSale({Key key}) : super(key: key);

  @override
  _FlashSaleState createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  bool _isOnSaleNow = true;
  String _currentSite;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var currentConfig = Localstorage().getJSON('currentConfig') ?? {};
    _currentSite = currentConfig['site'];
  }

  @override
  Widget build(BuildContext context) {
    var config = Localstorage().getJSON('currentConfig') ?? {};
    if (config['site'] != _currentSite) {
      _currentSite = config['site'];
      _isOnSaleNow = true;
    }
    return SliverToBoxAdapter(
        child: Selector<HomeCtrl, FlashData>(
      builder: (BuildContext context, FlashData data, child) {
        return data != null &&
                (data?.onSaleProduct != null &&
                        data.onSaleProduct.productList.length > 0 ||
                    data.upComingProduct != null &&
                        data.upComingProduct.productList.length > 0)
            ? Column(
                children: [
                  Container(
                    height: 82.w,
                    padding: EdgeInsets.fromLTRB(12.w, 14.w, 12.w, 14.w),
                    margin: EdgeInsets.only(top: 20.w),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/home/flash_sale_bg.png'),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              data.moduleTitle,
                              style: TextStyle(
                                  color: AppColor.flashSaleFontColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              Iconfont.flashIcon,
                              size: 16.sp,
                              color: AppColor.flashSaleFontColor,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                color: AppColor.flashSaleFontColor,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: Text(
                                data.moduleDesc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColor.flashSaleFontColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        Flexible(child: Container()),
                        Row(
                          children: [
                            Offstage(
                              offstage:
                                  data.onSaleProduct.productList.length == 0,
                              child: GestureDetector(
                                child: Text(S.of(context).home_OnSalenow,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.transparent,
                                      fontWeight: _isOnSaleNow
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      shadows: [
                                        Shadow(
                                            color: AppColor.primaryText,
                                            offset: Offset(0, -4))
                                      ],
                                      decoration: _isOnSaleNow
                                          ? TextDecoration.underline
                                          : null,
                                      decorationColor: AppColor.primaryText,
                                    )),
                                onTap: () {
                                  setState(() {
                                    _isOnSaleNow = true;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Offstage(
                              offstage:
                                  data.upComingProduct.productList.length == 0,
                              child: GestureDetector(
                                  child: Text(S.of(context).home_Upcoming,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.transparent,
                                        fontWeight: _isOnSaleNow
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                              color: AppColor.primaryText,
                                              offset: Offset(0, -4))
                                        ],
                                        decoration: _isOnSaleNow
                                            ? null
                                            : TextDecoration.underline,
                                        decorationColor: AppColor.primaryText,
                                      )),
                                  onTap: () {
                                    setState(() {
                                      _isOnSaleNow = false;
                                    });
                                  }),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Routes.push(context, '/webview', params: {
                                  "content":
                                      '{"url":"https://m.homary.com/activity-list/seckilling-goods?type=1"}'
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).viewAll,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.primaryLightSubTitle),
                                  ),
                                  Icon(
                                    Iconfont.ArrowRight,
                                    size: 12.w,
                                    color: AppColor.primaryLightSubTitle,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.w),
                    color: AppColor.flashSaleBackgroundColor,
                    child: Container(
                      height: _isOnSaleNow ? 230.w : 246.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        clipBehavior: Clip.none,
                        itemBuilder: (BuildContext ctx, int index) {
                          return GoodsCard(
                              key: UniqueKey(),
                              width: 140.w,
                              marginRight: 8.w,
                              data: _isOnSaleNow
                                  ? data.onSaleProduct.productList[index]
                                  : data.upComingProduct.productList[index]);
                        },
                        itemCount: _isOnSaleNow
                            ? data.onSaleProduct.productList.length
                            : data.upComingProduct.productList.length,
                      ),
                    ),
                  )
                ],
              )
            : Container();
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
