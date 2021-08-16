import 'package:homary/common/utils/main.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';
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
    if(_selectIndex == index){
      return;
    }
    widget.onSelect?.call();
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
    await Future.delayed(Duration(milliseconds: 200));
    DropMenuManager.instance.hide();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              horizontal: 20.w,
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
                Visibility(
                  visible: _selectIndex == index,
                  child: Icon(
                    Iconfont.Tick,
                    color: AppColor.primaryColor,
                    size: 13.w,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
