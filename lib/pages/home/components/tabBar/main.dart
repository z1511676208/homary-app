/*
 * @Author       : JHao
 * @Date         : 2021-07-09 19:31:26
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-04 14:35:38
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/home/components/tabBar/CustomUnderlineTabIndicator.dart';

class TabBarWidget extends StatefulWidget {
  final TabController _tabController;
  final List<String> _tabValues;

  TabBarWidget(this._tabController, this._tabValues, {Key key})
      : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(6.w, 0, 48.w, 0),
          height: 30.h,
          width: double.infinity,
          child: TabBar(
            controller: widget._tabController,
            tabs: widget._tabValues
                .map((e) => Text(e, style: TextStyle(fontSize: 16.sp)))
                .toList(),
            isScrollable: true,
            labelPadding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
            labelColor: AppColor.primaryText,
            unselectedLabelColor: AppColor.primarySubTitle,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicator: CustomUnderlineTabIndicator(
                width: 24.w,
                borderSide: BorderSide(
                  color: AppColor.primaryColor,
                  width: 3.h,
                ),
                strokeCap: StrokeCap.round),
            onTap: (int index) {},
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.only(right: 44.w),
            width: 8.w,
            height: 27.w,
            child: Image.asset('assets/images/home/home_nav_shadow.png'),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.only(right: 12.w),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Icon(
                Iconfont.homeNav,
                size: 20.sp,
                color: AppColor.primaryBorderOutline,
              ),
              onTap: () {
                Routes.goHome(pageIndex: 1);
              },
            ),
            width: 40.w,
            height: 24.h,
          ),
        ),
      ],
    );
  }
}
