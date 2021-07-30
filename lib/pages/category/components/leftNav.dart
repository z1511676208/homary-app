/*
 * @Author       : JHao
 * @Date         : 2021-07-08 10:21:44
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-30 18:47:13
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:homary/pages/category/controller.dart';
import 'package:homary/pages/category/Watcher.dart';
import 'package:homary/pages/home/contorller.dart';

class LeftNav extends StatelessWidget {
  LeftNav({Key key}) : super(key: key);

  Widget navItem(Datum data) {
    return Consumer<CategoryCtrl>(
      builder: (BuildContext context, CategoryCtrl categoryCtrl, child) {
        return GestureDetector(
            onTap: () async {
              Toast.loading();
              Watcher.refreshParams();
              categoryCtrl.setActiveCategoryId(data.categoryId);
              await categoryCtrl
                  .getCategoryList(params: {"category_id": data.categoryId});
              Toast.clear();
            },
            child: Container(
                child: Container(
              width: double.infinity,
              color: categoryCtrl.activeCategoryId == data.categoryId
                  ? Colors.white
                  : Colors.transparent,
              padding: EdgeInsets.fromLTRB(12.w, 16.w, 12.w, 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(data.categoryName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight:
                          categoryCtrl.activeCategoryId == data.categoryId
                              ? FontWeight.bold
                              : FontWeight.normal,
                    )),
              ),
            )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 103.w,
      color: AppColor.primaryNavBgColor,
      child: Selector<HomeCtrl, List<Datum>>(
        selector: (context, HomeCtrl slideNavCtrl) {
          return slideNavCtrl.topChannelList;
        },
        shouldRebuild: (pre, next) {
          return pre != next;
        },
        builder: (context, List<Datum> data, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return navItem(data[index]);
            },
            itemCount: data.length,
            // itemExtent: 52.h,
          );
        },
      ),
    );
  }
}
