/*
 * @Author       : zhhjie
 * @Date         : 2021-09-06 14:22:32
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-06 18:31:24
 */
import 'package:homary/api/usercenter.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/wishlist.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WishlistCtrl with ChangeNotifier {
  List<ModuleDataProductList> list = [];
  bool isLoading = false;
  int hasMorePage = 0;
  List<WishlistOrderBy> orderByList = [];

  /// 页码
  int page = 1;
  int size = 8;

  //排序
  String sort = "";
  String orderSort = "";

  bool _isDispose = false;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void dispose() {
    super.dispose();
    _isDispose = true;
  }

  void _safeNotifyListeners() {
    if (_isDispose) {
      return;
    }
    notifyListeners();
  }

  void reset() {
    this.list = [];
    this.page = 1;
    this.hasMorePage = 0;
  }

  void initOrderByList() {
    this.orderByList = [
      WishlistOrderBy(
          name: 'Recently Added', key: 'created_at', orderBy: 'desc'),
      WishlistOrderBy(name: 'Most Popular', key: 'created_at', orderBy: 'asc'),
      WishlistOrderBy(name: 'Price High to Low', key: 'price', orderBy: 'desc'),
      WishlistOrderBy(name: 'Price Low to High', key: 'price', orderBy: 'asc')
    ];
  }

  Future getList() async {
    Toast.loading();
    DioResult res = await UserCenterApi.getWistList(params: {
      "page": page,
      "page_size": size,
      "sort": sort,
      "order_sort": orderSort
    });
    Toast.clear();
    if (res.error == null) {
      WishlistRes result = WishlistRes.fromJson(res.result);
      this.list.addAll(result.data.skuList);
      hasMorePage = result.data.hasMorePage;
      if (hasMorePage == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _safeNotifyListeners();
    }
  }

  Future<void> wishCancel(params) async {
    DioResult res = await UserCenterApi.wishCancel(params: params);
    if (res.error == null) {
      this.list = [];
      _safeNotifyListeners();
    }
  }

  Future handleGetMoreWish() async {
    this.page += 1;
    await getList();
  }

  void changeSortBy() {
    orderByList.forEach((element) {
      if (element.isSelect) {
        sort = element.key;
        orderSort = element.orderBy;
      }
    });
    reset();
    getList();
  }
}
