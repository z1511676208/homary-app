/*
 * @Author       : JHao
 * @Date         : 2021-07-08 10:21:44
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-31 14:09:03
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:homary/pages/category/controller.dart';
import 'package:homary/pages/category/watcher.dart';
import 'package:homary/pages/home/contorller.dart';

class LeftNav extends StatelessWidget {
  LeftNav({Key key}) : super(key: key);

  Widget navItem(TopChannelDatum data) {
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
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(12.w, 0.w, 12.w, 0.w),
              height: 52.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(data.categoryName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
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
      child: Selector<HomeCtrl, List<TopChannelDatum>>(
        selector: (context, HomeCtrl slideNavCtrl) {
          return slideNavCtrl.topChannelList;
        },
        shouldRebuild: (pre, next) {
          return pre != next;
        },
        builder: (context, List<TopChannelDatum> data, child) {
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
