import 'package:homary/common/utils/main.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';
import 'package:homary/entity/slideNav.dart';
import 'package:homary/pages/categoryTab/components/app_expansion_tile.dart';

class DropMenuCategory extends StatefulWidget {
  const DropMenuCategory({Key key, this.list, this.onSelect}) : super(key: key);

  final List<Datum> list;
  final Function(Datum) onSelect;

  @override
  _DropMenuCategoryState createState() => _DropMenuCategoryState();
}

class _DropMenuCategoryState extends State<DropMenuCategory> {

  void onCategorySelect(int level, Datum category) async {
    bool isCategory = category.jumpUrl.contains('\\/category\\/');
    if (isCategory) {
      widget.list.forEach((element) {
        cleanAllSelect(element);
      });
      category.isSelect = true;
    }

    widget.onSelect?.call(category);
    if(!isCategory){
      await Future.delayed(Duration(milliseconds: 200));
    }
    DropMenuManager.instance.hide();
  }

  void cleanAllSelect(Datum category){
    category.isSelect = false;
    if(category.subList.isEmpty){
      return;
    }
    category.subList.forEach((element) {
      cleanAllSelect(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            //一级类目
            return buildLevel(0, widget.list[index]);
          }),
    );
  }

  Widget buildLevel(int level, Datum category) {
    if (category.subList.isEmpty) {
      return buildLevelWidget(level, category);
    }
    return AppExpansionTile(
      initiallyExpanded: category.isExpand,
      onExpansionChanged: (isExpand){
        category.isExpand = isExpand;
      },
      onTap: () => onCategorySelect(level, category),
      tilePadding: EdgeInsets.only(left: 12.w + level * 18.w, right: 7.w),
      title: Text(
        category.categoryName,
        style: TextStyle(
          fontSize: 13.sp,
          color: category.isSelect ? AppColor.primaryColor : AppColor.primarySubTitle,
        ),
      ),
      trailing: Icon(
        Iconfont.DetailsPlus,
        size: 10.w,
        color: category.isSelect ? AppColor.primaryColor : AppColor.primarySubTitle,
      ),
      trailingTurn: Icon(
        Iconfont.DetailsLess,
        size: 10.w,
        color: category.isSelect ? AppColor.primaryColor : AppColor.primarySubTitle,
      ),
      children: category.subList.map((e) {
        return buildLevel(level + 1, e);
      }).toList(),
    );
  }

  Widget buildLevelWidget(int level, Datum category) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 12.w + level * 18.w, right: 7.w),
      title: Text(
        category.categoryName,
        style: TextStyle(
          fontSize: 13.sp,
          color: category.isSelect ? AppColor.primaryColor : AppColor.primarySubTitle,
        ),
      ),
      onTap: () => onCategorySelect(level, category),
    );
  }
}
