/*
 * @Author       : zhhjie
 * @Date         : 2021-07-19 16:21:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-04 18:52:03
 */
import 'package:hexcolor/hexcolor.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import '../controller.dart';

class DefaultView extends StatelessWidget {
  const DefaultView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 16.w, right: 12.w),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Offstage(
            offstage:
                Provider.of<SearchCtrl>(context).recentSearchs.length == 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: TextStyle(
                      color: AppColor.primaryText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Provider.of<SearchCtrl>(context, listen: false)
                          .clearAll();
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                          color: AppColor.primarySubTitle, fontSize: 14.sp),
                    ))
              ],
            ),
          )),
          Selector(
            builder: (BuildContext context, List list, child) => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 20.w,
                margin: index != 0
                    ? EdgeInsets.only(top: 16.w)
                    : EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<SearchCtrl>(context, listen: false)
                            .toProductList(list[index]['name'],
                                list[index]['url'], 'event');
                        handleSchema(context, list[index]['url']);
                      },
                      child: Text(list[index]['name'],
                          style: TextStyle(
                              color: AppColor.primarySubTitle,
                              fontSize: 14.sp)),
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<SearchCtrl>(context, listen: false)
                              .removeItem(index);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 15.5.w,
                          color: AppColor.primaryDelete,
                        ))
                  ],
                ),
              );
            }, childCount: list.length)),
            selector: (BuildContext context, SearchCtrl controller) {
              return controller.recentSearchs;
            },
            shouldRebuild: (previous, next) => previous != next,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16.w,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  'Popular Searches',
                  style: TextStyle(
                      color: AppColor.primaryText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Selector(
            builder: (BuildContext context, List list, child) => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 3.w),
                  margin: EdgeInsets.only(top: 16.w),
                  child: InkWell(
                    onTap: () {
                      Provider.of<SearchCtrl>(context, listen: false)
                          .toProductList(list[index].hotWord,
                              list[index].activityUrl, 'event');
                      handleSchema(context, list[index].activityUrl);
                    },
                    child: Row(
                      children: [
                        Text(list[index].hotWord ?? '',
                            style: TextStyle(
                                color: AppColor.primarySubTitle,
                                fontSize: 14.sp)),
                        Offstage(
                          offstage: list[index].type == '1',
                          child: Icon(
                            Iconfont.Hot,
                            size: 12.w,
                            color: HexColor('#E8554F'),
                          ),
                        )
                      ],
                    ),
                  ));
            }, childCount: list.length)),
            selector: (BuildContext context, SearchCtrl controller) {
              return controller.popularSearchs;
            },
            shouldRebuild: (pre, next) {
              return pre != next;
            },
          )
        ]));
  }
}
