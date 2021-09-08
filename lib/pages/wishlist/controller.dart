/*
 * @Author       : zhhjie
 * @Date         : 2021-09-06 14:22:32
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-08 15:24:33
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
  Map<String, int> wishlistParams = {"page": 1, "page_size": 10};

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
    this.wishlistParams = {"page": 1, "page_size": 10};
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

  Future getList({params}) async {
    if (params == null) {
      wishlistParams = {"page": 1, "page_size": 10};
    }
    DioResult res = await UserCenterApi.getWistList(params: {
      "page": wishlistParams['page'],
      "page_size": wishlistParams['size'],
      "sort": sort,
      "order_sort": orderSort
    });
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
    wishlistParams['page'] += 1;
    await getList(params: wishlistParams);
  }

  Future<void> changeSortBy() async {
    orderByList.forEach((element) {
      if (element.isSelect) {
        sort = element.key;
        orderSort = element.orderBy;
      }
    });
    reset();
    Toast.loading();
    await getList();
    Toast.clear();
  }
}
