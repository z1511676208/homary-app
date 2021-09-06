/*
 * @Author       : zhhjie
 * @Date         : 2021-09-06 17:15:41
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-06 18:37:31
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';
import 'package:homary/entity/wishlist.dart';

class WishDropMenuSort extends StatefulWidget {
  const WishDropMenuSort({Key key, this.orderByList, this.onSelect})
      : super(key: key);
  final List<WishlistOrderBy> orderByList;
  final Function onSelect;

  @override
  _WishDropMenuSortState createState() => _WishDropMenuSortState();
}

class _WishDropMenuSortState extends State<WishDropMenuSort> {
  int _selectIndex = -1;

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
