import 'package:homary/api/order.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/after_order_orders_res.dart';
import 'package:homary/entity/orders_res.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyOrdersTabCtrl extends ChangeNotifier {
  final String orderStatus;

  bool get isOrders => orderStatus != 'returns';

  /// 页码
  int page = 1;
  int size = 20;

  /// 是否显示空布局
  bool isShowEmpty = false;

  List<OrdersResElement> list = [];
  List<AfterSaleOrdersResElement> afterSaleList = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  MyOrdersTabCtrl(this.orderStatus) {
    init();
  }

  void init() async {
    Toast.loading();
    await getOrderList();
    Toast.clear();
  }

  Future<void> getOrderList({bool isNeedClean = false}) async {
    DioResult result;
    if (isOrders) {
      result = await OrderApi.getOrdersList(params: {
        'page': page++,
        'page_size': size,
        'order_status': orderStatus,
      });
    } else {
      result = await OrderApi.getAfterSaleOrdersList(params: {
        'page': page++,
        'page_size': size,
      });
    }
    if (result.error == null) {
      if (isNeedClean) {
        list = [];
        afterSaleList = [];
      }
      if (isOrders) {
        OrdersRes res = OrdersRes.fromJson(result.result);
        list = [...list, ...res.data.list];
        _handleRefresh(res.data.list, res.data.count);
      } else {
        AfterSaleOrdersRes res = AfterSaleOrdersRes.fromJson(result.result);
        afterSaleList = [...afterSaleList, ...res.data.list];
        _handleRefresh(res.data.list, res.data.count);
      }
      refreshController.refreshCompleted();
      notifyListeners();
    }
  }

  void _handleRefresh(List list, dynamic count) {
    isShowEmpty = count is String ? count == '0' : count == 0;
    if (list.length < size) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
  }

  void refresh() async {
    page = 1;
    await getOrderList(isNeedClean: true);
  }

  /// 确认收货
  Future<bool> confirmReceipt(String orderNo) async {
    Toast.loading();
    final result = await OrderApi.confirmReceipt(params: {
      'order_no': orderNo,
      'source': 1,
    });
    if (result.error == null) {
      Toast.clear();
      return true;
    }

    return false;
  }

  /// 确认收货
  Future<bool> cancelOrder(String orderNo, String reason) async {
    Toast.loading();
    final result = await OrderApi.cancelOrder(params: {
      'order_no': orderNo,
      'closed_reason': reason,
      'source': 1,
    });
    if (result.error == null) {
      Toast.clear();
      return true;
    }

    return false;
  }

  /// 确认收货
  Future<void> addCart(List<Map> goods) async {
    Toast.loading();
    for (int i = 0; i < goods.length; i++) {
      await OrderApi.addCart(params: goods[i]);
    }
    Toast.clear();
  }

  /// 订单退款
  Future<bool> refundOrder(String orderNo, String reason) async {
    Toast.loading();
    final result = await OrderApi.refundOrder(params: {
      'order_no': orderNo,
      'closed_reason': reason,
    });
    if (result.error == null) {
      Toast.clear();
      return true;
    }

    return false;
  }
}
