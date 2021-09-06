import 'dart:convert';

import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';
import 'package:homary/entity/slideNav.dart';
import 'package:homary/pages/categoryTab/components/drop_menu_category.dart';
import 'package:homary/pages/categoryTab/components/drop_menu_sort.dart';
import 'package:homary/pages/categoryTab/controller.dart';

class CategoryMenuBar extends StatefulWidget {
  const CategoryMenuBar({Key key, this.isSearchPage = false}) : super(key: key);

  final bool isSearchPage;

  @override
  _CategoryMenuBarState createState() => _CategoryMenuBarState();
}

class _CategoryMenuBarState extends State<CategoryMenuBar> {
  GlobalKey _key = GlobalKey();

  bool _isCategoryOpen = false;
  bool _isSortOpen = false;

  void controlMenu(int menuIndex) {
    CategoryTabCtrl ctrl = context.read<CategoryTabCtrl>();
    DropMenuManager.instance.showDropDownMenu(
      context,
      id: menuIndex,
      marginTop:
          DropMenuManager.instance.getWeightMarginTop(_key.currentContext),
      menuBarHeight: 46.5.w,
      menuHeight: menuIndex == 1 ? 220.w : 300.w,
      menu: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.w)),
        ),
        child: menuIndex == 1
            ? DropMenuSort(
                orderByList: ctrl.orderByList,
                onSelect: () {
                  ctrl.changeSortBy();
                },
              )
            : DropMenuCategory(
                list: context.read<CategoryTabCtrl>().categoryList,
                onSelect: (Datum datum) {
                  Map urlMap = getSchemaParams(datum.jumpUrl);
                  Map content = jsonDecode(urlMap['params']['content']);
                  String url = content['url'];
                  if(url == null){
                    return;
                  }
                  if (!widget.isSearchPage && url.contains('/category/')) {
                    ctrl.changeCategory(datum);
                    return;
                  }
                  handleSchema(context, datum.jumpUrl,
                      appBarTitle: datum.categoryName);
                },
              ),
      ),
      onRemove: () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {
            if (menuIndex == 0) {
              _isCategoryOpen = false;
            } else {
              _isSortOpen = false;
            }
          });
        });
      },
    );
    setState(() {
      if (menuIndex == 0) {
        _isCategoryOpen = true;
      } else {
        _isSortOpen = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CategoryTabCtrl ctrl = context.watch<CategoryTabCtrl>();
    return Column(
      children: [
        Container(
          height: 46.5.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Text(
                    '${ctrl.productTotal} ${S.of(context).category_items}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.primarySubTitle,
                    ),
                  ),
                ),
              ),
              buildSelectWidget(
                  S.of(context).category,
                  ctrl.selectedCategoryId != null
                      ? AppColor.primaryColor
                      : AppColor.primaryText,
                  buildIcon(
                    _isCategoryOpen ? Iconfont.Less : Iconfont.More2,
                    ctrl.selectedCategoryId != null
                        ? AppColor.primaryColor
                        : AppColor.primaryText,
                  ),
                  () => controlMenu(0)),
              SizedBox(
                width: 20.w,
              ),
              buildSelectWidget(
                  S.of(context).category_sortBy,
                  AppColor.primaryColor,
                  buildIcon(_isSortOpen ? Iconfont.Less : Iconfont.More2,
                      AppColor.primaryColor),
                  () => controlMenu(1)),
              SizedBox(
                width: 20.w,
              ),
              Builder(builder: (context) {
                return buildSelectWidget(
                    S.of(context).category_filter,
                    ctrl.hasFilter
                        ? AppColor.primaryColor
                        : AppColor.primaryText,
                    Image.asset(
                      ctrl.hasFilter
                          ? 'assets/images/category/class_select_yellow.png'
                          : 'assets/images/category/class_select_black.png',
                      width: 12.w,
                      height: 12.w,
                    ), () {
                  DropMenuManager.instance.hide();
                  Scaffold.of(context).openEndDrawer();
                });
              }),
            ],
          ),
        ),
        Divider(
          key: _key,
          height: 0.5.w,
          color: AppColor.primaryBorderBottomLine,
        ),
      ],
    );
  }

  Widget buildSelectWidget(
      String text, Color textColor, Widget icon, Function onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, bottom: 2.w),
            child: icon,
          ),
        ],
      ),
    );
  }

  Widget buildIcon(IconData iconData, Color color) {
    return Icon(
      iconData,
      size: 10.w,
      color: color,
    );
  }
}
