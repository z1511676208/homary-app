/*
 * @Author       : JHao
 * @Date         : 2021-09-28 14:29:10
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-30 14:19:20
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class EtaInput extends StatefulWidget {
  EtaInput({Key key, this.isShowOnly = false}) : super(key: key);

  final bool isShowOnly;

  @override
  _EtaInputState createState() => _EtaInputState();
}

class _EtaInputState extends State<EtaInput> {
  String shippingFee(ShoppingCartCtrl ctrl) {
    List<Total> orderSummary = ctrl.cartData?.orderSummary ?? [];

    Total shipping = orderSummary.firstWhere(
        (element) => element.identifying == 'shipping_fee',
        orElse: () => null);
    String shippingFee = shipping?.amount ?? '';
    return shippingFee;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ShoppingCartCtrl>(context, listen: false).initZipInputData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, ShoppingCartCtrl data, Widget child) {
      return etaSiteList.contains(data.currentConfig['site'] ?? '')
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      '${S.of(context).eta_ship_to}: ',
                      style: TextStyle(
                          color: AppColor.primaryText, fontSize: 16.sp),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (!widget.isShowOnly) {
                            data.toggleETAInput();
                          }
                        },
                        child: Text(
                          data.shippingStr,
                          style: TextStyle(
                            color: AppColor.primaryText,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 3.w,
                            decorationColor: AppColor.primaryText,
                          ),
                        )),
                    Expanded(child: SizedBox()),
                    if (!widget.isShowOnly)
                      Text(
                        shippingFee(data),
                        style: TextStyle(
                            color: AppColor.primaryText, fontSize: 16.sp),
                      )
                  ],
                ),
                SizedBox(
                  height: 6.w,
                ),
                Offstage(
                  offstage: !data.showETAInput || widget.isShowOnly,
                  child: Row(
                    children: [
                      Container(
                          width: 180.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                              border: Border.all(
                                width: 1.w,
                                color: data.zipInputError != ""
                                    ? AppColor.primaryErrorTip
                                    : AppColor.primaryBorderOutline,
                              )),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: data.zipInputError == ""
                                              ? AppColor.primaryText
                                              : AppColor.primaryErrorTip,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                      onChanged: (val) {
                                        data.handleZipInputChange(val);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      cursorColor: AppColor.primaryText,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        errorMaxLines: 3,
                                        errorStyle: TextStyle(fontSize: 12.sp),
                                        hintText: 'Zip Code',
                                        hintStyle: TextStyle(
                                          color: AppColor.couponsHintColor,
                                          fontSize: 16.sp,
                                        ),
                                        border: InputBorder.none,
                                        focusColor: AppColor.primaryText,
                                        focusedBorder: InputBorder.none,
                                        suffixIcon: SizedBox(),
                                        suffixIconConstraints: BoxConstraints(
                                            maxWidth: 220.w, minHeight: 44.w),
                                      ))),
                            ],
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (data.zipInputError != "" ||
                              data.currentZipCode == "") {
                            return;
                          }
                          data.updateETA();
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            minimumSize:
                                MaterialStateProperty.all(Size(90.w, 44.w)),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.primaryText),
                            overlayColor: MaterialStateProperty.all(
                                AppColor.whiteBtnPressed),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.w),
                            ))),
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Offstage(
                    offstage: !(data.zipInputError != '') || widget.isShowOnly,
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6.w),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data.zipInputError ?? '',
                          style: TextStyle(
                              color: AppColor.primaryErrorTip, fontSize: 14.sp),
                        )))
              ],
            )
          : SizedBox();
    });
  }
}
