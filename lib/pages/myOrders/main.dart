import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/pages/home/components/tabBar/CustomUnderlineTabIndicator.dart';
import 'package:homary/pages/myOrders/components/my_orders_tab.dart';

class MyOrdersPage extends StatelessWidget {
  MyOrdersPage({Key key, this.active = 'all'}) : super(key: key);

  final String active;

  final List<_MyOrdersPageEntity> tabList = [];

  void initTabData(BuildContext context) {
    tabList.add(_MyOrdersPageEntity(
      displayName: S.of(context).my_orders_all_orders,
      orderStatus: 'all',
      active: 'all',
    ));
    tabList.add(_MyOrdersPageEntity(
      displayName: S.of(context).my_orders_pending,
      orderStatus: '0',
      active: 'unpaid',
    ));
    tabList.add(_MyOrdersPageEntity(
      displayName: S.of(context).my_orders_processing,
      orderStatus: '2',
      active: 'undelivery',
    ));
    tabList.add(_MyOrdersPageEntity(
      displayName: S.of(context).my_orders_partially_shipped,
      orderStatus: '8',
      active: 'partiallyShipped',
    ));
    tabList.add(_MyOrdersPageEntity(
      displayName: S.of(context).my_orders_shipped,
      orderStatus: '9',
      active: 'shipped',
    ));
    tabList.add(_MyOrdersPageEntity(
      displayName: S.of(context).my_orders_return,
      orderStatus: 'returns',
      active: 'returns',
    ));
  }

  @override
  Widget build(BuildContext context) {
    initTabData(context);
    return Scaffold(
      appBar: GoBackAppBar(
        title: S.of(context).usercenter_myOrder,
        showBorder: false,
      ),
      body: DefaultTabController(
        initialIndex: tabList
            .indexOf(tabList.firstWhere((element) => element.active == active)),
        length: tabList.length,
        child: Column(
          children: [
            TabBar(
              tabs: tabList.map((e) {
                return Tab(
                  text: e.displayName,
                );
              }).toList(),
              isScrollable: true,
              labelColor: AppColor.primaryText,
              unselectedLabelColor: AppColor.primaryText,
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Urbanist',
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
              ),
              indicator: CustomUnderlineTabIndicator(
                  width: 30.w,
                  insets: EdgeInsets.fromLTRB(0, 0, 0, 4.w),
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                    width: 3.h,
                  ),
                  strokeCap: StrokeCap.round),
            ),
            Expanded(
              child: TabBarView(
                children: tabList.map((e) {
                  return MyOrdersTab(orderStatus: e.orderStatus);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyOrdersPageEntity {
  final String displayName;
  final String orderStatus;
  final String active;

  _MyOrdersPageEntity({this.displayName, this.orderStatus, this.active});
}
