import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/product_attr_res.dart';

class FilterProperty extends StatelessWidget {
  const FilterProperty({Key key, this.productAttrMain})
      : super(key: key);

  final ProductAttrMain productAttrMain;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: productAttrMain.isExpand,
        onExpansionChanged: (isExpand){
          productAttrMain.isExpand = isExpand;
        },
        iconColor: AppColor.primaryText,
        collapsedIconColor: AppColor.primaryText,
        title: Text(
          productAttrMain.pnValue ?? '',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          _PropertyWidget(
            propertyList: productAttrMain.filterData,
          ),
          Container(
            height: 10.w,
            color: AppColor.primaryBackground,
            margin: EdgeInsets.only(top: 20.w),
          ),
        ],
      ),
    );
  }
}

class _PropertyWidget extends StatefulWidget {
  const _PropertyWidget({Key key, this.propertyList}) : super(key: key);

  final List<ProductAttrFilterDatum> propertyList;

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
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12.w,
          crossAxisSpacing: 12.w,
          childAspectRatio: 96 / 30,
        ),
        itemCount: _propertyList.length,
        itemBuilder: (context, index) {
          ProductAttrFilterDatum property = _propertyList[index];
          if (property.isSelect) {
            return buildSelectedRadio(index);
          }
          return buildRadio(index);
        });
  }

  Widget buildRadio(int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _propertyList[index].isSelect = true;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: AppColor.primaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
        ),
      ),
      child: Text(
        _propertyList[index].pvValue,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColor.primaryText,
        ),
      ),
    );
  }

  Widget buildSelectedRadio(int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _propertyList[index].isSelect = false;
        });
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
        ),
        side: BorderSide(
          width: 1.w,
          color: AppColor.primaryColor,
        ),
      ),
      child: Text(
        _propertyList[index].pvValue,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
