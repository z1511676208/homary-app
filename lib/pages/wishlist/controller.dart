/*
 * @Author       : zhhjie
 * @Date         : 2021-09-06 14:22:32
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-08 15:40:58
 */
import 'package:homary/api/usercenter.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/wishlist.dart';
import 'package:homary/main.dart';
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
          name: S.of(navigatorKey.currentState.context).wishlist_recently_added,
          key: 'created_at',
          orderBy: 'desc'),
      WishlistOrderBy(
          name: S.of(navigatorKey.currentState.context).wishlist_most_popular,
          key: 'created_at',
          orderBy: 'asc'),
      WishlistOrderBy(
          name: S
              .of(navigatorKey.currentState.context)
              .wishlist_price_high_to_low,
          key: 'price',
          orderBy: 'desc'),
      WishlistOrderBy(
          name: S
              .of(navigatorKey.currentState.context)
              .wishlist_price_low_to_high,
          key: 'price',
          orderBy: 'asc')
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
