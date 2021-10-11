/*
 * @Author       : JHao
 * @Date         : 2021-09-27 13:49:12
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-11 16:08:51
 */
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class CouponSearchResult extends StatefulWidget {
  final ShoppingCartCtrl ctrl;
  CouponSearchResult({Key key, @required this.ctrl}) : super(key: key);

  @override
  _CouponSearchResultState createState() => _CouponSearchResultState();
}

class _CouponSearchResultState extends State<CouponSearchResult> {
  final _debouncer = Debouncer(milliseconds: 200);
  _inputListener() async {
    _debouncer.run(() => {
          if (mounted)
            {
              widget.ctrl.handleSearchCoupon(params: {
                "keyword": widget.ctrl.inputCtrl.text,
                'sku_ids': widget.ctrl.skuIdQtyList
              })
            }
        });
  }

  handleGuestLogin() async {
    var result = await Routes.push(context, '/signIn',
        params: {'showGuestBtn': 'true', 'redirect_url': '/shoppingcart'});
    if (result ?? false) {
      widget.ctrl.getShoppingCartData();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.ctrl.inputCtrl.addListener(_inputListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      widget.ctrl.handleSearchCoupon(params: {
        "keyword": widget.ctrl.inputCtrl.text,
        'sku_ids': widget.ctrl.skuIdQtyList
      });
    });
  }

  @override
  void dispose() {
    widget.ctrl.inputCtrl.removeListener(_inputListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 6.w, top: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryBorderShadow,
              blurRadius: 4.w,
              spreadRadius: 1.w,
              offset: Offset(0.w, 1.w),
            )
          ],
          color: Colors.white,
        ),
        child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.ctrl.couponSearchLoading
                    ? Container(
                        height: 50.w,
                        color: Colors.white,
                        child: Center(
                            child: SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColor.primaryText,
                          ),
                        )))
                    : widget.ctrl.bestCouponList != null &&
                            widget.ctrl.bestCouponList.length > 0
                        ? ListView.builder(
                            clipBehavior: Clip.none,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  child: Container(
                                      height: 30.w,
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 6.w),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: widget
                                                      .ctrl
                                                      .bestCouponList[index]
                                                      .isNewUserCoupon ==
                                                  1
                                              ? Border.all(
                                                  width: 1.w,
                                                  color:
                                                      AppColor.couponTipsColor)
                                              : null,
                                          image: widget
                                                      .ctrl
                                                      .bestCouponList[index]
                                                      .isNewUserCoupon ==
                                                  1
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                    'https://img1.homary.com/common/2021/08/05/1a63b87e8b576a65299ceceab255b344.png',
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                  alignment:
                                                      Alignment.centerLeft)
                                              : null),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widget
                                                        .ctrl
                                                        .bestCouponList[index]
                                                        .isNewUserCoupon ==
                                                    1
                                                ? 60.w
                                                : 12.w),
                                        child: Text(
                                          widget.ctrl.bestCouponList[index]
                                              .associateInformation,
                                          style: TextStyle(
                                              color: widget
                                                          .ctrl
                                                          .bestCouponList[index]
                                                          .isNewUserCoupon ==
                                                      1
                                                  ? AppColor.couponTipsColor
                                                  : AppColor.primaryText,
                                              fontSize: 15.sp),
                                        ),
                                      )),
                                  onTap: () async {
                                    // 选择的是当前的优惠券，直接返回

                                    if (widget.ctrl.bestCouponList[index]
                                            .couponUserId
                                            .toString() ==
                                        widget.ctrl.couponUserId.toString()) {
                                      widget.ctrl.inputCtrl.text = widget.ctrl
                                          .bestCouponList[index].couponAlias;
                                      widget.ctrl
                                          .hanldeShowCouponSearchResult();
                                      return;
                                    }
                                    // 下拉手动选中劵，如果未领取需要领取
                                    if (widget.ctrl.bestCouponList[index]
                                            .couponUserId
                                            .toString() ==
                                        CouponStatusEnum.noApplyCoupon
                                            .toString()) {
                                      await widget.ctrl.applyCoupon(widget.ctrl
                                          .bestCouponList[index].couponAlias);
                                    } else {
                                      // 下拉选中的劵已领取时直接刷页面重新计算金额
                                      widget.ctrl.inputCtrl.text = widget.ctrl
                                          .bestCouponList[index].couponAlias;
                                      widget.ctrl.couponUserId = widget.ctrl
                                          .bestCouponList[index].couponUserId;
                                    }
                                    widget.ctrl.hanldeShowCouponSearchResult();

                                    Localstorage().setGaTicketList(
                                        TicketList.beginCheckout);
                                    widget.ctrl.getShoppingCartData(
                                        couponUserId: widget.ctrl.couponUserId);
                                  });
                            },
                            itemCount: widget.ctrl.bestCouponList.length,
                          )
                        : Container(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 16.w),
                                child: Text(
                                    S.of(context).shopping_cart_no_results,
                                    style: TextStyle(
                                        color: AppColor.primaryText,
                                        fontSize: 15.sp)))),
                Offstage(
                    offstage: !widget.ctrl.isGuest,
                    child: GestureDetector(
                        onTap: () async {
                          this.handleGuestLogin();
                        },
                        child: Container(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 12.w, right: 12.w, bottom: 16.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(S.of(context).shopping_cart_login_tips,
                                        style: TextStyle(
                                            color: AppColor.primaryText,
                                            fontSize: 15.sp)),
                                    Icon(
                                      Iconfont.ArrowRight,
                                      size: 12.sp,
                                    )
                                  ],
                                )))))
              ],
            )));
  }
}
