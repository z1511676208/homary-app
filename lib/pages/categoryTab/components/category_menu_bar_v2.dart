import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/product_attr_res.dart';
import 'package:homary/pages/categoryTab/components/drop_menu_sort.dart';
import 'package:homary/pages/categoryTab/controller.dart';

class CategoryMenuBarV2 extends StatefulWidget {
  final bool showTitle;
  const CategoryMenuBarV2({Key key, this.showTitle = false}) : super(key: key);

  @override
  _CategoryMenuBarV2State createState() => _CategoryMenuBarV2State();
}

class _CategoryMenuBarV2State extends State<CategoryMenuBarV2> {
  bool _isSortOpen = false;

  @override
  Widget build(BuildContext context) {
    CategoryTabCtrl ctrl = context.watch<CategoryTabCtrl>();
    return Padding(
      padding: EdgeInsets.only(
        top: 8.w,
        left: 12.w,
        right: 12.w,
      ),
      child: Column(
        children: [
          widget.showTitle
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        ctrl.selectedCategoryId != null
                            ? '${ctrl.selectedCategoryName}'
                            : ctrl.keyword.isEmpty
                                ? S.of(context).search_view_all
                                : '${S.of(context).search_showing_results(ctrl.keyword)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Padding(
                      padding: EdgeInsets.only(top: 2.w),
                      child: Text(
                        '${ctrl.productTotal} ${S.of(context).category_items}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColor.primarySubTitle,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(height: widget.showTitle ? 12.w : 0),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.w,
                  child: ElevatedButton(
                      onPressed: () => showBottomSort(),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(AppColor.whiteBtnPressed),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0.w),
                            side: BorderSide(
                              width: 1.w,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            S.of(context).category_sortBy,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          buildIcon(
                              _isSortOpen ? Iconfont.Less : Iconfont.More2,
                              AppColor.primaryColor),
                        ],
                      )),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Container(
                  height: 40.w,
                  child: ElevatedButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor:
                          MaterialStateProperty.all(AppColor.whiteBtnPressed),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0.w),
                          side: BorderSide(
                            width: 1.w,
                            color: ctrl.hasFilter
                                ? AppColor.primaryColor
                                : AppColor.primaryText,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          ctrl.hasFilter
                              ? 'assets/images/category/class_select_yellow.png'
                              : 'assets/images/category/class_select_black.png',
                          width: 12.w,
                          height: 12.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          ctrl.outSideSelectedFilterList.isEmpty
                              ? S.of(context).category_filter
                              : '${S.of(context).category_filter}(${ctrl.outSideSelectedFilterList.length})',
                          style: TextStyle(
                            color: ctrl.hasFilter
                                ? AppColor.primaryColor
                                : AppColor.primaryText,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          buildFilter(context, ctrl),
          Divider(
            height: 0.5.w,
            color: AppColor.primaryBorderBottomLine,
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

  /// 底部弹窗更改商品排序
  void showBottomSort() async {
    setState(() {
      _isSortOpen = true;
    });
    CategoryTabCtrl ctrl = context.read<CategoryTabCtrl>();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.w),
          topRight: Radius.circular(8.w),
        ),
      ),
      builder: (BuildContext context) {
        return DropMenuSort(
          orderByList: ctrl.orderByList,
          onSelect: () {
            ctrl.changeSortBy();
          },
        );
      },
    );
    setState(() {
      _isSortOpen = false;
    });
  }

  Widget buildFilter(BuildContext context, CategoryTabCtrl ctrl) {
    if (ctrl.outSideSelectedFilterList.isEmpty) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      width: double.infinity,
      height: 28.w,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  ctrl.cleanFilter();
                },
                child: Text(
                  S.of(context).search_clearAll,
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 13.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: 12.w,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildFilterItem(ctrl.outSideSelectedFilterList[index],
                    () {
                  ctrl.removeSelectedFilterItem(
                    ctrl.outSideSelectedFilterList[index].pvId,
                    isNeedRefresh: true,
                  );
                });
              },
              childCount: ctrl.outSideSelectedFilterList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterItem(ProductAttrFilterDatum datum, Function onDelete) {
    return GestureDetector(
        onTap: onDelete,
        child: Container(
          height: 28.w,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(14.w),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          margin: EdgeInsets.only(right: 8.w),
          child: Row(
            children: [
              Text(
                '${datum.pnValue}:${datum.pvValue}',
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Padding(
                padding: EdgeInsets.all(2.w),
                child: Icon(
                  Iconfont.Delete,
                  size: 12.w,
                ),
              ),
            ],
          ),
        ));
  }
}
