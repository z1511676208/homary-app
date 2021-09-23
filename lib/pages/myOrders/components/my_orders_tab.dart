import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/pages/myOrders/components/after_sale_item.dart';
import 'package:homary/pages/myOrders/components/my_orders_item.dart';
import 'package:homary/pages/myOrders/components/my_orders_tab_controller.dart';
import 'package:homary/pages/myOrders/components/orders_emtpy.dart';

class MyOrdersTab extends StatefulWidget {
  const MyOrdersTab({Key key, this.orderStatus}) : super(key: key);

  final String orderStatus;

  @override
  _MyOrdersTabState createState() => _MyOrdersTabState();
}

class _MyOrdersTabState extends State<MyOrdersTab>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  bool showBackTopButton = false;

  void _handleScroll() {
    if (_scrollController.offset >= 250 && showBackTopButton == false) {
      setState(() {
        showBackTopButton = true;
      });
    } else if (_scrollController.offset < 250 && showBackTopButton == true) {
      setState(() {
        showBackTopButton = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyOrdersTabCtrl(widget.orderStatus),
      child: Stack(
        children: [
          buildList(),
          buildGoTop(),
        ],
      ),
    );
  }

  Widget buildList() {
    return Container(
      color: AppColor.primaryBackground,
      child: Consumer<MyOrdersTabCtrl>(
        builder: (_, ctrl, __) {
          return PullToRefresh(
            onRefresh: ctrl.refresh,
            onLoading: ctrl.getOrderList,
            controller: ctrl.refreshController,
            enablePullUp: !ctrl.isShowEmpty,
            child: ctrl.isShowEmpty
                ? OrdersEmpty()
                : ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              itemCount: ctrl.isOrders
                  ? ctrl.list.length
                  : ctrl.afterSaleList.length,
              itemBuilder: (context, index) {
                if (ctrl.isOrders) {
                  return MyOrderItem(res: ctrl.list[index]);
                }
                return AfterSaleItem(res: ctrl.afterSaleList[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildGoTop() {
    if (!showBackTopButton) {
      return Container();
    }
    return Positioned(
      bottom: 100.w,
      right: 20.w,
      child: GoTopMenu(
        scrollController: _scrollController,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
