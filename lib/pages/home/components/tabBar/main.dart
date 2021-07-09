import 'package:homary/common/utils/main.dart';

class TabBarWidget extends StatefulWidget {
  final TabController _tabController;
  final List<String> _tabValues;

  TabBarWidget(this._tabController, this._tabValues, {Key key})
      : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            child: Column(children: [
          Container(
            padding: EdgeInsets.only(right: 20.w),
            height: 30.h,
            width: double.infinity,
            child: TabBar(
                controller: widget._tabController,
                tabs: widget._tabValues
                    .map((e) => Text(e, style: TextStyle(fontSize: 14.sp)))
                    .toList(),
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xFF666666),
                indicatorWeight: 3.h,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 8.w),
                indicatorSize: TabBarIndicatorSize.label),
          )
        ])),
        Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(20, 0, 0, 0),
                    offset: Offset(-6.0, 0.0),
                    blurRadius: 4.0,
                    spreadRadius: 0)
              ], color: Colors.white),
              width: 30.w,
              height: 30.h,
            ))
      ],
    );
  }
}
