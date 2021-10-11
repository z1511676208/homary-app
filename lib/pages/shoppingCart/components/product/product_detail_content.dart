import 'dart:async';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:homary/common/utils/formatDate.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/components/video/video_widget.dart';
import 'package:homary/pages/shoppingCart/components/EtaInput.dart';
import 'package:homary/pages/shoppingCart/components/product/product_detail_controller.dart';
import 'package:homary/pages/shoppingCart/components/product/product_pagination.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailContent extends StatefulWidget {
  const ProductDetailContent({Key key}) : super(key: key);

  @override
  _ProductDetailContentState createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<ProductDetailContent> {
  Timer _timer;
  int _serviceTime;
  String _activityTime = '';
  String _upComingTime = "";

  double getRating(dynamic data) {
    return data is int || data is double
        ? data.toDouble()
        : data is String
            ? double.parse(data)
            : 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProductDetailCtrl ctrl = context.watch<ProductDetailCtrl>();
    if (ctrl.productInfo == null) {
      return;
    }
    int serviceTime =
        Provider.of<GlobalConfig>(context, listen: false).serviceTime;
    if (ctrl.productInfo.saleStatus == 1) {
      if (serviceTime != this._serviceTime) {
        _serviceTime = serviceTime;
        int endTime = ctrl.productInfo.activityEndTimeStamp - _serviceTime;
        if (_isShowActivityEndTimes(endTime)) {
          _timer?.cancel();
          endTime -= 1;
          _activityTime = CountdownUtils.second2HMS(endTime);
          if (_activityTime == '00:00:00') {
            _timer.cancel();
            ctrl.init();
          }
          _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
            setState(() {
              endTime -= 1;
              _activityTime = CountdownUtils.second2HMS(endTime);
              if (_activityTime == '00:00:00') {
                _timer.cancel();
                ctrl.init();
              }
            });
          });
        }
      }
    }
    if (ctrl.productInfo.saleStatus == 2) {
      if (serviceTime != this._serviceTime) {
        _serviceTime = serviceTime;
        int time = ctrl.productInfo.activityStartTimeStamp - _serviceTime;
        if (_isShowUpcomingStartInText(
            ctrl.productInfo.activityStartTimeStamp)) {
          _timer?.cancel();
          time -= 1;
          _upComingTime = CountdownUtils.second2HMS(time);
          if (_upComingTime == '00:00:00') {
            _timer.cancel();
            ctrl.init();
            return;
          }
          _timer = Timer.periodic(Duration(milliseconds: 1000), (t) {
            setState(() {
              time -= 1;
              _upComingTime = CountdownUtils.second2HMS(time);
              if (_upComingTime == '00:00:00') {
                _timer.cancel();
                ctrl.init();
              }
            });
          });
        }
      }
    }
  }

  bool _isShowActivityEndTimes(int endTime) {
    print(endTime);
    Map<String, int> time = CountdownUtils.second2HMSList(endTime);
    return time['h'] < 72 ||
        time['h'] == 72 && time['m'] == 0 && time['s'] == 0;
  }

  // 开始时间距离服务器时间小于24小时
  bool _isShowUpcomingStartInText(int timestamp) {
    return timestamp - _serviceTime <= 24 * 60 * 60;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailCtrl ctrl = context.watch<ProductDetailCtrl>();
    if (ctrl.productInfo == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: CustomScrollView(
        slivers: [
          sliverTo(SizedBox(
            height: 351.w,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.w),
                    child: CustomNetworkImage(
                      ctrl.productInfo.productImg[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              itemCount: ctrl.productInfo?.productImg?.length ?? 0,
              pagination: SwiperPagination(
                builder: ProductPagination(),
              ),
              scrollDirection: Axis.horizontal,
              autoplay: true,
              autoplayDelay: 3000,
              onTap: (index) {},
            ),
          )),
          sliverTo(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.w),
              Text(
                ctrl.productInfo.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.w),
              if ((ctrl.productStaticInfo.ratingValue != null
                      ? ctrl.productStaticInfo.ratingValue.toString()
                      : '0') !=
                  '0')
                Row(
                  children: [
                    RatingBarIndicator(
                      rating:
                          getRating(ctrl.productStaticInfo.ratingValue ?? 0),
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
                      ctrl.productStaticInfo.ratingValue != null
                          ? ctrl.productStaticInfo.ratingValue.toString()
                          : '0',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      S.of(context).product_detail_reviews(
                          ctrl.productStaticInfo.reviewCount),
                      style: TextStyle(
                        color: AppColor.primarySubTitle,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 4.w),
              ...buildPrice(context, ctrl),
              ...buildProduct(context, ctrl),
            ],
          )),
        ],
      ),
    );
  }

  Widget sliverTo(Widget widget) {
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  List<Widget> buildPrice(BuildContext context, ProductDetailCtrl ctrl) {
    return [
      if (ctrl.productInfo.saleStatus == 1)
        // 秒杀价格显示
        Container(
          height: 70.w,
          width: double.infinity,
          margin: EdgeInsets.only(top: 4.w),
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cart/flash_sale_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        ctrl.productInfo.priceSymbol,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.w,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: Text(
                          ctrl.productInfo.tagPriceSymbol ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.primaryNavBgColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.w),
                        margin: EdgeInsets.only(left: 4.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Text(
                          S.of(context).product_detail_flash_sale,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColor.offPriceColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        ctrl.productInfo.priceOffDesc ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),),
                ],
              ),),
              Container(
                width: 110.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_activityTime.contains(':')) ...[
                      Text(
                        S.of(context).product_detail_ends_in,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.w),
                    ],
                    buildTimer(_activityTime, isStart: true),
                  ],
                ),
              ),
            ],
          ),
        )
      else
        // 普通价格显示
        Row(
          children: [
            Text(
              ctrl.productInfo.priceSymbol,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.5.w,
                color: ctrl.productInfo.saleStatus == 1 ||
                        !isEmpty(ctrl.productInfo.tagPrice)
                    ? AppColor.offPriceColor
                    : AppColor.primaryText,
              ),
            ),
            SizedBox(width: 2.w),
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: Text(
                ctrl.productInfo.tagPriceSymbol ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.primarySubTitle,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: Text(
                ctrl.productInfo.priceOffDesc ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColor.offPriceColor,
                ),
              ),
            ),
          ],
        ),

      SizedBox(height: 12.w),
      // 秒杀开始预告
      if (ctrl.productInfo.saleStatus == 2) ...[
        Row(
          children: [
            Icon(
              Iconfont.flashIcon,
              size: 13.w,
              color: AppColor.offPriceColor,
            ),
            SizedBox(width: 2.5.w),
            Text(
              '${S.of(context).product_detail_flash_sale} ${ctrl.productInfo.activityPriceSymbol} ${S.of(context).product_detail_starts_in} ',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColor.offPriceColor,
              ),
            ),
            if (_isShowUpcomingStartInText(
                ctrl.productInfo.activityStartTimeStamp))
              buildTimer(_upComingTime)
            else
              Text(
                ctrl.productInfo.activityStartTime,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColor.offPriceColor,
                ),
              ),
          ],
        ),
        SizedBox(height: 12.w),
      ],
      // 清仓活动
      if (ctrl.productInfo.activityType.toString() == '2') ...[
        Row(
          children: [
            Text(
              S.of(context).product_detail_clearance,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.offPriceColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              margin: EdgeInsets.only(left: 4.w),
              decoration: BoxDecoration(
                color: Color(0xffffecec),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Text(
                ctrl.productInfo.clearanceText ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColor.offPriceColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.w),
      ],
      if (ctrl.isShowLabel) ...[
        Row(
          children: [
            Text(
              ctrl.stockLabel ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.stockColor,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              ctrl.dispatchLabel ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.w),
      ],

      if (ctrl.productInfo.status != 3 ||
          ctrl.productInfo.activityType != 2) ...[
        Text(
          S.of(context).product_detail_free_shipping,
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 4.w),
        Text(
          '${S.of(context).shopping_cart_delivery_time}${isEmpty(ctrl.deliveryTime) ? ctrl.productInfo.deliveryTimeStr : ctrl.deliveryTime}',
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.w),
        EtaInput(isShowOnly: true),
      ],
    ];
  }

  Widget buildTimer(String time, {bool isStart = false}) {
    List<String> list = time.split(':');
    if (list.isEmpty || list.length == 1) {
      return Text(
        S.of(context).endsSoon,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
          color: Colors.white,
        ),
      );
    }

    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      widgetList.add(Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: isStart ? Colors.white : null,
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(
            color: AppColor.offPriceColor,
            width: 0.5.w,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          list[i],
          style: TextStyle(
            fontSize: 12.sp,
            color: isStart ? null : AppColor.offPriceColor,
          ),
        ),
      ));
      if (i != list.length - 1) {
        widgetList.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
          child: Text(
            ':',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: isStart ? Colors.white : AppColor.offPriceColor,
            ),
          ),
        ));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgetList,
    );
  }

  List<Widget> buildProduct(BuildContext context, ProductDetailCtrl ctrl) {
    return [
      SizedBox(height: 10.w),
      buildProductOverview(context, ctrl),
      buildDescription(context, ctrl),
      buildWeights(context, ctrl),
      buildSpecification(context, ctrl),
      buildFeatures(context, ctrl),
    ];
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildProductOverview(BuildContext context, ProductDetailCtrl ctrl) {
    if (isEmpty(ctrl.productStaticInfo.productOverview)) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(S.of(context).product_detail_product_overview),
        SizedBox(height: 12.w),
        Container(
          color: AppColor.sheetBgColor,
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 8.w,
          ),
          child: Column(
            children: ctrl.productStaticInfo.productOverview.map((e) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4.w,
                ),
                child: Row(
                  children: [
                    CustomNetworkImage(
                      e.overviewImg,
                      width: 30.w,
                      height: 30.w,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        e.value,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20.w),
      ],
    );
  }

  Widget buildDescription(BuildContext context, ProductDetailCtrl ctrl) {
    if (isEmpty(ctrl.productStaticInfo.description)) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(S.of(context).product_detail_description),
        SizedBox(height: 12.w),
        HtmlWidget(
          ctrl.productStaticInfo.description,
          textStyle: TextStyle(
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 20.w),
      ],
    );
  }

  Widget buildWeights(BuildContext context, ProductDetailCtrl ctrl) {
    final weightDimension = ctrl.productStaticInfo.weightDimension;
    if (weightDimension == null ||
        (isEmpty(weightDimension.dimensionAttr) &&
            isEmpty(weightDimension.dimensionImg))) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(S.of(context).product_detail_weights_dimensions),
        SizedBox(height: 12.w),
        ...(weightDimension.dimensionImg ?? []).map((e) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: CustomNetworkImage(
              e['img_url'],
              width: double.infinity,
            ),
          );
        }).toList(),
        ...(weightDimension.dimensionAttr ?? []).asMap().entries.map((e) {
          return Column(
            children: [
              Container(
                height: 0.5.w,
                width: double.infinity,
                color: AppColor.primaryBorderOutline,
              ),
              Container(
                child: IntrinsicHeight(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Container(
                      color: AppColor.sheetBgColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.w, horizontal: 12.w),
                      child: Text(
                        e.value.key,
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.w, horizontal: 12.w),
                      color: Colors.white,
                      child: Text(
                        e.value.value,
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    )),
                  ],
                )),
              ),
              if (e.key + 1 == (weightDimension.dimensionAttr ?? []).length)
                Container(
                  height: 0.5.w,
                  width: double.infinity,
                  color: AppColor.primaryBorderOutline,
                ),
            ],
          );
        }).toList(),
        SizedBox(height: 20.w),
      ],
    );
  }

  Widget buildSpecification(BuildContext context, ProductDetailCtrl ctrl) {
    final additionalDocument = ctrl.productStaticInfo.additionalDocument;
    if (additionalDocument == null ||
        (isEmpty(additionalDocument.files) &&
            isEmpty(additionalDocument.videoUrl))) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(S.of(context).product_detail_specification),
        SizedBox(height: 12.w),
        Text(
          S.of(context).product_detail_additional_document,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.w),
        ...(additionalDocument.files ?? []).map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.5.w),
            child: GestureDetector(
              onTap: () async {
                if (await canLaunch(e.url)) {
                  launch(e.url);
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/cart/pdf.png',
                    width: 14.w,
                    height: 14.w,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    e.name,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        if (!isEmpty(additionalDocument.videoUrl)) ...[
          SizedBox(
            height: 12,
          ),
          VideoWidget(url: additionalDocument.videoUrl),
        ],
        SizedBox(height: 20.w),
      ],
    );
  }

  Widget buildFeatures(BuildContext context, ProductDetailCtrl ctrl) {
    final details = ctrl.productStaticInfo.details;
    if (details == null || isEmpty(details)) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(S.of(context).product_detail_features),
        SizedBox(height: 12.w),
        ...details.asMap().entries.map((e) {
          return Column(
            children: [
              Container(
                height: 0.5.w,
                width: double.infinity,
                color: AppColor.primaryBorderOutline,
              ),
              Container(
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: Container(
                        color: AppColor.sheetBgColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.w, horizontal: 12.w),
                        child: Text(
                          e.value.key,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.w, horizontal: 12.w),
                        color: Colors.white,
                        child: Text(
                          e.value.value,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              if (e.key + 1 == details.length)
                Container(
                  height: 0.5.w,
                  width: double.infinity,
                  color: AppColor.primaryBorderOutline,
                ),
            ],
          );
        }).toList(),
        SizedBox(height: 20.w),
      ],
    );
  }
}
