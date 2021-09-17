import 'package:flutter/services.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/product_attr_res.dart';
import 'package:homary/pages/categoryTab/controller.dart';
import 'package:homary/widget/networkImg.dart';

class FilterProperty extends StatelessWidget {
  const FilterProperty({Key key, this.productAttrMain}) : super(key: key);

  final ProductAttrMain productAttrMain;

  @override
  Widget build(BuildContext context) {
    List<String> activedSelectList =
        Provider.of<CategoryTabCtrl>(context, listen: false).activedSelectList;
    return Theme(
        data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            unselectedWidgetColor: AppColor.primaryBorderOutline,
            checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w)))),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5.w, color: AppColor.primaryBorderBottomLine))),
          child: ExpansionTile(
            initiallyExpanded: productAttrMain.isExpand,
            onExpansionChanged: (isExpand) {
              productAttrMain.isExpand = isExpand;
            },
            iconColor: AppColor.primaryText,
            collapsedIconColor: AppColor.primaryText,
            title: Row(
              children: [
                Text(
                  productAttrMain.pnValue ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Offstage(
                    offstage:
                        !activedSelectList.contains(productAttrMain.pnValue),
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor, shape: BoxShape.circle),
                    )),
              ],
            ),
            children: [
              _PropertyWidget(
                key: ['2', '3'].contains(productAttrMain.type)
                    ? UniqueKey()
                    : null,
                productAttrMain: productAttrMain,
                propertyList: productAttrMain.filterData,
              ),
            ],
          ),
        ));
  }
}

class _PropertyWidget extends StatefulWidget {
  const _PropertyWidget({Key key, this.propertyList, this.productAttrMain})
      : super(key: key);

  final List<ProductAttrFilterDatum> propertyList;
  final ProductAttrMain productAttrMain;

  @override
  __PropertyWidgetState createState() => __PropertyWidgetState();
}

class __PropertyWidgetState extends State<_PropertyWidget> {
  List<ProductAttrFilterDatum> _propertyList = [];

  @override
  void initState() {
    super.initState();
    _propertyList.addAll(widget.propertyList);
  }

  @override
  Widget build(BuildContext context) {
    return getFilterWidget();
  }

  Widget getFilterWidget() {
    Map<String, Widget> filterWidgetList = {
      "1": filterCheckboxWidget(),
      "2": filterInputWidget(pvId: widget.productAttrMain.pnId.toString()),
      "3": filterInputWidget(pvId: "Price"),
      "4": filterImageWidget(),
    };
    return filterWidgetList[widget.productAttrMain.type.toString()];
  }

  // 价格 属性筛选
  Widget filterInputWidget({@required String pvId}) {
    CategoryTabCtrl ctrl = Provider.of<CategoryTabCtrl>(context, listen: false);
    var datum =
        ctrl.selectedFilterList.where((item) => item.pvId == pvId).toList();
    var initialDatum = datum.length > 0 ? datum[0].pvValue.split("~") : [];
    double minNumber =
        initialDatum.length > 0 ? double.parse(initialDatum[0]) : 0;
    double maxNumber =
        initialDatum.length > 0 ? double.parse(initialDatum[1]) : 0;

    return Container(
        padding: EdgeInsets.only(bottom: 16.w),
        margin: EdgeInsets.only(top: 1.w),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 12.w,
          ),
          validatorInput(
              label: "Min",
              initialValue: minNumber == 0 ? '' : minNumber.toString(),
              validatorFn: (String value) {
                if (value == "") {
                  return null;
                }
                double val = double.parse(value == "" ? '0' : value);
                maxNumber = maxNumber == 0
                    ? widget.productAttrMain.numberMax.toDouble()
                    : maxNumber;
                return widget.productAttrMain.numberMin <= val &&
                        val <= maxNumber
                    ? null
                    : S.of(context).rangeLimitError(
                        widget.productAttrMain.numberMin, maxNumber);
              },
              onChanged: (String value) {
                if (value == "" && maxNumber == 0) {
                  ctrl.removeSelectedFilterItem(pvId);
                  ctrl.setActivedSelectList();
                  return;
                }
                minNumber = double.parse(value == "" ? '0' : value);
                maxNumber = maxNumber == 0
                    ? widget.productAttrMain.numberMax.toDouble()
                    : maxNumber;
                minNumber = maxNumber >= minNumber
                    ? minNumber
                    : widget.productAttrMain.numberMin.toDouble();

                ctrl.triggerSelectedFilterList(ProductAttrFilterDatum.fromJson({
                  "is_channel": widget.productAttrMain.isChannel,
                  "pv_id": pvId,
                  "pv_value": "$minNumber~$maxNumber",
                  "pn_value": widget.productAttrMain.pnValue,
                  "is_disabled": 0,
                  "type": widget.productAttrMain.type.toString()
                }));
                ctrl.setActivedSelectList();
              },
              onSaved: (val) {}),
          SizedBox(
            width: 12.w,
          ),
          validatorInput(
              label: "Max",
              initialValue: maxNumber == 0 ? '' : maxNumber.toString(),
              validatorFn: (String value) {
                if (value == "") {
                  return null;
                }
                double val = double.parse(value == "" ? '0' : value);
                minNumber = minNumber == 0
                    ? widget.productAttrMain.numberMin.toDouble()
                    : minNumber;
                return minNumber <= val &&
                        val <= widget.productAttrMain.numberMax
                    ? null
                    : S.of(context).rangeLimitError(
                        minNumber, widget.productAttrMain.numberMax);
              },
              onChanged: (String value) {
                if (value == "" && minNumber == 0) {
                  maxNumber = 0;
                  ctrl.removeSelectedFilterItem(pvId);
                  ctrl.setActivedSelectList();
                  return;
                }
                maxNumber = double.parse(value == "" ? '0' : value);
                minNumber = minNumber == 0
                    ? widget.productAttrMain.numberMin.toDouble()
                    : minNumber;
                maxNumber = maxNumber >= minNumber
                    ? maxNumber
                    : widget.productAttrMain.numberMax.toDouble();
                ctrl.triggerSelectedFilterList(ProductAttrFilterDatum.fromJson({
                  "is_channel": widget.productAttrMain.isChannel,
                  "pv_id": pvId,
                  "pv_value": "$minNumber~$maxNumber",
                  "pn_value": widget.productAttrMain.pnValue,
                  "is_disabled": 0,
                  "type": widget.productAttrMain.type.toString()
                }));
                ctrl.setActivedSelectList();
              },
              onSaved: (val) {}),
        ]));
  }

  Widget validatorInput(
      {String label,
      String initialValue,
      Function validatorFn,
      Function onChanged,
      Function onSaved}) {
    return Container(
      width: 150.w,
      child: TextFormField(
          initialValue: initialValue,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.)?[0-9]{0,2}'))
          ],
          keyboardType: TextInputType.numberWithOptions(signed: true),
          textDirection: TextDirection.rtl,
          textAlignVertical: TextAlignVertical.center,
          onChanged: (val) {
            onChanged(val);
          },
          onSaved: (val) {
            onSaved(val);
          },
          maxLines: 1,
          style: TextStyle(color: AppColor.primaryText, fontSize: 14.sp),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String value) {
            return validatorFn(value);
          },
          decoration: InputDecoration(
              isCollapsed: true,
              prefixIcon: Align(
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                      color: AppColor.primaryLightSubTitle, fontSize: 14.sp),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
              prefixIconConstraints:
                  BoxConstraints(maxWidth: 40.w, minHeight: 48.w),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.w,
                  color: AppColor.primaryBorderHard,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
              errorMaxLines: 3,
              errorStyle: TextStyle(fontSize: 12.sp))),
    );
  }

  // 分类等checkbox类型 筛选
  Widget filterCheckboxWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ProductAttrFilterDatum property = _propertyList[index];
        if (property.isDisabled == 1) {
          return buildDisabledRadio(index);
        }
        return buildRadio(index);
      },
      itemCount: _propertyList.length,
    );
  }

  Widget buildRadio(int index) {
    CategoryTabCtrl ctrl = Provider.of<CategoryTabCtrl>(context, listen: false);
    return SizedBox(
        height: 40.w,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            _propertyList[index].pvValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColor.primaryText,
            ),
          ),
          value: ctrl.selectedFilterIdList.contains(
              "${widget.productAttrMain.pnValue}_${_propertyList[index].pvId}"),
          onChanged: (value) {
            Map<String, dynamic> _currentItem = _propertyList[index].toJson();
            _currentItem.addAll({
              "pv_id":
                  "${widget.productAttrMain.pnValue}_${_propertyList[index].pvId}",
              "origin_pv_id": _propertyList[index].pvId,
              "is_channel": widget.productAttrMain.isChannel,
              'pn_value': widget.productAttrMain.pnValue,
              'type': widget.productAttrMain.type.toString()
            });
            ctrl.triggerSelectedFilterList(
                ProductAttrFilterDatum.fromJson(_currentItem));
            ctrl.setActivedSelectList();
          },
        ));
  }

  Widget buildDisabledRadio(int index) {
    return SizedBox(
        height: 40.w,
        child: Padding(
          padding: EdgeInsets.fromLTRB(11 + 10.w, 10.w, 11 + 10.w, 0),
          child: Row(
            children: [
              Container(
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(2.w),
                    border: Border.all(
                        color: AppColor.primaryBorderOutline, width: 1.w)),
              ),
              SizedBox(
                width: 24.w,
              ),
              Expanded(
                child: Text(
                  _propertyList[index].pvValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.primaryLightSubTitle,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColor.primaryLightSubTitle,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // 图片筛选
  Widget filterImageWidget() {
    CategoryTabCtrl ctrl = Provider.of<CategoryTabCtrl>(context, listen: false);

    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12.w,
          crossAxisSpacing: 12.w,
          childAspectRatio: 98.5.w / 117.w,
        ),
        itemCount: _propertyList.length,
        itemBuilder: (context, index) {
          ProductAttrFilterDatum property = _propertyList[index];

          return GestureDetector(
              onTap: () {
                Map<String, dynamic> _currentItem =
                    _propertyList[index].toJson();
                _currentItem.addAll({
                  "pv_id":
                      "${widget.productAttrMain.pnValue}_${_propertyList[index].pvId}",
                  "origin_pv_id": _propertyList[index].pvId,
                  "is_channel": widget.productAttrMain.isChannel,
                  'pn_value': widget.productAttrMain.pnValue,
                  'type': widget.productAttrMain.type.toString()
                });
                ctrl.triggerSelectedFilterList(
                    ProductAttrFilterDatum.fromJson(_currentItem));
                ctrl.setActivedSelectList();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      AppStyle.primaryRaduis,
                    ),
                    border: Border.all(
                        width: 1.w,
                        color: ctrl.selectedFilterIdList.contains(
                                "${widget.productAttrMain.pnValue}_${_propertyList[index].pvId}")
                            ? AppColor.primaryText
                            : AppColor.primaryBorderOutline)),
                child: Column(
                  children: [
                    Container(
                        width: 90.5.w,
                        height: 60.w,
                        child: CustomNetworkImage(
                          property.imgUrl == ""
                              ? "https://img1.homary.com/filters:quality(80)/common/2021/03/21/7ae5098bbb04740f57d94030db92056b.png"
                              : property.imgUrl,
                        )),
                    Expanded(
                        child: Center(
                      child: Text(
                        property.pvValue,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.primaryText,
                          fontSize: 13.sp,
                        ),
                      ),
                    ))
                  ],
                ),
              ));
        });
  }
}
