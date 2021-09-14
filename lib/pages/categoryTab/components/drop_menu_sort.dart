import 'package:homary/common/utils/main.dart';

// import 'package:homary/components/dropMenu/drop_menu.dart';
import 'package:homary/entity/product_attr_res.dart';

class DropMenuSort extends StatefulWidget {
  const DropMenuSort({Key key, this.orderByList, this.onSelect})
      : super(key: key);
  final List<ProductAttrOrderBy> orderByList;
  final Function onSelect;

  @override
  _DropMenuSortState createState() => _DropMenuSortState();
}

class _DropMenuSortState extends State<DropMenuSort> {
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.orderByList.length; i++) {
      if (widget.orderByList[i].isSelect) {
        _selectIndex = i;
      }
    }
  }

  void _onSelect(int index) async {
    if (_selectIndex == index) {
      return;
    }
    setState(() {
      _selectIndex = index;
      for (int i = 0; i < widget.orderByList.length; i++) {
        if (index == i) {
          widget.orderByList[i].isSelect = true;
        } else {
          widget.orderByList[i].isSelect = false;
        }
      }
    });
    widget.onSelect?.call();
    await Future.delayed(Duration(milliseconds: 200));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50.w,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    S.of(context).category_sortBy,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Image.asset(
                        'assets/images/home/popup_close.png',
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: widget.orderByList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onSelect(index),
                child: Container(
                  height: 44.w,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.orderByList[index].name,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: _selectIndex == index
                              ? AppColor.primaryColor
                              : AppColor.primaryText,
                        ),
                      ),
                      SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: Radio(
                          value: index,
                          groupValue: _selectIndex,
                          onChanged: (value){
                            _onSelect(value);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
