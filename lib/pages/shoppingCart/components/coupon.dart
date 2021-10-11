/*
 * @Author       : JHao
 * @Date         : 2021-09-26 16:46:49
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-11 18:13:00
 */
import 'package:homary/common/utils/main.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';
import 'package:homary/pages/shoppingCart/components/CouponBottomSheet.dart';
import 'package:homary/pages/shoppingCart/components/couponSearchResult.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class CouponInput extends StatefulWidget {
  CouponInput({Key key}) : super(key: key);

  @override
  _CouponInputState createState() => _CouponInputState();
}

class _CouponInputState extends State<CouponInput>
    with SingleTickerProviderStateMixin {
  FocusNode focusNode = new FocusNode();
  AnimationController _couponSearchResultController;
  final _debouncer = Debouncer(milliseconds: 300);
  _inputListener() async {
    ShoppingCartCtrl ctrl =
        Provider.of<ShoppingCartCtrl>(context, listen: false);
    _debouncer.run(() {
      if (ctrl.inputCtrl.text == "") {
        ctrl.removeDrawCouponError();
      }
    });
  }

  void focusEventListener() async {
    ShoppingCartCtrl ctrl =
        Provider.of<ShoppingCartCtrl>(context, listen: false);
    ctrl.hanldeShowCouponSearchResult(isShow: focusNode.hasFocus);

    if (ctrl.showCouponSearchResult) {
      _couponSearchResultController.forward();
    }
  }

  bool isAcitveCoupon(ShoppingCartCtrl data) {
    return data.couponUserId != '' && data.couponUserId != 0 && !data.isApply;
  }

  // /已经用了券，并且所用的券是否是新人券
  bool isNewUserCoupon(ShoppingCartCtrl data) {
    return data.couponUserId != null &&
        !data.isApply &&
        data.activeCanUseCoupon != null &&
        data.activeCanUseCoupon.isNewUserCoupon == 1;
  }

  @override
  void initState() {
    focusNode.addListener(focusEventListener);
    _couponSearchResultController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ShoppingCartCtrl>(context, listen: false)
          .inputCtrl
          .addListener(_inputListener);
    });
    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<ShoppingCartCtrl>(context, listen: false)
        .inputCtrl
        .removeListener(_inputListener);
    super.deactivate();
  }

  @override
  void dispose() {
    _couponSearchResultController.dispose();

    focusNode.removeListener(focusEventListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, ShoppingCartCtrl data, Widget child) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.w),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.5.w, color: AppColor.primaryBorderOutline))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).coupon_code,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.sp,
                      color: AppColor.primaryText),
                ),
                GestureDetector(
                  onTap: () async {
                    if (data.isGuest) {
                      data.hanldeShowCouponSearchResult();
                      var result = await Routes.push(context, '/signIn',
                          params: {
                            'showGuestBtn': 'true',
                            'redirect_url': '/shoppingcart'
                          });
                      if (result ?? false) {
                        data.getShoppingCartData();
                      }
                    } else {
                      var couponId = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.w),
                            topRight: Radius.circular(8.w),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return SafeArea(
                              child: CouponBottomSheet(
                            data: data,
                          ));
                        },
                      );
                      if (couponId != null) {
                        data.getShoppingCartData(couponUserId: couponId);
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        isAcitveCoupon(data)
                            ? data.cartData.couponDiscount
                            : S.of(context).my_coupon,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: isAcitveCoupon(data)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isAcitveCoupon(data)
                                ? AppColor.couponTipsColor
                                : AppColor.primaryText),
                      ),
                      Icon(
                        Iconfont.ArrowRight,
                        size: 14.sp,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 241.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.w),
                        ),
                        border: Border.all(
                          width: 1.w,
                          color: data.drawCouponError == ""
                              ? AppColor.primaryBorderOutline
                              : AppColor.primaryErrorTip,
                        )),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Offstage(
                                offstage: !isNewUserCoupon(data),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20.w,
                                  child: Text(
                                    'NEW USER GIFTS',
                                    style: TextStyle(
                                        color: AppColor.couponTipsColor),
                                  ),
                                ),
                              ),
                              TextFormField(
                                  controller: data.inputCtrl,
                                  textAlignVertical: TextAlignVertical.center,
                                  focusNode: focusNode,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: AppColor.primaryText,
                                      fontSize: 16.sp),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor: AppColor.primaryText,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    errorMaxLines: 3,
                                    errorStyle: TextStyle(fontSize: 12.sp),
                                    hintText: 'Enter Code',
                                    hintStyle: TextStyle(
                                      color: AppColor.couponsHintColor,
                                      fontSize: 16.sp,
                                    ),
                                    border: InputBorder.none,
                                    focusColor: AppColor.primaryText,
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: SizedBox(),
                                    suffixIconConstraints: BoxConstraints(
                                        maxWidth: 220.w,
                                        minHeight: isNewUserCoupon(data)
                                            ? 24.w
                                            : 44.w),
                                  ))
                            ],
                          ),
                        ),
                        IconButton(
                            constraints:
                                BoxConstraints(maxHeight: 16.w, maxWidth: 16.w),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (!focusNode.hasFocus) {
                                FocusScope.of(context).requestFocus(focusNode);
                              } else {
                                data.hanldeShowCouponSearchResult();
                              }
                            },
                            icon: Icon(
                              data.showCouponSearchResult
                                  ? Iconfont.Less
                                  : Iconfont.More2,
                              color: AppColor.primaryText,
                              size: 16.sp,
                            ))
                      ],
                    )),
                ElevatedButton(
                  onPressed: () {
                    data.hanldeShowCouponSearchResult();

                    data.isApply
                        ? data.handleApplyCoupon()
                        : data.resetCouponInput();
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      minimumSize: MaterialStateProperty.all(Size(90.w, 44.w)),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primaryText),
                      overlayColor:
                          MaterialStateProperty.all(AppColor.whiteBtnPressed),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.w),
                      ))),
                  child: Text(
                    data.isApply
                        ? S.of(context).button_apply
                        : S.of(context).button_remove,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6.w,
            ),
            data.showCouponSearchResult
                ? SizeTransition(
                    sizeFactor: _couponSearchResultController,
                    child: CouponSearchResult(
                      ctrl: data,
                    ),
                  )
                : SizedBox(),
            Offstage(
                offstage: !(!data.isApply || data.drawCouponError != ''),
                child: Row(
                  children: [
                    Offstage(
                        offstage: data.drawCouponError != "",
                        child: Icon(
                          Iconfont.Tick,
                          size: 18.sp,
                          color: AppColor.couponTipsColor,
                        )),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                        child: data.drawCouponError == ""
                            ? RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: AppColor.couponTipsColor,
                                        fontSize: 16.sp),
                                    children: [
                                    TextSpan(
                                        text:
                                            "${S.of(context).shopping_cart_coupon_code_tips} "),
                                    TextSpan(
                                        text:
                                            '"${data.activeCanUseCoupon?.discountInformation ?? ''}"',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            " ${S.of(context).shopping_cart_was_applied}"),
                                  ]))
                            : Text(
                                data.drawCouponError,
                                style: TextStyle(
                                    color: AppColor.primaryErrorTip,
                                    fontSize: 14.sp),
                              ))
                  ],
                ))
          ],
        ),
      );
    });
  }
}
