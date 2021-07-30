/*
 * @Author       : JHao
 * @Date         : 2021-07-09 19:31:26
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-29 16:30:04
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
            child: Column(children: [
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
              ))
        ])),
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
                onTap: () {},
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 10.0),
                BoxShadow(color: Colors.white, offset: Offset(0, -16)),
                BoxShadow(color: Colors.white, offset: Offset(0, 16)),
                BoxShadow(color: Colors.white, offset: Offset(-6, -16)),
                BoxShadow(color: Colors.white, offset: Offset(-6, 16)),
              ], color: Colors.white),
              width: 40.w,
              height: 24.h,
            ))
      ],
    );
  }
}
